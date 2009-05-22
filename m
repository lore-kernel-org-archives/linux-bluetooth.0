Return-Path: <cyrus@holtmann.org>
From: Alexander Holler <holler@ahsoftware.de>
To: linux-bluetooth@vger.kernel.org
Cc: Alexander Holler <holler@ahsoftware.de>
Subject: [PATCH 1/1] BTWinLinkKeyExport - Tool to export link-keys stored by the WIDCOMM stack
Date: Fri, 22 May 2009 15:38:41 +0200
Message-Id: <1242999521-8303-1-git-send-email-holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've used this for dualboot-systems because I didn't want to
pair the devices every time I've switched systems.

Currently it exports the keys using the old bluez format with files
named 'link_key' and 'linkkeys'. To use it with newer versions of bluez
it has either to be modified or someone has to write an import.
---
 tools/windows/BTWinLinkKeyExport.cpp |  210 ++++++++++++++++++++++++++++++++++
 1 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 tools/windows/BTWinLinkKeyExport.cpp

diff --git a/tools/windows/BTWinLinkKeyExport.cpp b/tools/windows/BTWinLinkKeyExport.cpp
new file mode 100644
index 0000000..deadabe
--- /dev/null
+++ b/tools/windows/BTWinLinkKeyExport.cpp
@@ -0,0 +1,210 @@
+//
+// BTWinLinkKeyExport.cpp
+//
+// Exports bluetooth-link-keys stored by the WIDCOMM stack for use with
+// Dual- or Multi-booting systems.
+//
+// Written 2004 by Alexander Holler.
+//
+// This source is free in every aspect. You can use, modify, distribute
+// or sell it at your wish. You can even replace my name with yours if
+// that would earn you some credits you otherwise wouldn't get.
+//
+// No warrantys are given. This software might destroy your hardware,
+// software or datas.
+//
+// This software uses functions like sscanf() and such bad things,
+// feel free to make it safe up to point your security-officer wants it.
+//
+// To compile it I've used the free Borland Compiler, but it should work using
+// any compiler. For bcc I've used the following few lines:
+//
+// path=%path%;d:\Programme\Borland\Bcc55\bin
+// bcc32 -O2 -DNDEBUG -c BTWinLinkKeyExport.cpp
+// bcc32 -O2 -DNDEBUG BTWinLinkKeyExport.obj
+//
+// (WIDCOMM is a registered trademark of WIDCOMM Inc. and
+// Borland is a trademark of Borland Software Corporation)
+//
+
+#include <stdio.h>
+#include <string.h>
+#include <time.h>
+#include <string>
+
+#include <windows.h>
+#include <wincrypt.h>
+
+typedef unsigned char uint8_t;
+
+#pragma pack(1)
+
+typedef struct {
+  uint8_t b[6];
+} bdaddr_t;
+
+#pragma pack(4)
+
+struct link_key {
+  bdaddr_t sba; // Dongle address
+  bdaddr_t dba; // external Device address
+  uint8_t key[16];
+  uint8_t type;
+  time_t  time;
+};
+
+#pragma pack()
+
+static char* local_device;
+
+static void displayLastError(void)
+{
+  LPVOID lpMsgBuf;
+  DWORD msgid=GetLastError();
+  if (!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
+    FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
+    NULL, msgid, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
+    (LPTSTR) &lpMsgBuf, 0, NULL ))
+    return;
+  fprintf(stderr, "Error %u: %s\n", msgid, lpMsgBuf);
+  LocalFree( lpMsgBuf );
+}
+
+static int exportKey(const char* regkeyname, HCRYPTPROV& hProv, FILE* file,
+  FILE* file2)
+{
+  // This function tries to read the registry entry linkkey, decrypts it and
+  // writes an entry to the link-key-file for linux
+  std::string s=std::string("SOFTWARE\\Widcomm\\BTConfig\\Devices\\") +
+    regkeyname;
+  HKEY rKey=NULL;
+  long rc=RegOpenKeyEx(HKEY_LOCAL_MACHINE, s.c_str(), 0, KEY_READ, &rKey);
+  if(rc!=ERROR_SUCCESS) {
+    LPVOID lpMsgBuf;
+    if(!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
+      FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
+      NULL, rc, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR) &lpMsgBuf,
+      0, NULL ))
+      return 0;
+    fprintf(stderr, "Error %u: %s\n", rc, lpMsgBuf);
+    LocalFree( lpMsgBuf );
+    return 1;
+  }
+  BYTE keybuf[1024]; // I'm lazy, fixed size
+  DWORD keybuflen=sizeof(keybuf);
+  DWORD type;
+  rc=RegQueryValueEx(rKey, "LinkKey", NULL, &type, keybuf, &keybuflen);
+  RegCloseKey(rKey);
+  if(rc!=ERROR_SUCCESS)
+    return 0; // No error, just no link key
+  // If anyone wants to implement boundary checks for keybuf,
+  // he has my permissions. ;)
+  DWORD dwDataLen=*((DWORD*)(keybuf+4));
+  unsigned char *importkey=keybuf+8;
+  HCRYPTKEY hKey = NULL;
+  if(!CryptImportKey(hProv, importkey, dwDataLen, 0, 0, &hKey)) {
+    displayLastError();
+    return 2;
+  }
+  unsigned char* realkey=importkey+dwDataLen+4;
+  DWORD dwDataLen2=*((DWORD*)(realkey-4));
+  BYTE* newkey=(BYTE*)malloc(dwDataLen2);
+  memcpy(newkey, realkey, dwDataLen2);
+  if(!CryptDecrypt(hKey, 0, 1, 0, newkey, &dwDataLen2 )) {
+    displayLastError();
+    CryptDestroyKey(hKey);
+    return 3;
+  }
+  CryptDestroyKey(hKey);
+  struct link_key lkey;
+  memset(&lkey, 0, sizeof(lkey));
+  unsigned adr[6];
+  if(sscanf(regkeyname, "%x:%x:%x:%x:%x:%x", &adr[0], &adr[1], &adr[2],
+    &adr[3],&adr[4], &adr[5])!= 6)
+    return 4;
+  for(int i=0; i<6; i++)
+    lkey.dba.b[5-i]=adr[i];
+  if(sscanf(local_device, "%x:%x:%x:%x:%x:%x", &adr[0], &adr[1], &adr[2],
+    &adr[3],&adr[4], &adr[5])!= 6)
+    return 5;
+  for(int i=0; i<6; i++)
+    lkey.sba.b[5-i]=adr[i];
+  for(int i=0; i<16; i++)
+    lkey.key[i]=newkey[dwDataLen2-1-i];
+  lkey.time=time(NULL); // We are faking as this is not needed for operation
+  lkey.type=0; // I don't know the types, but my devices are all having 0
+  if(fwrite(&lkey, sizeof(lkey), 1, file)!=1)
+    return 6;
+  for(int i=0; i<17; i++)
+    // I haven't checked if bluez treads them case insensitiv, so we are
+    // exporting them like they were originally found in bluez (uppercase)
+    fprintf(file2, "%c", toupper(regkeyname[i]));
+  fprintf(file2, " ");
+  for(int i=0; i<16; i++)
+    fprintf(file2, "%02X", lkey.key[i]);
+  fprintf(file2, " 0%c", 0x0a);
+  printf("Link key for %s exported.\n", regkeyname);
+  return 0;
+}
+
+static void showHelp(void)
+{
+  printf("\nBTLinkKeyExport V1.0\nWritten 2004 Alexander Holler\n"
+      "Free in every aspect. See the source for details.\n\n");
+  printf("  Usage: BTLinkKeyExport localDeviceMAC\n");
+  printf("  Where localDeviceMAC is in the form xx:xx:xx:xx:xx:xx\n");
+}
+
+int main(int argc, char **argv)
+{
+  if(argc!=2) {
+    showHelp();
+    return 1;
+  }
+  if(strlen(argv[1])!=17) {
+    showHelp();
+    return 2;
+  }
+  local_device=argv[1];
+  FILE* file=fopen("link_key", "wb");
+  if(!file) {
+    fprintf(stderr, "Unable to open file 'link_key' for writing!\n");
+    return 3;
+  }
+  FILE* file2=fopen("linkkeys", "wb");
+  if(!file2) {
+    fprintf(stderr, "Unable to open file 'linkkeys' for writing!\n");
+    return 3;
+  }
+  const char* provider="Microsoft Base Cryptographic Provider v1.0";
+  const char* container="Widcomm Bluetooth Key Container Name";
+  HCRYPTPROV hProv = NULL;
+  if(!CryptAcquireContext(&hProv, container, provider, 1 /* dwProviderType */,
+    0x20 /* dwFlags */ )) {
+    displayLastError();
+    fclose(file);
+    return 4;
+  }
+  HKEY rKey;
+  RegOpenKeyEx(HKEY_LOCAL_MACHINE, "Software\\Widcomm\\BTConfig\\Devices", 0,
+    KEY_READ, &rKey);
+  int ret=0;
+  for(unsigned i=0; ; i++) {
+    char rkeyname[255];
+    DWORD rkeynamelen=sizeof(rkeyname);
+    FILETIME ftLastWriteTime;
+    int rc=RegEnumKeyEx(rKey, i, rkeyname, &rkeynamelen, NULL, NULL, NULL,
+      &ftLastWriteTime);
+    if(rc!=ERROR_SUCCESS)
+      break;
+    ret=exportKey(rkeyname, hProv, file, file2);
+    if(ret) {
+      ret+=4;
+      break; // An error occured
+    }
+  }
+  RegCloseKey(rKey);
+  CryptReleaseContext(hProv, 0);
+  fclose(file);
+  return ret;
+}
-- 
1.6.0.4

