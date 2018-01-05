Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: AceLan Kao <acelan.kao@canonical.com>
Date: Fri, 5 Jan 2018 14:41:52 +0800
Message-ID: <CAFv23Qk1zv-Otg_EJXndfiXgxzO2O44JTbV12SJyZapjPwPwaw@mail.gmail.com>
Subject: Intel BT[8087:0025] leads to system auto resume from S3 randomly
To: linux-bluetooth@vger.kernel.org
Cc: Ethan Hsieh <ethan.hsieh@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

We found an issue that when system enters S3, it stays in S3 for a few
seconds, and somehow it resumes automatically.
And we try below quirk which can prevent it from waking up.

drivers/usb/core/quirks.c
@@ -208,11 +208,11 @@ static const struct usb_device_id usb_quirk_list[] = {
                        USB_QUIRK_DISCONNECT_SUSPEND },
        { USB_DEVICE(0x12d1, 0x15c3), .driver_info =
                        USB_QUIRK_DISCONNECT_SUSPEND },
+        { USB_DEVICE(0x8087, 0x0025), .driver_info =
+                        USB_QUIRK_DISCONNECT_SUSPEND },

Here are some findings from the system.

$ lsusb
Bus 001 Device 004: ID 8087:0025 Intel Corp.

$ lspci -nn
00:14.0 USB controller [0c03]: Intel Corporation Device [8086:a36d] (rev 01)

Jan 4 04:20:37 u-OptiPlex-7060 kernel:
[ 0.144060] v2 Added device:4b [\_SB_.PCI0.XHC_] parent PNP0A08:00 sta=0xf
[ 0.171066] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330
[ 0.171099] pci 0000:00:14.0: reg 0x10: [mem 0x71420000-0x7142ffff 64bit]
[ 0.171200] pci 0000:00:14.0: PME# supported from D3hot D3cold
[ 3.680297] xhci_hcd 0000:00:14.0: xHCI Host Controller
[ 3.680301] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[ 3.681509] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version
0x110 quirks 0x00009810
[ 3.681515] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[ 3.681621] usb usb1: SerialNumber: 0000:00:14.0
[ 3.681989] xhci_hcd 0000:00:14.0: xHCI Host Controller
[ 3.681992] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[ 3.681993] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[ 3.682026] usb usb2: SerialNumber: 0000:00:14.0

===> Suspend
[31.783177] PM: Syncing filesystems ... done.
[31.784733] PM: Preparing system for sleep (mem)
[31.785444] Freezing user space processes ... (elapsed 0.001 seconds) done.
[31.786486] OOM killer disabled.
[31.786487] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[31.787597] PM: Suspending system (mem)
[31.787631] Suspending console(s) (use no_console_suspend to debug)

===> Device resumes automatically
[32.911466] wakeup_source_report_event: name:device:4b, event_count:1
[32.911467] wakeup_source_activate: name:device:4b, active_count:1
[32.911471] wakeup_source_report_event: name:0000:00:14.0, event_count:1
[32.911471] wakeup_source_activate: name:0000:00:14.0, active_count:1
[33.231056] PM: Finishing wakeup.

Any ideas? Or anything we can try?
Thanks.

Best regards,
AceLan Kao.
