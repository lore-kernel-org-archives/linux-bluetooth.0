Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1D7AEE8B-51DB-4A6D-8EBA-3EC81760224E@holtmann.org>
References: <1411746855-9936-1-git-send-email-fons@spotify.com>
 <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org> <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com>
 <BCEE5DFC-08DA-43A7-AED8-BEFD837B07ED@holtmann.org> <CAHF=Y4p-st7N4+kUezYWjy7L58zcH-1t0AO0ME6axZ76ZK+oKQ@mail.gmail.com>
 <1D7AEE8B-51DB-4A6D-8EBA-3EC81760224E@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Mon, 29 Sep 2014 16:49:39 +0200
Message-ID: <CAHF=Y4pkXTvcN6YQTH6DPboeav7BCa8T0HUSfOHfag+W9GJ8fQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

>
> if it can not store its LTK, then why doesn't it use a key hierarchy (as =
defined in the Bluetooth specification) so that it can restore its keys aft=
er reboot. If it remembers its Bluetooth address, then it could clearly rem=
ember a single master key.
>
> But seriously, if you can remember your BD_ADDR, then you might want to r=
emember your LTK as well. Just a hint here.


Thanks for the hint, I wasn't familiar with "key hierarchies".

> So the encryption trigger is not done by the kernel. It is actually done =
by userspace when you have an existing LTK. The kernel will auto-conect the=
 device with low security and then userspace will move it to medium securit=
y in case we have an LTK. It will also move it to medium security for all H=
ID devices since that is mandatory.
>
[...]
> Having the advertising data in Device Connected event will actually allow=
 you to do exactly what you want. It would allow you to utilize Unpair Devi=
ce (with Disconnect 0x00) and Pair Device to recreate the bonding. All with=
out ever disconnecting the link.
>
> The important piece of detail is that the security elevation from low to =
medium does not happen when the device is detected as initial powered on. S=
o instead of security elevation, you do a re-bonding which will give you th=
e encrypted link HID requires and also the new LTK.

Oh, I see. I was wrongly assuming that the encryption elevation was
also done in the kernel without userspace involvement. Then, adding
the contents of the ADV_IND report to the "Device Connected event"
should indeed be good enough. I will try it out and send a patch if it
works.


> So before trying to redefine the Add Device command semantics, I would cl=
early go for adding the advertising data to Device Connected event and see =
if that gets you where you need to go.

Will do, thanks!



--=20
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
