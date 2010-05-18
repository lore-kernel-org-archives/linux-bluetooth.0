Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 18 May 2010 18:40:23 +0600
Message-ID: <AANLkTiktxequKpuDI8FicKJUFZUkVhWpHQIcVlWb_8X8@mail.gmail.com>
Subject: Need for workaround for buggy device.
From: Andrey Vainberger <platerx@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have USB bluetooth adapter with little bug. This device always
reports about Stored Link Key.
For example log, got with the help of hcidump:

After the device is pluged in, and the command "Read Stored Link Key" is sent:

< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
  00 00 00 00 00 00 01concrete
> HCI Event: Return Link Keys (0x15) plen 23
  01 02 FF 00 00 0F 5E 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 8B 1A 02 10 30 30 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 05 00 00 60 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 03 F4 01 03 42 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 BC 66 47 2F C4 5E 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 32 18 1A 09 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 2B 08 14 28 60 FA 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Command Complete (0x0e) plen 8
  01 0D 0C 00 08 00 07 00

Then I try to delete all keys:
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
  00 00 00 00 00 00 01
> HCI Event: Command Complete (0x0e) plen 6
  01 12 0C 00 07 00

Then I send Read Stored Link Key again, but... nothing changes:

 HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
  00 00 00 00 00 00 01
> HCI Event: Return Link Keys (0x15) plen 23
  01 02 FF 00 00 0F 5E 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 8B 1A 02 10 30 30 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 05 00 00 60 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 03 F4 01 03 42 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 BC 66 47 2F C4 5E 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 32 18 1A 09 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Return Link Keys (0x15) plen 23
  01 2B 08 14 28 60 FA 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Command Complete (0x0e) plen 8
  01 0D 0C 00 08 00 07 00

I also try to delete the specific key:
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
  02 FF 00 00 0F 5E 00
> HCI Event: Command Complete (0x0e) plen 6
  01 12 0C 00 01 00

And again - nothing changes. The device in reply to the command "Read
Stored Link Key",
gives back the same list of the stored keys as above.

Because of this defect, on the adapter's plug, bluez immediately
starts reporting about 7
coupled devices:

dbus-send --system --type=method_call --print-reply --dest=org.bluez
/org/bluez/5548/hci0 org.bluez.Adapter.GetProperties
<skipped>
      dict entry(
         string "Devices"
         variant             array [
               object path "/org/bluez/5548/hci0/dev_5E_0F_00_00_FF_02"
               object path "/org/bluez/5548/hci0/dev_30_30_10_02_1A_8B"
               object path "/org/bluez/5548/hci0/dev_00_00_60_00_00_05"
               object path "/org/bluez/5548/hci0/dev_00_42_03_01_F4_03"
               object path "/org/bluez/5548/hci0/dev_5E_C4_2F_47_66_BC"
               object path "/org/bluez/5548/hci0/dev_20_00_09_1A_18_32"
               object path "/org/bluez/5548/hci0/dev_FA_60_28_14_08_2B"
            ]
      )
</skipped>
that I cannot remove:
dbus-send --system --type=method_call --print-reply --dest=org.bluez
/org/bluez/5548/hci0 org.bluez.Adapter.RemoveDevice
objpath:/org/bluez/4393/hci0/dev_00_17_83_6B_5E_54
Error org.bluez.Error.DoesNotExist: Device does not exist
Moreover bluez starts crashing regularly.

After this hack everything works fine:
--- bluez-4.58.orig/src/security.c      2009-10-10 10:17:29.000000000 +0600
+++ bluez-4.58/src/security.c   2010-05-17 20:55:40.000000000 +0600
@@ -413,7 +413,7 @@

                info("return_link_keys (sba=%s, dba=%s)", sa, da);

-               hcid_dbus_returned_link_key(sba, &dba);
+               //hcid_dbus_returned_link_key(sba, &dba);

                ptr += 22;
        }

With another operating systems this adapter is functioning correctly.
Apparently, it is necessary to add some additional checking of the
keys that are returned by the command "Read Stored Link Key" or to add
to the config file the option for ignoring Return Link Keys Event.
