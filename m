Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050512183747.75536.qmail@web21125.mail.yahoo.com>
From: Vinod <geekvinod@yahoo.com>
Subject: Re: [Bluez-users] trouble setting up pand
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 12 May 2005 11:37:47 -0700 (PDT)


> > 1) modprobe bnep's on both ipaqs
> > 2) set one as master and confirmed it
> > 3) pand --listen --role GN on the master
> > 4) pand --connect 'master-address' which i got
> from
> > hcitool scan
> 
> skip step 2, because it may cause troubles.

tried skipping step 2 and set both back as
slaves,resulting in same error.
 
> > Then i get the following message
> > 
> > root@h3600:/etc/bluetooth# udhcpc[29501]: udhcpc
> > (v0.9.9-pre) started
> > udhcpc[29501]: SIOCGIFINDEX failed!: No such
> device
> 
> What else do you see in the syslog. Run "hcidump -X
> -V" as root to check
> the BNEP connection setup.
Unfortunately the latest familiar version(0.8.2),
which i have, does not have hcidump in its linux
distribution. And i still havent figured a way out to
compile with gcc on my ipaq. is there any other other
way to check bnep0 status? Doing ifconfig bnep0
returns

ifconfig bnep0
ifconfig: bnep0: error fetching interface information:
Device not found

So i believe bnep connection does not exist.

would appreciate if you let me know if any other
workaround exists until i figure out a way to run make
on my ipaq.

Vinod




		
Yahoo! Mail
Stay connected, organized, and protected. Take the tour:
http://tour.mail.yahoo.com/mailtour.html



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
