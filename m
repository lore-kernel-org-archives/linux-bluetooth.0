Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060817122559.GA6422@srcf.ucam.org>
References: <20060816153432.GA13691@srcf.ucam.org>
	<1155770177.4075.102.camel@aeonflux.holtmann.net>
	<20060816214606.GA21719@srcf.ucam.org>
	<1155819360.4075.123.camel@aeonflux.holtmann.net>
	<20060817113538.GB5118@srcf.ucam.org>
	<1155823499.4075.157.camel@aeonflux.holtmann.net>
	<20060817122559.GA6422@srcf.ucam.org>
Date: Thu, 17 Aug 2006 20:44:06 +0200
Message-Id: <1155840246.4075.173.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBus interface -
	determining	whether	a	device	exists
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

Hi Matthew,

> > For this specific case we should only page the device if the audio
> > device has been opened and there is actually an audio stream. I is not
> > important if the device is in range or not. If it is not in range then
> > you won't hear anything or we need to choose a fallback. I think that
> > these stuff doesn't belong in the core Bluetooth daemon. You want to
> > have an btaudiod that handles all these stuff in the back for you. The
> > user only configures once the possible connections to headphones and
> > headsets and then the daemon will take care of everything.
> 
> The problem isn't just in actually setting up the connections, it's in 
> providing the information about available devices to other applications. 
> Nowadays, the right layer for device enumeration is HAL. If I tell my 
> system about a mobile phone, then the correct behaviour is for it to 
> appear as a HAL object. In order for Network Manager to offer me the 
> choice of connecting via my phone, the phone needs to be in HAL. So, 
> somehow, at login time the phone needs to be added.
> 
> There's two ways of dealing with this. The one that I prefer is that we 
> make some effort to determine that the phone actually exists, and then 
> add it to HAL in the same way that we would if we'd just done device 
> discovery and the phone was discoverable. This needs us to have some 
> mechanism for determining whether the phone actually exists. The second 
> is that we store the HAL data and repopulate HAL at login time. This is 
> more hacky, since we're adding information without even having made a 
> token effort to determine whether the device exists or not.

is the HAL data user specific and do we always need to populate it on
login time. I think doing it once at boot and then update it on regular
basis once hcid has more information about devices and/or new devices.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
