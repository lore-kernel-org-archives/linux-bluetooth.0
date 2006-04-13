Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <443E9EF5.90901@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] error when loading snd-bt-sco
References: <443D4707.80402@pagestation.com> <443E672A.1080506@xmission.com> <443E6F32.5000008@pagestation.com>
In-Reply-To: <443E6F32.5000008@pagestation.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 13 Apr 2006 12:56:53 -0600

Jerry

> I went into the alsa-driver directory did a "./configure
> --with-cards=all" so as to include
> the emu10k1. did the make and make install, redid alsa-libs, redid
> alsa-utils, rebooted.
> recomiled btsco and btsco/kernel.
> 
> then when I tried to "modprobe snd-bt-sco" I get the same issue... many
> warnings about unknown symbols.

Are you using the standalone alsa download? We've only gotten it to work
with the integrated alsa in recent kernels.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
