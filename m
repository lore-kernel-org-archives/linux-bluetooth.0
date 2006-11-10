Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455454C6.8090202@evision.de>
Date: Fri, 10 Nov 2006 11:30:30 +0100
From: Tobias Wolf <tobias.wolf@evision.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <454B37A5.5000307@evision.de> <454B389A.6050103@evision.de>
	<45536B18.1020803@free.fr>
In-Reply-To: <45536B18.1020803@free.fr>
Subject: Re: [Bluez-devel] Bluetooth-Alsa: headsetd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fabien Chevalier schrieb:
> Tobias,
> 
> I'm gonna soon send a new release of the plugin, the daemon, and the 
> kernel patch to the list, you might wanna give it a try.
> 
> Cheers,
> 
> Fabien
> 
Thx a lot.

I have been experimenting a little bit in the last days. I have mangaged
to use the alsa-plugin with xmms and it works.

But my softphone (EKIGA) doesn't allow me to manually type the alsa
device. Maybe i have to give the EKIGA-Community a hint, maybe they
change this.

But there is a more basic problem with sound quality and i want to know
if anyone of the has experienced the same.

If i use the kernel module snd_bt_sco and btsco2, i am able to make
phone calls with ekiga. But the people i have called told that sound
quality changed over time from good to very bad, in the end they get a
loud noise sound, and after that sound quality is good for a moment.
This repeats ever on.

As I understand bluetooth there are a set of frequencys and they are
changed frequently between the dongle and the headset. May it be, that i
have something in my enviroment that disturbs some frequencys, that
bluetooth uses, and everytime my headset reaches that region, sound
quality degrades ?

I say this, because we have an windows pc in the same room, and if the
make a call with bluetooth headset over this pc, the caller experiences
the same.

Tobias

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
