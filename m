Return-Path: <ag@new-media-artists.de>
Reply-To: <ag@new-media-artists.de>
From: "Andreas Gaufer" <ag@new-media-artists.de>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Subject: AW: [Bluez-devel] Device Busy during "hcitool info" or "sdptoolsearch"
Date: Wed, 17 Dec 2003 20:08:02 +0100
Message-ID: <FJENILNPNAGPJMMDOKDCKEKBDJAA.ag@new-media-artists.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1071683672.27570.71.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

>this depends on your Bluetooth chip and the firmware on this chip. In
>general all CSR chips with HCI 16.x firmware should be able to run an
>inquiry while maintaining an ACL link. So your modules should not have a
>problem here, but you can run a hcidump and look for the error code that
>is returned by the inquiry command.

hciconfig revision tells me that both chips have HCI 16.4 (bc02x) so i
checked hcidump -x , heres whats happening:

Wokring inq:
< HCI Command: Inquiry(0x01|0x0001) plen 5
  33 8B 9E 08 0A
> HCI Event: Command Status(0x0f) plen 4
  00 01 01 04

Not wokring inq:
< HCI Command: Inquiry(0x01|0x0001) plen 5
  33 8B 9E 08 0A
> HCI Event: Command Status(0x0f) plen 4
  0C 01 01 04

Do i guess right when i think that the differing "0C" means "Command
disallowed" like discribed in BT 1.2 Core Spec, Vol 2, Core System Package,
Part D (Error Codes) ?
If so, would you recommend:

A: Use another BT-Device with a more recent HCI Firmware Revision.
	or
B: Do inq. on one device and use another device to connect to the found
peers.
	or
c: Do something else ;)

Thanks for your help, i realy appreciate it.

Greetings

Andreas Gaufer
