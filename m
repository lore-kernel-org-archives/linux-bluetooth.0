Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: Lalith Chakravarthi <lalithvc@yahoo.com>,
   bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] USB Dongle to Dongle -- Connection
References: <20040305094657.98433.qmail@web40713.mail.yahoo.com>
In-Reply-To: <20040305094657.98433.qmail@web40713.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403051606.50925.pavouk@pavouk.org>
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
Date: Fri, 5 Mar 2004 16:06:50 +0100

Hello,

> I can even ping between the two. But I dont understand how I can
> transfer files between the two computers. I checked using the sdptool
> but the only service that can be found on the other computer is the sdp
> server running.

If you can ping on IP layer, you have probably BNEP0 interface active and you 
can use standard tools like FTP or SCP.

If you can ping with "l2ping" and you haven't activated some service on L2, 
you must run "pand" with right parameters on both sides.
After this you must add config file /etc/sysconfig/network-scripts/ifcfg-bnep0 
with IP parameters. You can config this automatically by hotplug.

Please find mails in list with subject "hotplug USB dongle problem" from 28 
Feb 2004.

Best regards,

Pavel Ruzicka



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
