Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<005f01c3302e$ca3537a0$0181a8c0@zaz1>
	<200306282005.08403.justin-qt@affinix.com>
In-Reply-To: <200306282005.08403.justin-qt@affinix.com>
Cc: "Xavier Garreau" <x.garreau@prim-time.fr>, Stephen Crane <steve.crane@rococosoft.com>
MIME-Version: 1.0
Message-Id: <200306282117.57840.justin-qt@affinix.com>
From: Justin Karneges <justin-qt@affinix.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 28 Jun 2003 21:17:57 -0700
Content-Type: text/plain; CHARSET=iso-8859-1

Ok, I thought of a few more things, so to jumpstart the discussion I'll say 
them now:

> > It installs the files in the right directories, make the symlinks, try to
> > guess what card it is and bring device up.

First, what is this about card detection during ipk install?  I didn't have a 
problem with that (I inserted my card after install), and IMO there should be 
no such detection in the installer if there is.

Second, rfcomm is missing.

Third, the /dev nodes are not created.  When they are, ensure that they can 
survive a reboot.

For the future, I think hcid should be run on install and on future bootups, 
as it is required to do anything useful.  I'm not sure about sdpd though (i 
admit i'm not up on what sdp does, can someone shed some light if this is 
needed?).  Whatever daemons are run should have proper pid accounting in 
/var, so that front-ends can access them.  For instance, my GUI that modifies 
/etc/bluetooth/hcid.conf will need a way to find hcid's pid so it can send 
HUP.

Then also pin handling:  There should be a /usr/bin/bluepin that does the 
following:
  - check to see if Qtopia is up.
  - if not, echo ERR.
  - else, call my qt btpin program (let's assume it is /usr/bin/btpin)

This way the pin should properly work even during the moment where hcid is 
running but qtopia is not fully booted yet.
  
I think this should do it.  Am I missing anything?

By the way, you may see my GUI package here:

  http://www.affinix.com/~justin/zaurus-bluetooth-0.6.tar.gz

It is rather old, but works.  Unfortunately, it seems the dialer part does not 
work on the new Sharp ROM.  Argh, I'll have to fix this ..

-Justin


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
