Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1099310550.28599.132.camel@baroque.rococosoft.com>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3BFE@il93exb05.corp.mot.com>
	 <1099061231.10164.62.camel@pegasus>
	 <1099062653.28599.47.camel@baroque.rococosoft.com>
	 <1099068050.10164.69.camel@pegasus>
	 <1099310550.28599.132.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1099311470.16247.82.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 01 Nov 2004 13:17:50 +0100

Hi Steve,

> > However this also leads to a security problem, because I can scan the
> > RFCOMM ports of a remote device without forcing the security mechanism.
> > I only have to do the PN exchange and then disconnect. What should a
> > remote device do when a PN CMD comes in for a channel without a service
> > behind it?
> 
> If the spec says that authentication can only happen on receipt of SABM,
> then I guess this leaves it open to port scans. 
> 
> However, does this really matter? If you want to protect _all_ services,
> use security mode 3. If you're in security mode 2, it's most likely that
> you can do SDP searches without performing a security procedure and
> discover open channels that way.

yes, it matters, because security mode 3 is never the answer to any
security related problems. You still need a very good policy engine
behind the security manager to protect your device. I would advice
anybody not to use security mode 3, even if the device supports only a
single service. A single trust model is not working.

> > Sorry, I don't get the point. Why should a client care about security
> > mode 2, when it want to connect to a server in security mode 1. Actually
> > the server must know what services to protect and not the client. If you
> > have such server running, then this is a wrong designed server from my
> > point of view.
> 
> Well, for example, a client may wish to authenticate a server before
> connecting to it, irrespective of the security the service wants for
> itself.

I still don't see the full need behind this, but send in a clean patch
for it and I will apply it. There should be no problem to support it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
