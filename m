Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120214224714.GA5586@smtp.free.fr>
References: <20120214164518.GA11881@smtp.free.fr>
	<CANq1E4QEeoFr4HC+DajcsPt_BNNgzsp8-_7tRFVOOVin1atTEA@mail.gmail.com>
	<20120214175813.GA16393@smtp.free.fr>
	<CANq1E4Q7UQjQNKPy0c-w4DX8dimuRNYB_mOsetMBNPaY44Ae5A@mail.gmail.com>
	<20120214180937.GA17364@smtp.free.fr>
	<CANq1E4R0xkzJF8CebBFkc5R=idO=cEPciK2XQW9Yv9nWuWGnGw@mail.gmail.com>
	<20120214224714.GA5586@smtp.free.fr>
Date: Wed, 15 Feb 2012 12:16:22 +0100
Message-ID: <CANq1E4QyNMqoWFax5qKqNnWLbP+-311yhyb5EXbWEt9ODne1Fw@mail.gmail.com>
Subject: Re: Entering the PIN of a device?
From: David Herrmann <dh.herrmann@googlemail.com>
To: Fabrice DELENTE <delentef@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabrice

On Tue, Feb 14, 2012 at 11:47 PM, Fabrice DELENTE <delentef@gmail.com> wrote:
>> Did the device show up in /sys/bus/hid/devices ? Did you check
>> dmesg? I think you got the device connected successfully, it just
>> doesn't do anything useful without configuration ;)
>
> My tests have been disappointing, I have the wiimote plugin in
> bluetoothd (the grep for wiimote in bluetoothd shows a match), but
> there is no auto-pairing...
>
> If I have bluetoothd running, and I press 1+2 (or the red button),
> nothing shows in dmesg, nor in /sys/bus/hid/devices...
>
> If I press 1+2 and start simple-agent hci0 $WIIMOTE, I get a message
> asking for the PIN, but I can't type it (I must type in the wiimote BT
> addr in string form, right?)

What? One mail earlier you said you are *not* asked for the PIN? If it
asks for the PIN then your Wii Remote isn't detected as a Wii Remote.
You cannot type the PIN as the PIN contains binary-0 characters which
cannot be entered here.

Earlier:
> My trouble is that when I start simple-agent and then push 1+2 to pair
> the wiimote with my laptop, simple-agent doesn't ask for the
> PIN... should it happens automagically?
>
> I have grepped the files in /var/lib/bluetooth, I have found my mote
> BT address in the files but nothing clearly linked to the PIN key. I
> read on wiimote-brew that it was the mote BT address in binary form?
> I modified simple-agent with a bit of python to return the address in
> UTF-8 form:

What do you find in these files? Especially the
/var/lib/bluetooth/<bt>/did files are interesting.

Also see: https://github.com/dvdhrm/xwiimote/issues/3

> def RequestPinCode(self, device):
>    print "RequestPinCode (%s)" % (device)
>    wiimote_address_bytes = os.environ["WIIMOTE"].split(":")
>    n = ""
>    for i in range(len(wiimote_address_bytes)-1, -1, -1):
>        if int(wiimote_address_bytes[i], 16) == 0:
>           break
>        n += chr(int(wiimote_address_bytes[i], 16))
>    return unicode(n, "utf-8")
>
> but I still have an error:
>
> # ./wiimote-agent hci0 $WIIMOTE
> RequestPinCode (/org/bluez/5122/hci0/dev_00_1F_C5_1B_3A_B1)
> Creating device failed: org.bluez.Error.AuthenticationRejected: Authentication Rejected

Gnah, that doesn't work. You cannot send the binary PIN via dbus to
BlueZ, this is why we provide the wiimote-plugin.

Did you try this patch:
https://github.com/dvdhrm/xwiimote/issues/4#issuecomment-3302615
The Patch 1/2 isn't needed but 2/2 should fix the pairing issues with
any Wii Remote.

> Well... I'll try again after a good night sleep :^)
>
> --
> F. Delente

Cheers
David
