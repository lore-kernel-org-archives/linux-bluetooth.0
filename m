Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <35c90d960808300037h242dbf5fkd584bf552ed50190@mail.gmail.com>
References: <1220050803-30362-1-git-send-email-npelly@google.com>
	<1220086722.7145.33.camel@californication>
	<35c90d960808300016t1ea8b8eq638a399e7d04b1e9@mail.gmail.com>
	<1220088521.7145.51.camel@californication>
	<35c90d960808300037h242dbf5fkd584bf552ed50190@mail.gmail.com>
Date: Sat, 30 Aug 2008 12:04:19 +0200
Message-Id: <1220090659.7145.71.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Advertise Telephony service class
	when	device offers headset AG or handsfree AG
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Nick,

> So I looked at the headset and handsfree spec, they do not require
> that AG's set the telephony bit. sigh.
> 
> But I can tell you for a fact that the Nokia 616 carkit will not pair
> unless you set the telephony bit. That is what triggered this patch.

that looks like a really broken device to me. How can it pass the
qualification if it mandates that bit. Is PTS setting it by accident.

> We have yet to find a device (and we have tested hundreds now) that is
> not compatible because of the telephony bit. It is a safe change to
> make.

Check your patch with PTS headset/handsfree and the IOP part. I am not
sure if we can just enable service bits as we like.

So in case I can be convinced to take this patch, it has to be in a
separate case statement and with a comment that the Nokia 616 is just a
plain stupid broken device and that is why we did it. The spec. doesn't
mandate this.

I also realized that the Nokia 616 might just is lucky in the interop
department since most phones also implement DUN, FAX or SAP and thus the
telephony bit is set.

This brings me to another question, why don't you just use the serial
proxy support we have and point it to one of the multiplexed TTYs of
your GSM unit. Then you get DUN support and that broken Nokia device
would also work :)

So what about the desktop case that enables HS-AG and HF-AG? Are these
phones? Does headset profile really mean that you have to be phone. Not
likely. With the GSM requirements of handsfree, maybe.

> So sure, you can reject the patch on the basis that it is not mandated
> by the specification. But if you care about compatibility then it
> seems like a good change to make. Especially since you now ignore the
> service class in hcid.conf so there is no easy way to override.

Even before you had no way to set. The automatic service bit
manipulation would have overwritten it. You can actually just call out
to hciconfig if you really wanna overwrite it, but that is a pretty bad
idea. It gives you more pain than anything else.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
