Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Feb 2012 12:25:26 +0100
From: Fabrice DELENTE <delentef@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Entering the PIN of a device?
Message-ID: <20120215112526.GA21137@smtp.free.fr>
References: <20120214164518.GA11881@smtp.free.fr>
 <CANq1E4QEeoFr4HC+DajcsPt_BNNgzsp8-_7tRFVOOVin1atTEA@mail.gmail.com>
 <20120214175813.GA16393@smtp.free.fr>
 <CANq1E4Q7UQjQNKPy0c-w4DX8dimuRNYB_mOsetMBNPaY44Ae5A@mail.gmail.com>
 <20120214180937.GA17364@smtp.free.fr>
 <CANq1E4R0xkzJF8CebBFkc5R=idO=cEPciK2XQW9Yv9nWuWGnGw@mail.gmail.com>
 <20120214224714.GA5586@smtp.free.fr>
 <CANq1E4QyNMqoWFax5qKqNnWLbP+-311yhyb5EXbWEt9ODne1Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CANq1E4QyNMqoWFax5qKqNnWLbP+-311yhyb5EXbWEt9ODne1Fw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> What? One mail earlier you said you are *not* asked for the PIN? If
> it asks for the PIN then your Wii Remote isn't detected as a Wii
> Remote.  You cannot type the PIN as the PIN contains binary-0
> characters which cannot be entered here.

Yeah, my bad, I tried simple-agent first without argument, but with
'simple-agent hci0 $WIIMOTE' I get asked for the PIN.

> What do you find in these files? Especially the
> /var/lib/bluetooth/<bt>/did files are interesting.

Here is /var/lib/bluetooth/<bt>/did:

# cat did
00:1F:C5:1B:3A:B1 FFFF 0000 0000 0000
00:18:91:D0:7A:24 FFFF 0000 0000 0000
6C:E9:07:43:A7:71 0001 0001 0119 0000

> Also see: https://github.com/dvdhrm/xwiimote/issues/3
> 
> Gnah, that doesn't work. You cannot send the binary PIN via dbus to
> BlueZ, this is why we provide the wiimote-plugin.

Ok :^) Didn't know that... too bad it doesn't work :^)

> Did you try this patch:
> https://github.com/dvdhrm/xwiimote/issues/4#issuecomment-3302615 The
> Patch 1/2 isn't needed but 2/2 should fix the pairing issues with
> any Wii Remote.

Ok, I'll try that this afternoon.

Thanks again!

-- 
F. Delente
