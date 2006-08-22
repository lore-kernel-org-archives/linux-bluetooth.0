Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44EB3396.6010209@xmission.com>
Date: Tue, 22 Aug 2006 10:40:54 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44EB22DE.4050802@jambit.com>
In-Reply-To: <44EB22DE.4050802@jambit.com>
Subject: Re: [Bluez-users] Cannot get correct iface number from snd-bt-a2dp
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Frank

snd-bt-a2dp? are you talking about the old sco kernel module or the new
a2dp plugin?

iirc, the alsa api has two ways to probe devices. one will not get any
of the userspace plugins such as our a2dp plugin.

Brad

> I have installed the alsa package version 1.0.8 on Linux 2.6.17.7 and
> succeeded in compiling and loading snd-bt-a2dp.
> 
> snd-bt-a2dp is on card 1 device 0. card 0 device 0 is snd-intel8x0.
> 
> My program first tries to find A2DP devices, but it fails. When
> it asks for snd_hwdep_info_get_iface(), it receives 0, tho
> A2DP should be SND_HWDEP_IFACE_BT_A2DP, which is 15.
> 
> When I debug snd-bt-a2dp on modprobe, I see that it stores
> SND_HWDEP_IFACE_BT_A2DP (15) in its structure before registering.
> 
> Is there still something, I have to do, before I start my program or
> what else is wrong? I would be very thankful for any hint.
> 
> Frank
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
