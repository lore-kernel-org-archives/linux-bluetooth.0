Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300805020635k168c72b7tac1502e905f1c30a@mail.gmail.com>
Date: Fri, 2 May 2008 07:35:04 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <48199A3D.6030800@powercraft.nl>
MIME-Version: 1.0
References: <48171A58.8060200@powercraft.nl> <4817DAE3.6050406@gmail.com>
	<d89ddf300804291959m6589b95fse31e8227c37c8f1f@mail.gmail.com>
	<4818E1B3.6000900@powercraft.nl>
	<d89ddf300804302008h651289d5q82eaf8f054c697a8@mail.gmail.com>
	<48199A3D.6030800@powercraft.nl>
Subject: Re: [Bluez-users] step by step - how to get your bluetooth stereo
	headset fully working with the bluez software stack under linux
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

Jelle

>  xine and alsa do not work very well.... and for now there will be no
>  attempts to fix this...?

some combinations are problemaic, but it's tricky and there's a lot to do...

>  1. How can we make bluez reserve 278kbps for an a2dp headset?

we don't have quality of service. it's not even in the current spec.

what you are seeing sounds more like a bug... if there is a single
piconet, no scans are being started, then we should get good
consistent throughput.

>  2. How can we make bluez force all a2dp headsets to become master
>  instead of slave?

other services have to behave too. since there isn't a way to tell
services individually to role switch, the best we can do is put this
in hcid.conf. (I think you already did this)

lm accept,master;
lp hold,sniff,park;

>  3. How can we make bluez continue to sent data to the headset even when
>  a new bluetooth devices connects.

iirc, it's outbound connections from your computer that briefly create
a scatternet until the role switch happens. there's no way around it.

>  4. Will pulse and gstreamer and bluez be able to work on a 200 MHz ARM
>  system.... please keep things usable for embedded devices...

I've noticed gstreamer does take too much cpu, but everything else
behaves. I've been testing this stuff on a 400mhz gumstix... I like to
see it scale down too.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
