Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44F7115D.6080700@pracucci.com>
References: <44F6EB3F.8030800@pracucci.com>
	<Pine.LNX.4.63.0608311415010.8795@redbean.intranet.gw-instruments.de>
	<44F6FD0A.1090900@pracucci.com>
	<1157041796.4026.133.camel@aeonflux.holtmann.net>
	<44F7115D.6080700@pracucci.com>
Date: Thu, 31 Aug 2006 21:23:05 +0200
Message-Id: <1157052185.4026.142.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] ioctl: setting link mode and link policy
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

Hi Marco,

> >> I would like to set a "global" link mode and link policy that will be
> >> the default for every connection. Something similar to hcid.
> >>     
> > what do you expect from doing this? It is not a good idea to change it
> > globally except you know exactly what you are doing. Changes these
> > settings can have implications you might not be aware of. So what is
> > your purpose on changing them?
> >   
> I would become master on incoming connections and I would deny role
> switch on outgoing connections. If I'm not wrong, I should set MASTER as
> link mode and disable role switch from link policy.

this can't work. You must allow role switching. The initiator of a
piconet is always the master in the first place. They have to switch the
role to make the acceptor the master. So don't touch the link policy, it
must allow the role switch. Setting the link mode to MASTER will request
an immediate role switch after connection creation. However if both
sides have the MASTER link mode set, you will never get a connection,
because the initiator will refuse the switch the role.

> However, I can't use
> hcid, so I would do this from a custom application.
> Is it possible?

It is not wise at all to work without hcid. And you know that your
custom application must be placed under GPL.

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
