Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <436E46E8.1060201@bglug.it>
From: jimmi <jimmi@bglug.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco + aplay produces only silence on headset
References: <17261.23534.882674.809679@waldo.lisle.iphase.com>	<436DB826.2090406@libero.it> <17262.9574.50552.492352@waldo.lisle.iphase.com>
In-Reply-To: <17262.9574.50552.492352@waldo.lisle.iphase.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sun, 06 Nov 2005 19:09:44 +0100

bbosch@iphase.com ha scritto:
> for a long time.  Are you saying I also must configure the sound
> system _not_ to be built as modules even from the 2.6.14 kernel
> source?  In other words, must CONFIG_SND be set to "y" rather than
> "m"?

This was my interpretation; reading again the whole sentence you may be 
rigth, but I would give it a trial ;)

Another tip: did you ever used the sound on that machine ? If not, run 
alsamixer and enable the master.

Jimmi


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
