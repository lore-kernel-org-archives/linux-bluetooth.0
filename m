Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 23:47:14 +0100
From: Fabrice DELENTE <delentef@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Entering the PIN of a device?
Message-ID: <20120214224714.GA5586@smtp.free.fr>
References: <20120214164518.GA11881@smtp.free.fr>
 <CANq1E4QEeoFr4HC+DajcsPt_BNNgzsp8-_7tRFVOOVin1atTEA@mail.gmail.com>
 <20120214175813.GA16393@smtp.free.fr>
 <CANq1E4Q7UQjQNKPy0c-w4DX8dimuRNYB_mOsetMBNPaY44Ae5A@mail.gmail.com>
 <20120214180937.GA17364@smtp.free.fr>
 <CANq1E4R0xkzJF8CebBFkc5R=idO=cEPciK2XQW9Yv9nWuWGnGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CANq1E4R0xkzJF8CebBFkc5R=idO=cEPciK2XQW9Yv9nWuWGnGw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Did the device show up in /sys/bus/hid/devices ? Did you check
> dmesg? I think you got the device connected successfully, it just
> doesn't do anything useful without configuration ;)

My tests have been disappointing, I have the wiimote plugin in
bluetoothd (the grep for wiimote in bluetoothd shows a match), but
there is no auto-pairing...

If I have bluetoothd running, and I press 1+2 (or the red button),
nothing shows in dmesg, nor in /sys/bus/hid/devices...

If I press 1+2 and start simple-agent hci0 $WIIMOTE, I get a message
asking for the PIN, but I can't type it (I must type in the wiimote BT
addr in string form, right?)

I modified simple-agent with a bit of python to return the address in
UTF-8 form:

def RequestPinCode(self, device):
    print "RequestPinCode (%s)" % (device)
    wiimote_address_bytes = os.environ["WIIMOTE"].split(":")
    n = ""
    for i in range(len(wiimote_address_bytes)-1, -1, -1):
    	if int(wiimote_address_bytes[i], 16) == 0:
           break
	n += chr(int(wiimote_address_bytes[i], 16))
    return unicode(n, "utf-8")

but I still have an error:

# ./wiimote-agent hci0 $WIIMOTE
RequestPinCode (/org/bluez/5122/hci0/dev_00_1F_C5_1B_3A_B1)
Creating device failed: org.bluez.Error.AuthenticationRejected: Authentication Rejected

Well... I'll try again after a good night sleep :^)

-- 
F. Delente
