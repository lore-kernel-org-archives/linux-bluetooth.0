Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Achim Bohnet <ach@mpe.mpg.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Debian packages updated
References: <1085586569.18009.7.camel@saag>
In-Reply-To: <1085586569.18009.7.camel@saag>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200405270007.32190.ach@mpe.mpg.de>
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
Date: Thu, 27 May 2004 00:07:31 +0200

On Wednesday 26 May 2004 17:49, Edd Dumbill wrote:
> I uploaded new experimental packages for BlueZ 2.7 to Debian
> experimental (expect them there in a week or so, as bluez-cups is NEW),
> and to the http://bluez.sf.net/download/debian/ repository.  This build
> has DBUS and CUPS enabled.  More details are available in the
> README.Debian file in the bluez-utils package.
> 
> Fuller details available on my blog at
> http://usefulinc.com/edd/blog/contents/2004/05/26-bluez/read
> 
> I'd welcome feedback from users of the older packages, particularly in
> how the 2.4 -> 2.7 upgrade goes, as the bluez-pan and bluez-sdp packages
> have all been subsumed into bluez-utils.

Hi Edd,

first thx for the new pkgs.  Update from 2.6 went smooth
(beside the artefacts of updating testing with bluez.sf.net
pkgs ;)

First impressions:

I'm not sure if I'm a fan of the /etc/init.d/bluez-pan merge into
/etc/init.d/bluez-utils.  Before I could remove the rcX.d links
and let hotplug and/or script call bluez-pan as needed.
I only switch on the bluetooth adapter when needed.  Ditto with pand.
Now I did get lots of useless entries in syslog of pan trying to find
the (nonexisting) NAP ;)

Output of restart of the init.d script is a bit strange:
	Restarting bluez-utils: hidd hcid sdpd hidd rfcomm
hidd entry appears twice (same for pund and dund when enabled)

My M$ bt mouse didn't arrive yet, but I would expect that hidd
adds an SDP record (kdebluetooth didn't show it; running debian
kernel-source 2.6.6 + mh2).  Maybe the mouse will work without
an SDP record.  Nevertheless IMHO a SDP record tells more
to Joe User than a ps | grep ;)

thx again for the pkgs!
Achim
> 
> -- Edd
-- 
  To me vi is Zen.  To use vi is to practice zen. Every command is
  a koan. Profound to the user, unintelligible to the uninitiated.
  You discover truth everytime you use it.
                                      -- reddy@lion.austin.ibm.com


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
