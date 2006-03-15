Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <44187349.9090804@darkmetatron.de>
From: =?ISO-8859-1?Q?Sebastian_Be=DFler?= <webmaster@darkmetatron.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Multimedia keys (Microsoft keyboard)
References: <BAY12-F257741C2F24AE15EB32DD4B5E60@phx.gbl>
In-Reply-To: <BAY12-F257741C2F24AE15EB32DD4B5E60@phx.gbl>
Content-Type: text/plain; charset=us-ascii
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
Date: Wed, 15 Mar 2006 21:04:25 +0100

Michael Alladin wrote:

> Could it be possible that some special mode needs to be enabled? Multimedia 
> keys seem to work in windows xp without needing to press anything.

You need to apply the kernel patch found here
http://www.bluez.org/patches.html and rebuild your kernel.

The keyboard then shouldn't be running in boot-protocol-mode anymore and
the multimedia-keys can be assigned to what ever you want.

I am still waiting for the happy day when the kernel-gurus add this
wonderful piece of code to the official kernel. Even -mm would make me
happy....

Sebastian


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
