Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Key step in bluetonium setup, bcm203x does not
	load firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: gonzalo briceno <gonzalohbriceno@yahoo.com>
Cc: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>,
   bluez-users@lists.sourceforge.net
In-Reply-To: <20040905073705.47183.qmail@web52803.mail.yahoo.com>
References: <20040905073705.47183.qmail@web52803.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1094459053.5145.9.camel@notepaq>
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
Date: Mon, 06 Sep 2004 10:24:13 +0200

Hi Gonzalo,

> You are completely right.  I followed your instructions and my
> Broadcom Bluetonium (bcm203x module) based chip is working.  I hope I
> did not gloss over any section of information although I am almost
> positive that I did not.  Anyways, any one having this problem has to
> simply download bluez-firmware and copy the broadcom files onto
> /usr/lib/hotplug/firmware.  

the /usr/lib/hotplug/firmware was the old place for firmware files and
we came to the conclusion that putting them into /lib/firmware is much
better. The Debian Sarge/Sid and the upcoming SuSE 9.2 support both
directories, so it is a problem of the hotplug package of your
distribution.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
