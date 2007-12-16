Return-Path: <cyrus@holtmann.org>
Message-ID: <47646F04.8080301@am.sony.com>
Date: Sat, 15 Dec 2007 16:19:16 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>, maxk@qualcomm.com,
        bluez-devel@lists.sf.net, dwmw2@infradead.org
Subject: Re: [Bluez-devel] [RFC] PS3 Bluetooth quirk for HCI_FLT_CLEAR_ALL
References: <463F7386.6050900@am.sony.com>	 <1178608551.8628.52.camel@aeonflux.holtmann.net>	 <1178622391.2824.34.camel@pmac.infradead.org>	 <1178630359.8628.63.camel@aeonflux.holtmann.net>	 <1178639244.2824.40.camel@pmac.infradead.org>	 <1178642601.8628.67.camel@aeonflux.holtmann.net>	 <4640FF63.8070403@am.sony.com>  <4641331E.1070408@am.sony.com> <1178694136.8628.82.camel@aeonflux.holtmann.net>
In-Reply-To: <1178694136.8628.82.camel@aeonflux.holtmann.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

On 05/09/2007 12:02 AM, Marcel Holtmann wrote:
> Hi Geoff,
> 
>> >>> [root@ps3 ~]# hciconfig hci0 revision
>> >>> hci0:   Type: USB
>> >>>         BD Address: 00:13:A9:79:09:C3 ACL MTU: 384:8 SCO MTU: 64:8
>> >>>         Build 3608
>> >>>         Chip version: Unknown
>> >>>         Max key size: 128 bit
>> >>>         SCO mapping:  HCI
>> > 
>> > hci0:   Type: USB
>> >         BD Address: 00:13:A9:73:1F:0D ACL MTU: 384:8 SCO MTU: 64:8
>> >         Build 3608
>> >         Chip version: Unknown (4h)
>> >         Max key size: 128 bit
>> >         SCO mapping:  HCI
>> > 
>> >> 
>> >> the chip version is unknown. That is strange. I need to modify bccmd to
>> >> read the raw value of the chip version. Can you quickly poke around the
>> >> hciconfig code to get me the raw value of it.
>> >> 
>> >>> [root@ps3 ~]# bccmd builddef
>> >>> Build definitions:
>> >>> 0x0009 - TRANSPORT_BCSP
>> >>> 0x000a - TRANSPORT_H4
>> >>> 0x000b - TRANSPORT_USB
>> >>> 0x000d - MAX_CRYPT_KEY_LEN_128
>> >>> 0x0012 - REQUIRE_8MBIT
>> >>> 0x0013 - RADIOTEST
>> >>> 0x0015 - INSTALL_FLASH
>> >>> 0x0016 - INSTALL_EEPROM
>> >>> 0x0017 - INSTALL_COMBO_DOT11
>> >>> 0x001d - CHIP_BASE_BC3
>> >>> 0x0020 - INSTALL_HCI_MODULE
>> >>> 0x002a - BT_VER_1_2
>> >>> 0x0031 - CHIP_BASE_BC4
>> >>> [root@ps3 ~]# bccmd buildname
>> >>> Build name: sly_8hci_fl_bt2.0_tachikoma-rc29_encr128_tachikoma
>> >>> 2006-10-16
>> >> 
>> >> This looks like a specific firmware build. Need to investigate what is
>> >> so special about it.
>> >> 
>> >> Can you dfutool archive it for me.
>> > 
>> > The device seems to disconnect when you try to read
>> > the firmware.  I get this when I try:
>> > 
>> > [root@ps3-nfs ~]# dfutool archive ps3.dfu
>> > Available devices with DFU support:
>> > 
>> >          1) Bus 002 Device 003: ID 054c:0267 Interface 3
>> > 
>> > Select device (abort with 0): 1
>> > 
>> > Can't identify device with DFU mode
>> > 
>> > And see this in the log:
>> > 
>> > May  8 15:50:07 ps3-nfs kernel: usb 2-2: reset high speed USB device using ps3-ehci-driver and address 3
>> > May  8 15:50:07 ps3-nfs kernel: usb 2-2: USB disconnect, address 3
>> > May  8 15:50:07 ps3-nfs hcid[2286]: HCI dev 0 down
>> > May  8 15:50:07 ps3-nfs hcid[2286]: Device hci0 has been disabled
>> > May  8 15:50:07 ps3-nfs hcid[2286]: HCI dev 0 unregistered
>> > May  8 15:50:07 ps3-nfs hcid[2286]: Unregister path: /org/bluez/hci0
>> > May  8 15:50:07 ps3-nfs hcid[2286]: Device hci0 has been removed
>> > 
>> > Any suggestions?
>> 
>> There seems to be some trouble in dfutool...  Others tried it with
>> the same results.  I'll look at it some more tomorrow.
> 
> alternatively you can try dfu-util from the openmoko.org project. I
> never did, but it should work just quite fine.
> 
>> *** glibc detected *** dfutool: double free or corruption (fasttop): 
>> 0x08016080 
>> ***
>> ======= Backtrace: =========
>> /lib/libc.so.6[0x7ed0394]
>> /lib/libc.so.6(cfree+0xc8)[0x7ed05e8]
>> /usr/lib/libusb-0.1.so.4(usb_close+0x3c)[0x7fd87ec]
>> dfutool[0x8002840]
>> dfutool[0x8002ba4]
>> dfutool[0x8003640]
>> /lib/libc.so.6[0x7e6fd4c]
>> /lib/libc.so.6(__libc_start_main+0x144)[0x7e6ff74]
>> ======= Memory map: ========
>> 00100000-00103000 r-xp 00100000 00:00 0 
>> 07e52000-07fb1000 r-xp 00000000 2a:02 693780 /lib/libc-2.5.so
>> 07fb1000-07fbe000 ---p 0015f000 2a:02 693780 /lib/libc-2.5.so
>> 07fbe000-07fc2000 r--p 0016c000 2a:02 693780 /lib/libc-2.5.so
>> 07fc2000-07fc3000 rw-p 00170000 2a:02 693780 /lib/libc-2.5.so
>> 07fc3000-07fc6000 rw-p 07fc3000 00:00 0 
>> 07fd6000-07fde000 r-xp 00000000 2a:02 1021105 /usr/lib/libusb-0.1.so.4.4.4
>> 07fde000-07fee000 ---p 00008000 2a:02 1021105 /usr/lib/libusb-0.1.so.4.4.4
>> 07fee000-07ff0000 rw-p 00008000 2a:02 1021105 /usr/lib/libusb-0.1.so.4.4.4
>> 08000000-08006000 r-xp 00000000 2a:02 281135 /usr/bin/dfutool
>> 08015000-08016000 rw-p 00005000 2a:02 281135 /usr/bin/dfutool
>> 08016000-08037000 rwxp 08016000 00:00 0 [heap]
>> 0ffc0000-0ffde000 r-xp 00000000 2a:02 693779 /lib/ld-2.5.so
>> 0ffef000-0fff0000 r--p 0001f000 2a:02 693779 /lib/ld-2.5.so
>> 0fff0000-0fff1000 rw-p 00020000 2a:02 693779 /lib/ld-2.5.so
>> f7fce000-f7fcf000 rw-p f7fce000 00:00 0 
>> f7ffc000-f7fff000 rw-p f7ffc000 00:00 0 
>> ffc89000-ffc9e000 rw-p ffc89000 00:00 0 [stack]
>> Aborted
> 
> I have seen this one before. I think it is a libusb bug.

