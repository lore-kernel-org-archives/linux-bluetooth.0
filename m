Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] (no subject)
From: Marcel Holtmann <marcel@holtmann.org>
To: Geert Geurts <geert@ebm.nl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1080503792.10768.4.camel@geert.ebm.nl>
References: <1080503792.10768.4.camel@geert.ebm.nl>
Content-Type: text/plain
Message-Id: <1080505664.2281.132.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 28 Mar 2004 22:27:44 +0200

Hi Geert,

> I've been working to get my palm to connect using bluetooth....
> Guess wat my problem was... I had the affix drivers also
> installed/loaded ....ughh... yea stupid wanker I know. I've got it
> working using affix (sorry, It started to work faster...)now, anyways
> why should I swich to bluez?? I know if I don't want to I don't have to
> but putting it in a other way why is bluez part of the kernel and not
> affix?

BlueZ is the official Linux Bluetooth stack and it is a well written and
designed Bluetooth stack. Look at my slides from

	http://www.holtmann.org/papers/bluetooth/wtc2003_slides.pdf

and search the one which compares the mailing list activity of both. You
can decide by yourself why BlueZ is part of the kernel and why Affix is
not. If it comes to the source code, the supported protocols & profiles
and hardware drivers BlueZ always wins.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
