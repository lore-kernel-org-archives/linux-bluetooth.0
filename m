Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: New HCI-USB device, no MAC?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <444CAE4F.70404@kernelconcepts.de>
References: <4410090A.3070706@kernelconcepts.de>
	 <1141912311.4605.9.camel@aeonflux.holtmann.net>
	 <44104DD5.80109@kernelconcepts.de>
	 <1141923373.4605.39.camel@aeonflux.holtmann.net>
	 <loom.20060412T215427-611@post.gmane.org>
	 <444CAE4F.70404@kernelconcepts.de>
Content-Type: text/plain
Message-Id: <1145876694.21987.28.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 24 Apr 2006 13:04:54 +0200

Hi Nils,

> > Did anyone ever find a solution/workaround for these ISSC-based dongles?  I seem
> > to have acquired two dongles with a BD_ADDR of 11:11:11:11:11:11 and from
> > searching Google, it seems that a lot of other people are in the same boat.
> 
> I have contacted ISSC about that issue.
> 
> Hopefully the will reply and send the HCI or whatever commands
> necessary... I have two of those dongles which renders at least one
> useless (I guess two times the same BDADDR will not work in a piconet ;)

actually it should work, but at the moment BlueZ is blocking this. You
can't connect to yourself.

Regards

Marcel




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
