Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4453B258.10601@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Support for Logitech Wireless Music System
References: <1146324837.4199.11.camel@localhost.localdomain>
In-Reply-To: <1146324837.4199.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Sat, 29 Apr 2006 12:37:12 -0600

Hi

> Does anyone know if 'Logitech Wireless Music System for PC' [1] works
> with the bluetooth-alsa project? From some googling it seems to use at
> least A2DP (and maybe also AVRCP). 
> 
> [1]
> http://www.logitech.com/index.cfm/products/details/US/EN,CRID=2416,CONTENTID=10855

I haven't heard of anyone using it, but we've had good luck hooking up
with a2dp gear. We may need a tweak in the stream setup if they do
anything wacky but I suspect it will just work.

We only have test code for using avrcp, so some work remains to do
interesting controls with it.

If we could get it to receive from a linux machine running a2recv, I
would be very interested to see what the volume control sequences from
their gear look like.

Brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
