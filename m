Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8ccf0ad88f16335719c367ed69c90a3e.squirrel@mungewell.org>
References: <8ccf0ad88f16335719c367ed69c90a3e.squirrel@mungewell.org>
Date: Fri, 17 Jan 2014 11:16:29 +0100
Message-ID: <CANq1E4TaM-eG5rBU8X2T9ux8fMgTCyaXpxF2ydZU=71QsX0UBQ@mail.gmail.com>
Subject: Re: Dualshock4 - 'HIDP: Handshake: Unsupported request' after 'unplug
 virtual cable'.
From: David Herrmann <dh.herrmann@gmail.com>
To: Simon Wood <simon@mungewell.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Frank Praznik <frank.praznik@oh.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Fri, Jan 17, 2014 at 6:09 AM,  <simon@mungewell.org> wrote:
> Hi all,
> Frank and I have been working on a kernel driver for the Dualshock 4 and
> we're having problems with the BT connection (USB is OK).
>
> When powered on the DS4 will initiate a connection to the PC once it knows
> it's Bdaddr (via pairing), but will power off shortly there after. This
> seems to be related to incorrect (??) data sent from Bluez, or if no hid
> connection is made within a short window.
>
> On the two systems I have tried:
> 1) Debian with bluez 4.99, I can 'hidd --connect xxx' to hold the
> connection. I get joystick data but can't send data to DS4 to drive
> ff/leds. (I am told that 'hidd' is deprated)
>
> 2) Fedora LiveCD with bluez 5.13. Connection is immediately terminated by
> the controller. HCI log attached.
>
> It appears that the controller is insisting on a encrypted link ('noenc'
> and 'noauth' make no difference) and does not like the 'unplug virtual
> cable' which is sent (presumably as the link is being brought down to
> re-start encrypted).

Could you provide a bluetoothd log, too? I suspect it contains a
message along the line:
  "Refusing input device connect: %s (%d)"

"connect_ds4_fedora_4.txt" contains all the important information.
I'll just summarize what it does:
 1. The remote device initiates a base-band connection to your host
 2. Your host fetches all SDP records from the device (L2CAP PSM: 1)
 3. The SDP connection is closed
 4. Link-key negotiation is successful (=> you already were connected
to the device before)
 5. encryption-mode is changed successfully (not sure whether it's
turned ON or OFF, but I guess "encrypt 0x01" means ON)
 6. device initiates L2CAP on PSM 0x17 (HIDP control channel)
 7. Host sends "HIDP: Control: Virtual cable unplug" on the HIDP control channel
 8. host closes L2CAP PSM 0x17
 9. device initiates L2CAP on PSM 0x19 (HIDP intr channel)
10. host refuses connection on PSM 0x19
11. device closes baseband connection

So the problem is, your host refuses the HIDP connection from the
device. This is intentional, as we don't want *any* remote Bluetooth
device to be allowed to provide HID services. This could be used for
very subtle attacks. The code responsible for that is
./profiles/input/server.c in bluez.

Now, there are two ways to go on:
 - try to initiate the HIDP connection from the host instead of the
device. Simply use "bluetoothctl" and then "connect <bdaddr>"
 - add the remote device to the list of known devices so incoming
connections are not blocked. You can do this by triggering the
->device_probe() callback of the input device. I'm not sure how this
is done, but I think a simple "connect <bdaddr>" should trigger it on
*all* available services.

I hope that helps. If not, we can try to add the device manually.
Cheers
David

> In the BT HID 1.1 spec (page 48) it says
> --
> If the HIDVirtualCable SDP attribute is set to TRUE, then a Virtual Cable
> is considered to be established after both the HID Control and HID
> Interrupt L2CAP channels have been opened.
> --
>
> However the Fedora system does not have a copy of the SDP records for the
> controller, it never pulled them and I have never managed to make a
> connection long enough to read them.
>
> My theory is that the controller is rejecting the 'Unplug Virtual Cable'
> command as it shouldn't have been established, but I'm not really sure.
>
>
>
> I managed use my Debian system to read SDP records but that barfs on
> what's sent.... files also attached.
>
> Does anyone have any suggestions on what I should try next?
> Thanks, Simon
>
>
>
>
