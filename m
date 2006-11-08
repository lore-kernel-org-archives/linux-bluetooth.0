Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45512CE3.9030305@xmission.com>
Date: Tue, 07 Nov 2006 18:03:31 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45504DFF.1000101@evision.de>
In-Reply-To: <45504DFF.1000101@evision.de>
Subject: Re: [Bluez-users] 2-way audio for telephony
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

Tobias

> does anyone had success with 2-way audio without kernel module
> snd_bt_sco, as described here :
> 
> https://help.ubuntu.com/community/BluetoothAudio
> 
> I've been trying to follow the instructions but i can't get ALSA to
> report the Audio device so that i am able to select it in my softphone
> (EKIGA in my case).
> 
> Any input will be greatly appreciated ...

You have to just set the alsa device to
 headset
manually, ie it won't appear in a dropdown. Some apps won't let you type
in the name of the device and they don't use the extended api for
listing output plugins. That would be a bug in the app.

Brad



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
