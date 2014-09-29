Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BCEE5DFC-08DA-43A7-AED8-BEFD837B07ED@holtmann.org>
References: <1411746855-9936-1-git-send-email-fons@spotify.com>
 <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org> <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com>
 <BCEE5DFC-08DA-43A7-AED8-BEFD837B07ED@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Mon, 29 Sep 2014 15:33:44 +0200
Message-ID: <CAHF=Y4p-st7N4+kUezYWjy7L58zcH-1t0AO0ME6axZ76ZK+oKQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> you can not send HTML emails here. The mailing list will just reject you.

Sorry about that, I didn't even know that my email client was
inserting HTML tags.


>> We are dealing with an HID device which sends meaningful information in =
ADV_IND reports and to which we want to connect when receiving ADV_DIRECT_I=
ND reports.
>>
>> Without kernel support for auto-connecting on ADV_IND while still forwar=
ding ADV_DIRECT_IND to userland, we are forced to keep active scanning on s=
o that the content of ADV_IND reports isn't lost.
>>

I meant  "for auto-connecting on ADV_DIRECT_IND while still forwarding
ADV_IND to userland", sorry

> I still think that what you really want is actually using Action 0x02 sin=
ce you know the remote device address and you want to connect it. It does n=
ot matter if it happens via ADV_DIRECT_IND or ADV_IND in the end. However i=
n case it happens via ADV_IND you want to get the advertising data and for =
that I am proposing to get it via Device Connected event.

Unfortunately, that is not good enough for this device. Let me give
you some context.

This device doesn't have non-volatile memory, so, when its batteries
are replaced it loses the bonding information (i.e. LTK).

* When bonded, the device sends ADV_DIRECT_IND.
* When not bonded (fresh from factory or due to the batteries being
replaced) it sends ADV_IND containing a special message (let's call it
"power-on") reflecting that it's not bonded. When this happens we need
to regenerate the device's LTK and rebond.

Action 0x02 (even when forwarding the the ADV_IND  report content via
Device Connected event) is not good enough. In fact, none of the
current auto-connect actions work for this device:

* With 0x00, (HCI_AUTO_CONN_REPORT) the content of ADV_IND is
forwarded to userland but there is no auto-connection upon
ADV_DIRECT_IND
* With 0x01, (HCI_AUTO_CONN_DIRECT) there is auto-connection upon
ADV_DIRECT_IND but if the device's batteries are removed (power-on
ADV_IND) the device is not reconnected.
* With 0x02, (HCI_AUTO_CONN_ALWAYS) there is auto-connection upon
ADV_DIRECT_IND but replacing the device's batteries  (power-on
ADV_IND) causes an infinite connection loop: connect->encryption
on->disconnect(due to "encryption on" failing)->connect .... Getting
the report data inside the  Device Connected event won't help because
it will never get to that point.

The alternatives are

1. Keep using passive scanning and add/modify an action to connect
upon ADV_DIRECT_IND and forward ADV_IND to userland (to have the
opportunity or rebonding).
2. Constantly do active scanning, which, again, we would like to avoid.

Thanks,

--=20
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
