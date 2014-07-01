Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <724A0273-FB02-49DF-B286-4C3440C049F7@holtmann.org>
References: <1403897492-6233-1-git-send-email-scott@netsplit.com>
	<B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org>
	<CA+bD78j4bSfqvn7MHnsV7PKp_dGXN4dLApW2G5p4oN-Tsu+h1Q@mail.gmail.com>
	<F49C47A1-077C-41E2-A36B-3DE9EF1A9E19@holtmann.org>
	<CA+bD78j4RfvZdMoKLcfDdtsy1g_bgZ-vnbAOY80W_JcZDNuEyA@mail.gmail.com>
	<E324D0BB-4042-4E4F-8F14-16B09C34B259@holtmann.org>
	<724A0273-FB02-49DF-B286-4C3440C049F7@holtmann.org>
Date: Tue, 1 Jul 2014 09:09:15 -0700
Message-ID: <CA+bD78g+AU4VKq5qPLGBGQM1+2ciqVmm77VvETw2XmBV_cM=sQ@mail.gmail.com>
Subject: Re: [RFC] doc: Add EIR to device properties
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 1, 2014 at 8:58 AM, Marcel Holtmann <marcel@holtmann.org> wrote=
:

>>> This would place the EIR/AD/SR data in the device objects as a property=
 then?
>>
>> we could do that, but I would like to discuss this a bit more. For examp=
le we might not duplicate the information that we have properties for. For =
example device name or appearance.
>
> coming to think about it, we might should just focus on the manufacturer =
specific field and make sure that gets exposed over D-Bus. The other ones a=
re Bluetooth SIG defined and we can define good properties for it.
>

The main missing SIG defined fields which don't have properties would be:

 - TX Power (CSSv4 1.5)
 - URL (https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=
=3D287247)

All of the others are reasonably internal to BlueZ and not of interest
to applications.

> We could add a property with array{uint16,array{byte}} that allows us to =
provide all the manufacturer information we find. On BR/EDR they are pretty=
 static and would just stay around. On LE they would be removed (same as RS=
SI) once the result becomes invalid. For dual-mode devices found on both tr=
ansports we just combine them.
>

If multiple fields of manufacturer data for the same manufacturer are
found, we'd just duplicate them in the array? e.g.

 [
    ( 004C, [ 01, 08, ... ] ),
    ( 004C, [ 02, 15, ... ] )
  ]

For a fruit-flavored device acting as both an Airdrop target and an
iBeacon (this seems to be how they show up - but could be a side
effect of one field being in AD and one in SR)

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?
