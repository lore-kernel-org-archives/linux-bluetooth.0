Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multisync Bluetooth No devices
From: Andy Beuth <andy@beuth.info>
Reply-To: andy@beuth.info
To: Olivier Bornet <Olivier.Bornet@puck.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040811083602.GA12856@puck.ch>
References: <1092127580.9886.56.camel@goya>
	 <1092127904.4564.79.camel@pegasus>  <20040811083602.GA12856@puck.ch>
Content-Type: text/plain
Message-Id: <1092214835.13600.1.camel@goya>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 11 Aug 2004 11:00:35 +0200

Hello,

Thanx. Its working.

Andy

Am Mi, den 11.08.2004 schrieb Olivier Bornet um 10:36:
> Hello,
> 
> > > I run debian unstable with kernel 2.6.7 and mh4 from Marcel Holtmann
> > > (thanx). My problem is the following. By booting my pc i got the message
> > > No devices in HCI mode found.
> > > The Bluetooth Button in the "Connect with" selection is only grey.
> > > Any Idea??
> > 
> > the Multisync package maintainer linked the Bluetooth plugin against the
> > libsdp which is no longer present. File a Debian bug report, because
> > this is not a BlueZ problem.
> 
> Now, the new libmultisync-plugin-irmc-bluetooth version 0.82-3 is
> working as expected with libbluetooth1 2.9-1.
> 
> So, try to update/upgrade your system now, and it must works.
> 
> Good day.
> 
> 		Olivier
-- 
        Andy Beuth
      andy@beuth.info
      D1: 0175/3217530   
    
            \|||/
            (o o)
---------ooO-(_)-Ooo-----
* Don't drink as root!! *
-------------------------
http://www.beuth.info



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
