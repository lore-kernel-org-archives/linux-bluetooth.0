Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 6 Aug 2014 20:09:37 +0200
Message-ID: <CAGMFpRdQiTQ_Wq4fn2bNM5ORR0mZ0rtNe=QrR38hb2RdaF9JTQ@mail.gmail.com>
Subject: Hid 2 hci switch on Cambridge Silicon Radio CN-524 (idVendor=0a12, idProduct=100b)
From: Fred De Backer <debacker.fred@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Fred De Backer <debacker.fred@gmail.com>
Content-Type: multipart/mixed; boundary=089e0102f6c60db1b704fff9e0ca
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--089e0102f6c60db1b704fff9e0ca
Content-Type: text/plain; charset=UTF-8

Hi,

Since I could not find solution on the net to switch USB bluetooth
device Sitecom CN-524 (aka Cambridge Silicon Radio CN-524;
idVendor=0a12, idProduct=100b) from HID to HCI mode, I made patch
myself after sniffing USB messages that Windows driver sends.
Since I'm not expert in programming, nor USB or bluetooth, the code
maybe imperfect. I'm sending anyway so someone could
review/adapt/improve and maybe even include in newer release.
My capture of Windows sending the switch is available on request...

debian:/home/user/src/bluez-5.21/tools# diff -u hid2hci.c.orig hid2hci.c
--- hid2hci.c.orig    2014-03-11 12:20:34.000000000 +0100
+++ hid2hci.c    2014-08-05 10:45:00.000000000 +0200
@@ -119,6 +119,37 @@
     return err;
 }

