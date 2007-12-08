Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <475B263E.4060801@aircable.net>
Date: Sat, 08 Dec 2007 20:18:22 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <1197153708.12292.247.camel@violet>
In-Reply-To: <1197153708.12292.247.camel@violet>
Subject: Re: [Bluez-users] [BlueZ-Announce] Release of bluez-libs-3.23 and
	bluez-utils-3.23
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
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


> Hi Folks,
>
> this is an update release of the new stable versions of the Bluetooth
> library and the utilities. This release is fixing a crash in the main
> Bluetooth daemon and providing major enhancements for the audio service
Marcel,
I think there's a bug in the automake scripts, both bluez-libs and
bluez-utils. In 64 bits systems if there's lib64 present then both
packages are trying to install to lib instead of lib64. I sent a rather
simple patch for this, but I think it should be more complex, and it
didn't applied to libs only utils
Thanks,
Manuel

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
