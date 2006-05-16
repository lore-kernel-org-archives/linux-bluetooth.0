Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Support for Logitech Wireless Music System
From: Per Thomas Jahr <perja@extern.uio.no>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4453B258.10601@xmission.com>
References: <1146324837.4199.11.camel@localhost.localdomain>
	 <4453B258.10601@xmission.com>
Content-Type: text/plain
Message-Id: <1147778075.2977.4.camel@pc098.coreteam.oslo.opera.com>
Mime-Version: 1.0
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
Date: Tue, 16 May 2006 13:14:35 +0200

On Sat, 2006-04-29 at 12:37 -0600, Brad Midgley wrote:
> Hi
> 
> > Does anyone know if 'Logitech Wireless Music System for PC' [1] works
> > with the bluetooth-alsa project? From some googling it seems to use at
> > least A2DP (and maybe also AVRCP). 
> > 
> > [1]
> > http://www.logitech.com/index.cfm/products/details/US/EN,CRID=2416,CONTENTID=10855
> 
> I haven't heard of anyone using it, but we've had good luck hooking up
> with a2dp gear. We may need a tweak in the stream setup if they do
> anything wacky but I suspect it will just work.

Looks like it just works. Hardware.no has tested it with FC5 and it
seems to show itself as a sound card. Nice!

Sorry, only in Norwegian:
http://www.hardware.no/tester/lyd/logitech_wireless_music_system/26008/4

It also says they had problems with the dongle and the receiver loosing
contact with each other between uses. They had to press the connect
button on the dongle to get the connection up again.

-- 
Per Thomas



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