+static int usb_switch_csr2(int fd, enum mode mode)
+{
+    char data[] = { 0x01, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+    struct usbfs_disconnect disconnect;
+        int err;
+
+    switch (mode) {
+    case HCI:
+        //OK.
+        break;
+    case HID:
+        //Not implemented!
+        printf("Switch to HID not implemented!\r\n");
+        return -1;
+    }
+
+    disconnect.interface = 0;
+    disconnect.flags = USBFS_DISCONNECT_EXCEPT_DRIVER;
+    strcpy(disconnect.driver, "usbfs");
+
+    if (ioctl(fd, USBFS_IOCTL_DISCONNECT, &disconnect) < 0) {
+        fprintf(stderr, "Can't claim interface: %s (%d)\n",
+                        strerror(errno), errno);
+        return -1;
+    }
+
+    err = control_message(fd, USB_ENDPOINT_OUT | USB_TYPE_CLASS |
USB_RECIP_INTERFACE, USB_REQ_SET_CONFIGURATION, 0x0301, 0, data,
sizeof(data), 10000);
+
+    return err;
+}
+
 static int hid_logitech_send_report(int fd, const char *buf, size_t size)
 {
     struct hiddev_report_info rinfo;
@@ -258,7 +289,7 @@
     printf("Usage: hid2hci [options]\n"
         "  --mode=       mode to switch to [hid|hci] (default hci)\n"
         "  --devpath=    sys device path\n"
-        "  --method=     method to use to switch [csr|logitech-hid|dell]\n"
+        "  --method=     method to use to switch
[csr|csr2|logitech-hid|dell]\n"
         "  --help\n\n");
 }

@@ -274,6 +305,7 @@
     enum method {
         METHOD_UNDEF,
         METHOD_CSR,
+                METHOD_CSR2,
         METHOD_LOGITECH_HID,
         METHOD_DELL,
     } method = METHOD_UNDEF;
@@ -311,6 +343,9 @@
             if (!strcmp(optarg, "csr")) {
                 method = METHOD_CSR;
                 usb_switch = usb_switch_csr;
+            } else if (!strcmp(optarg, "csr2")) {
+                method = METHOD_CSR2;
+                usb_switch = usb_switch_csr2;
             } else if (!strcmp(optarg, "logitech-hid")) {
                 method = METHOD_LOGITECH_HID;
             } else if (!strcmp(optarg, "dell")) {
@@ -344,6 +379,7 @@

     switch (method) {
     case METHOD_CSR:
+    case METHOD_CSR2:
     case METHOD_DELL: {
         struct udev_device *dev;
         int handle;
debian:/home/user/src/bluez-5.21/tools# diff -u hid2hci.rules.orig hid2hci.rules
--- hid2hci.rules.orig    2014-08-05 09:01:22.000000000 +0200
+++ hid2hci.rules    2014-08-05 10:57:16.000000000 +0200
@@ -27,5 +27,6 @@

 # CSR devices
 ATTR{idVendor}=="0a12|0458|05ac", ATTR{idProduct}=="1000",
RUN+="hid2hci --method=csr --devpath=%p"
+ATTR{idVendor}=="0a12", ATTR{idProduct}=="100b", RUN+="hid2hci
--method=csr2 --devpath=%p"

 LABEL="hid2hci_end"
debian:/home/user/src/bluez-5.21/tools#


debian:/home/user# dmesg | tail -n8
[1018219.376060] usb 5-1: new full-speed USB device number 5 using uhci_hcd
[1018219.710052] usb 5-1: New USB device found, idVendor=0a12, idProduct=100b
[1018219.710060] usb 5-1: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[1018219.710064] usb 5-1: Product: CSR8510 A10
[1018219.735632] input: CSR8510 A10 as
/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/0003:0A12:100B.0003/input/input14
[1018219.736726] hid-generic 0003:0A12:100B.0003:
input,hiddev0,hidraw0: USB HID v1.11 Keyboard [CSR8510 A10] on
usb-0000:00:1d.3-1/input0
[1018219.748715] input: CSR8510 A10 as
/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.1/0003:0A12:100B.0004/input/input15
[1018219.749184] hid-generic 0003:0A12:100B.0004: input,hidraw1: USB
HID v1.11 Mouse [CSR8510 A10] on usb-0000:00:1d.3-1/input1

debian:/home/user# ./src/bluez-5.21/tools/hid2hci
--devpath=/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.1
--method=csr2

debian:/home/user# dmesg | tail -n8
[1018219.736726] hid-generic 0003:0A12:100B.0003:
input,hiddev0,hidraw0: USB HID v1.11 Keyboard [CSR8510 A10] on
usb-0000:00:1d.3-1/input0
[1018219.748715] input: CSR8510 A10 as
/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.1/0003:0A12:100B.0004/input/input15
[1018219.749184] hid-generic 0003:0A12:100B.0004: input,hidraw1: USB
HID v1.11 Mouse [CSR8510 A10] on usb-0000:00:1d.3-1/input1
[1018390.592102] usb 5-1: USB disconnect, device number 5
[1018391.544045] usb 5-1: new full-speed USB device number 6 using uhci_hcd
[1018391.719048] usb 5-1: New USB device found, idVendor=0a12, idProduct=0001
[1018391.719056] usb 5-1: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[1018391.719060] usb 5-1: Product: CSR8510 A10
debian:/home/user#


And after installing new udev rules file and new hid2hci tool; reboot
and plugging the usb device:
user@debian:~$ dmesg | tail -n 17
[   68.822503] Bluetooth: SCO socket layer initialized
[  278.248039] usb 4-2: new full-speed USB device number 2 using uhci_hcd
[  278.613049] usb 4-2: New USB device found, idVendor=0a12, idProduct=100b
[  278.613056] usb 4-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[  278.613060] usb 4-2: Product: CSR8510 A10
[  280.392124] usb 4-2: USB disconnect, device number 2
[  280.428258] hidraw: raw HID events driver (C) Jiri Kosina
[  280.452772] usbcore: registered new interface driver usbhid
[  280.452780] usbhid: USB HID core driver
[  281.320043] usb 4-2: new full-speed USB device number 3 using uhci_hcd
[  281.507066] usb 4-2: New USB device found, idVendor=0a12, idProduct=0001
[  281.507073] usb 4-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[  281.507078] usb 4-2: Product: CSR8510 A10
[  281.551508] usbcore: registered new interface driver btusb
[  282.719805] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  282.719815] Bluetooth: BNEP filters: protocol multicast
[  282.719831] Bluetooth: BNEP socket layer initialized
user@debian:~$ hcitool dev
Devices:
    hci0    00:09:DD:42:89:D4
user@debian:~$

So far my contribution...
Hope it's useful for the community.

Regards,
Fred

--089e0102f6c60db1b704fff9e0ca
Content-Type: text/x-patch; charset=US-ASCII; name="hid2hci.rules.patch"
Content-Disposition: attachment; filename="hid2hci.rules.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hyh0s6ac0

LS0tIHRvb2xzL2hpZDJoY2kucnVsZXMub3JpZwkyMDE0LTA4LTA1IDA5OjAxOjIyLjAwMDAwMDAw
MCArMDIwMAorKysgdG9vbHMvaGlkMmhjaS5ydWxlcwkyMDE0LTA4LTA1IDEwOjU3OjE2LjAwMDAw
MDAwMCArMDIwMApAQCAtMjcsNSArMjcsNiBAQAogCiAjIENTUiBkZXZpY2VzCiBBVFRSe2lkVmVu
ZG9yfT09IjBhMTJ8MDQ1OHwwNWFjIiwgQVRUUntpZFByb2R1Y3R9PT0iMTAwMCIsIFJVTis9Imhp
ZDJoY2kgLS1tZXRob2Q9Y3NyIC0tZGV2cGF0aD0lcCIKK0FUVFJ7aWRWZW5kb3J9PT0iMGExMiIs
IEFUVFJ7aWRQcm9kdWN0fT09IjEwMGIiLCBSVU4rPSJoaWQyaGNpIC0tbWV0aG9kPWNzcjIgLS1k
ZXZwYXRoPSVwIgogCiBMQUJFTD0iaGlkMmhjaV9lbmQiCg==
--089e0102f6c60db1b704fff9e0ca
Content-Type: text/x-patch; charset=US-ASCII; name="hid2hci.c.patch"
Content-Disposition: attachment; filename="hid2hci.c.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hyh0s6n61

LS0tIHRvb2xzL2hpZDJoY2kuYy5vcmlnCTIwMTQtMDMtMTEgMTI6MjA6MzQuMDAwMDAwMDAwICsw
MTAwCisrKyB0b29scy9oaWQyaGNpLmMJMjAxNC0wOC0wNSAxMDo0NTowMC4wMDAwMDAwMDAgKzAy
MDAKQEAgLTExOSw2ICsxMTksMzcgQEAKIAlyZXR1cm4gZXJyOwogfQogCitzdGF0aWMgaW50IHVz
Yl9zd2l0Y2hfY3NyMihpbnQgZmQsIGVudW0gbW9kZSBtb2RlKQoreworCWNoYXIgZGF0YVtdID0g
eyAweDAxLCAweDA1LCAweDAwLCAweDAwLCAweDAwLCAweDAwLCAweDAwLCAweDAwLCAweDAwIH07
CisJc3RydWN0IHVzYmZzX2Rpc2Nvbm5lY3QgZGlzY29ubmVjdDsKKyAgICAgICAgaW50IGVycjsK
KworCXN3aXRjaCAobW9kZSkgeworCWNhc2UgSENJOgorCQkvL09LLgorCQlicmVhazsKKwljYXNl
IEhJRDoKKwkJLy9Ob3QgaW1wbGVtZW50ZWQhCisJCXByaW50ZigiU3dpdGNoIHRvIEhJRCBub3Qg
aW1wbGVtZW50ZWQhXHJcbiIpOworCQlyZXR1cm4gLTE7CisJfQorCisJZGlzY29ubmVjdC5pbnRl
cmZhY2UgPSAwOworCWRpc2Nvbm5lY3QuZmxhZ3MgPSBVU0JGU19ESVNDT05ORUNUX0VYQ0VQVF9E
UklWRVI7CisJc3RyY3B5KGRpc2Nvbm5lY3QuZHJpdmVyLCAidXNiZnMiKTsKKworCWlmIChpb2N0
bChmZCwgVVNCRlNfSU9DVExfRElTQ09OTkVDVCwgJmRpc2Nvbm5lY3QpIDwgMCkgeworCQlmcHJp
bnRmKHN0ZGVyciwgIkNhbid0IGNsYWltIGludGVyZmFjZTogJXMgKCVkKVxuIiwKKwkJCQkJCXN0
cmVycm9yKGVycm5vKSwgZXJybm8pOworCQlyZXR1cm4gLTE7CisJfQorCisJZXJyID0gY29udHJv
bF9tZXNzYWdlKGZkLCBVU0JfRU5EUE9JTlRfT1VUIHwgVVNCX1RZUEVfQ0xBU1MgfCBVU0JfUkVD
SVBfSU5URVJGQUNFLCBVU0JfUkVRX1NFVF9DT05GSUdVUkFUSU9OLCAweDAzMDEsIDAsIGRhdGEs
IHNpemVvZihkYXRhKSwgMTAwMDApOworCisJcmV0dXJuIGVycjsKK30KKwogc3RhdGljIGludCBo
aWRfbG9naXRlY2hfc2VuZF9yZXBvcnQoaW50IGZkLCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBz
aXplKQogewogCXN0cnVjdCBoaWRkZXZfcmVwb3J0X2luZm8gcmluZm87CkBAIC0yNTgsNyArMjg5
LDcgQEAKIAlwcmludGYoIlVzYWdlOiBoaWQyaGNpIFtvcHRpb25zXVxuIgogCQkiICAtLW1vZGU9
ICAgICAgIG1vZGUgdG8gc3dpdGNoIHRvIFtoaWR8aGNpXSAoZGVmYXVsdCBoY2kpXG4iCiAJCSIg
IC0tZGV2cGF0aD0gICAgc3lzIGRldmljZSBwYXRoXG4iCi0JCSIgIC0tbWV0aG9kPSAgICAgbWV0
aG9kIHRvIHVzZSB0byBzd2l0Y2ggW2Nzcnxsb2dpdGVjaC1oaWR8ZGVsbF1cbiIKKwkJIiAgLS1t
ZXRob2Q9ICAgICBtZXRob2QgdG8gdXNlIHRvIHN3aXRjaCBbY3NyfGNzcjJ8bG9naXRlY2gtaGlk
fGRlbGxdXG4iCiAJCSIgIC0taGVscFxuXG4iKTsKIH0KIApAQCAtMjc0LDYgKzMwNSw3IEBACiAJ
ZW51bSBtZXRob2QgewogCQlNRVRIT0RfVU5ERUYsCiAJCU1FVEhPRF9DU1IsCisgICAgICAgICAg
ICAgICAgTUVUSE9EX0NTUjIsCiAJCU1FVEhPRF9MT0dJVEVDSF9ISUQsCiAJCU1FVEhPRF9ERUxM
LAogCX0gbWV0aG9kID0gTUVUSE9EX1VOREVGOwpAQCAtMzExLDYgKzM0Myw5IEBACiAJCQlpZiAo
IXN0cmNtcChvcHRhcmcsICJjc3IiKSkgewogCQkJCW1ldGhvZCA9IE1FVEhPRF9DU1I7CiAJCQkJ
dXNiX3N3aXRjaCA9IHVzYl9zd2l0Y2hfY3NyOworCQkJfSBlbHNlIGlmICghc3RyY21wKG9wdGFy
ZywgImNzcjIiKSkgeworCQkJCW1ldGhvZCA9IE1FVEhPRF9DU1IyOworCQkJCXVzYl9zd2l0Y2gg
PSB1c2Jfc3dpdGNoX2NzcjI7CiAJCQl9IGVsc2UgaWYgKCFzdHJjbXAob3B0YXJnLCAibG9naXRl
Y2gtaGlkIikpIHsKIAkJCQltZXRob2QgPSBNRVRIT0RfTE9HSVRFQ0hfSElEOwogCQkJfSBlbHNl
IGlmICghc3RyY21wKG9wdGFyZywgImRlbGwiKSkgewpAQCAtMzQ0LDYgKzM3OSw3IEBACiAKIAlz
d2l0Y2ggKG1ldGhvZCkgewogCWNhc2UgTUVUSE9EX0NTUjoKKwljYXNlIE1FVEhPRF9DU1IyOgog
CWNhc2UgTUVUSE9EX0RFTEw6IHsKIAkJc3RydWN0IHVkZXZfZGV2aWNlICpkZXY7CiAJCWludCBo
YW5kbGU7Cg==
--089e0102f6c60db1b704fff9e0ca--
