Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <natanael.copa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH v3] various header include fixes for building with musl libc
Date: Wed, 22 Jan 2014 21:20:38 +0000
Message-Id: <1390425638-15241-1-git-send-email-ncopa@alpinelinux.org>
In-Reply-To: <CAJdJm_MB5gAK2-9--n=P-Mni1WBRK8o-zaLSkA=_+0Bc6cCVjQ@mail.gmail.com>
References: <CAJdJm_MB5gAK2-9--n=P-Mni1WBRK8o-zaLSkA=_+0Bc6cCVjQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

we need:
 sys/stat.h for mode_t
 limits.h for PATH_MAX

Fixes compile errors:
In file included from tools/hciconfig.c:45:0:
./src/textfile.h:27:1: error: unknown type name 'mode_t'
 int create_file(const char *filename, const mode_t mode);
 ^

tools/csr_usb.c: In function 'read_value':
tools/csr_usb.c:71:12: error: 'PATH_MAX' undeclared (first use in this function)
  char path[PATH_MAX];
            ^
---
Changes v2 -> v3:
 - include the sys/stat.h in hciconfig.c instead of textfile.h. This was
   the only needed change for defining mode_t everywhere.

 tools/csr_usb.c   | 1 +
 tools/hciconfig.c | 1 +
 tools/hid2hci.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/csr_usb.c b/tools/csr_usb.c
index a483bc1..5fb6bdc 100644
--- a/tools/csr_usb.c
+++ b/tools/csr_usb.c
@@ -33,6 +33,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <dirent.h>
+#include <limits.h>
 #include <sys/ioctl.h>
 
 #include "csr.h"
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 6c7f8ed..a81dc9c 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -37,6 +37,7 @@
 #include <sys/param.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index 95b4abf..2dbfca7 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -35,6 +35,7 @@
 #include <string.h>
 #include <dirent.h>
 #include <getopt.h>
+#include <limits.h>
 #include <sys/ioctl.h>
 #include <linux/types.h>
 #include <linux/hiddev.h>
-- 
1.8.5.3

