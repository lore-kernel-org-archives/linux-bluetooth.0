Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: vtervo@gmail.com
In-Reply-To: <201008121416.31808.oneukum@suse.de>
References: <201008120944.49044.oneukum@suse.de>
	<1281612323.12579.252.camel@localhost.localdomain>
	<201008121416.31808.oneukum@suse.de>
Date: Fri, 13 Aug 2010 09:20:08 -0400
Message-ID: <AANLkTi=odMckPT4pAOiQJm+1NWbk0diL=-9=yKBfj66W@mail.gmail.com>
Subject: Re: resending patch to retry reset in case it failed
From: Ville Tervo <ville.tervo@iki.fi>
To: Oliver Neukum <oneukum@suse.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-usb <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 12, 2010 at 8:16 AM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Donnerstag, 12. August 2010, 13:25:23 schrieb Marcel Holtmann:
>> Hi Oliver,
>>
>> > may I ask what happened to this patch?
>> > Do you take it, want modifications or reject it?
>> >
>> > =A0 =A0 Regards
>> > =A0 =A0 =A0 =A0 =A0 =A0 Oliver
>> >
>> > From af61f0663f095599003290b13ad6fadee1d4fb25 Mon Sep 17 00:00:00 2001
>> > From: Oliver Neukum <oliver@neukum.org>
>> > Date: Tue, 6 Jul 2010 08:08:42 +0200
>> > Subject: [PATCH] bluetooth: retry reset for devices that fail
>> >
>> > Some devices fail to reset properly at the first attempt to reset
>> > them under unknown circumstances. Failures can be identified by
>> > an invalid btaddr. Retry in those cases.
>>
>> I was pondering about it and haven't really made up my mind with this
>> stuff. To be honest, I don't like the patch a little bit. I can see your
>> point why you want it, but the patch is a bit too ugly for my taste.
>
> I am very open to alternatives. But without that it is needed to make the
> hardware work.
>
>> Tell me which device is causing this and I might be able to reproduce
>> this and find small less ugly fix.
>
>
> I happens with this hardware from Broadcom. There may be others I don't
> know about. It is an internal dongle. I don't know whether it can be foun=
d in
> external hardware.
>

Could you share also "hciconfig hci0 revision" and "hciconfig hci0
version" info. And laptop model you have the chip build in.

--=20
Ville
