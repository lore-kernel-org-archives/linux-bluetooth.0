Return-Path: <cyrus@holtmann.org>
Message-Id: <995FBD61-D646-40B3-BEE9-9DB7AF1FD688@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <a1c657a80811180050t60170621ibf9f5049f2103682@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Mon, 24 Nov 2008 03:52:22 +0100
References: <a1c657a80811180050t60170621ibf9f5049f2103682@mail.gmail.com>
Subject: Re: [Bluez-users] How to make bluetoothd-service-audio don't record
	the last headset information
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Paul,

>     After i used aplay -D bluetooth /***.wav to play music , i  
> changed the headset device address in the /etc/asound.conf and run  
> aplay again, but bluez also to
> connected  the old device address , so i can't use the new headset.  
> Is there some method to fix this issue, thanks ?

what version of BlueZ are you using?

Regards

Marcel


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
