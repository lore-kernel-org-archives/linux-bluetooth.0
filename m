Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] trouble setting up pand
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050512164349.94082.qmail@web21122.mail.yahoo.com>
References: <20050512164349.94082.qmail@web21122.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1115916973.18499.56.camel@pegasus>
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
Date: Thu, 12 May 2005 18:56:13 +0200

Hi Vinod,

> I am having some trouble setting up my pand
> connection between two ipaq's running familiar 0.8.2.
> 
> bluetooth is active on both devices.I followed the
> pand howto by doing:
> 1) modprobe bnep's on both ipaqs
> 2) set one as master and confirmed it
> 3) pand --listen --role GN on the master
> 4) pand --connect 'master-address' which i got from
> hcitool scan

skip step 2, because it may cause troubles.

> Then i get the following message
> 
> root@h3600:/etc/bluetooth# udhcpc[29501]: udhcpc
> (v0.9.9-pre) started
> udhcpc[29501]: SIOCGIFINDEX failed!: No such device

What else do you see in the syslog. Run "hcidump -X -V" as root to check
the BNEP connection setup.

> do i need to load some stuff somewhere? I did not
> follow some of the initial package installations as i
> thought all were now integrated into the linux kernel
> (mine is Linux version 2.4.19-rmk6-pxa1-hh37).

Not that I know of. However never version are always better.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
