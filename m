Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001501c9381a$022b7f40$06827dc0$@de>
References: <001501c9381a$022b7f40$06827dc0$@de>
Date: Mon, 27 Oct 2008 19:03:43 +0100
Message-Id: <1225130623.7157.10.camel@californication>
Mime-Version: 1.0
Cc: 'Frans de Bont' <frans.de.bont@philips.com>
Subject: Re: [Bluez-devel] Bad encoding performance of Linux SBC audio codec
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Christian,

> I have made some extensive study on the compression performance of Linux's
> SBC audio codec in comparison to the reference implementation.
> 
> I am sorry to say that the audio quality of the open source version of SBC
> is far worse than the reference implementation.
> 
> Can anybody confirm these results?
> Do you have any idea why the performance is so worse?

are you talking about the encoder or the decoder. For the encoder, I
can't see the big difference. For the decoder you can clearly hear that
we get the volume wrong.

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
