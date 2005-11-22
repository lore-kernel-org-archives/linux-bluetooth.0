Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Ultimate PAN howto. Where?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43803CFE.7010601@gazelasport.sk>
References: <43803CFE.7010601@gazelasport.sk>
Content-Type: text/plain
Message-Id: <1132657962.28644.13.camel@blade>
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
Date: Tue, 22 Nov 2005 12:12:42 +0100

Hi,

> I'm trying to get PAN running, NAP on linux, 2 PANUs on windows. 
> There is no problem with the windows boxes, it gives me headaches to set 
> up the linux box however. I got everything running quite fine with just 
> one client using non-briged routing, now I would like to bridge bnepX 
> and eth0 interfaces so that:
> 
> - IP addresses are asigned by DHCP
> - it's possible to connect to internet from NAP box (after following one 
> howto it wasn't possible)
> - everything is automatic - after the setup anyone should be able to 
> turn on the NAP box and connect, even without an account.
> 
> Please, direct me to the right howto, tell me which parts to skip and 
> what to do another way.

actually the automatic part is distribution specific, because you need
to create the bridge at startup and run the dedicated DHCP server. You
also need to make sure the bnepX devices are added/removed to the bridge
when pand accepts a new connection.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
