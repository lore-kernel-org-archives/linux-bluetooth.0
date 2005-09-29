Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: gl@dsa-ac.de
Cc: bluez-users@lists.sourceforge.net, Maksim Krasnyanskiy <maxk@qualcomm.com>
In-Reply-To: <Pine.LNX.4.63.0509291329280.11341@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0509291329280.11341@pcgl.dsa-ac.de>
Content-Type: text/plain
Message-Id: <1128011935.30743.17.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Re: [2.4.30] RFCOMM race
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
Date: Thu, 29 Sep 2005 18:38:54 +0200

Hi Guennadi,

> I have a "buggy" user-space program (attached, careful - it IS buggy:-)), 
> communicating over rfcomm, that quite often hangs itself in the 
> uninterruptible (D) state.
> 
> Ok, the program IS buggy, but, I think, it shouldn't hang in "D" and 
> render the entire Bluetooth subsystem unusable?
> 
> How: it forks, the child tries to connect to a non-existing peer, at this 
> time the parent issues ioctl(HCIDEVDOWN); ioctl(HCIDEVUP); the DOWN wakes 
> the child up and it dows ioctl(HCIDEVDOWN) too. That's it. On the 
> USB-analyser I see an incomplete HCI Reset, interrupted by the "Read local 
> supported features" - from the UP. (screenshot attached)
> 
> The question is, of course, where (apart from the program) is the bug? I 
> have to say, that the bluletooth module is connected to an "unsupported" 
> USB controller, the driver for which I am debugging. I thought, naturally, 
> that the bug is there. But now I am not sure. Is this really the case? If 
> yes, what might it be doing wrong? Or is it rfcomm?

is it reproducible with the latest 2.6.14-rc2 kernel running on a i386
or x86_64 system?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