OK, so users are screaming for bluetooth support.  Can we get this
resolved?

Here is the patch again.

-Geoff

----------------------------------------------------------------------
Subject: PS3 Bluetooth quirk for HCI_FLT_CLEAR_ALL

It seems the PS3 built-in bluetooth host controler doesn't support the
HCI_FLT_CLEAR_ALL command properly.  Add a check to conditionally use
the HCI_FLT_CONN_SETUP command to clear the event filter on PS3.

With this patch bluetooth mouse or keyboard are automatically re-connected
after reboot.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 include/net/bluetooth/hci.h |    6 ++++++
 net/bluetooth/hci_core.c    |   18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -424,6 +424,12 @@ struct hci_cp_set_event_flt {
 	__u8     condition[0];
 } __attribute__ ((packed));
 
+struct hci_cp_set_event_flt_conn {
+	__u8 flt_type;
+	__u8 cond_type;
+	__u8 condition;
+} __attribute__ ((packed));
+
 /* Filter types */
 #define HCI_FLT_CLEAR_ALL	0x00
 #define HCI_FLT_INQ_RESULT	0x01
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -46,6 +46,9 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#if defined(CONFIG_PPC_PS3)
+#include <asm/firmware.h>
+#endif
 
 #ifndef CONFIG_BT_HCI_CORE_DEBUG
 #undef  BT_DBG
@@ -243,6 +246,21 @@ static void hci_init_req(struct hci_dev 
 	flt_type = HCI_FLT_CLEAR_ALL;
 	hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
 
+#if defined(CONFIG_PPC_PS3)
+	/*
+	 * The PS3 built-in bluetooth host controler doesn't support the
+	 * HCI_FLT_CLEAR_ALL command properly.  Use the HCI_FLT_CONN_SETUP
+	 * command to clear the event filter.
+	 */
+	if (firmware_has_feature(FW_FEATURE_PS3_LV1)) {
+		struct hci_cp_set_event_flt_conn cp;
+		cp.flt_type = HCI_FLT_CONN_SETUP;
+		cp.cond_type = 0; /* all devices */
+		cp.condition = 1; /* auto accept is off */
+		hci_send_cmd(hdev, HCI_OP_CREATE_CONN, sizeof(cp), &cp);
+	}
+#endif
+
 	/* Page timeout ~20 secs */
 	param = cpu_to_le16(0x8000);
 	hci_send_cmd(hdev, HCI_OP_WRITE_PG_TIMEOUT, 2, &param);
