Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Ultimate PAN howto. Where?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43832A7D.9080701@gazelasport.sk>
References: <43803CFE.7010601@gazelasport.sk>
	 <1132657962.28644.13.camel@blade>  <43832A7D.9080701@gazelasport.sk>
Content-Type: text/plain
Message-Id: <1132671135.28644.69.camel@blade>
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
Date: Tue, 22 Nov 2005 15:52:15 +0100

Hi,

> >>I'm trying to get PAN running, NAP on linux, 2 PANUs on windows. 
> >>There is no problem with the windows boxes, it gives me headaches to set 
> >>up the linux box however. I got everything running quite fine with just 
> >>one client using non-briged routing, now I would like to bridge bnepX 
> >>and eth0 interfaces so that:
> >>
> >>- IP addresses are asigned by DHCP
> >>- it's possible to connect to internet from NAP box (after following one 
> >>howto it wasn't possible)
> >>- everything is automatic - after the setup anyone should be able to 
> >>turn on the NAP box and connect, even without an account.
> >>
> >>Please, direct me to the right howto, tell me which parts to skip and 
> >>what to do another way.
> > 
> > 
> > actually the automatic part is distribution specific, because you need
> > to create the bridge at startup and run the dedicated DHCP server. You
> > also need to make sure the bnepX devices are added/removed to the bridge
> > when pand accepts a new connection.
> 
> After experimenting I got bridge + DHCP working, it's not automatic but 
> that does not matter now anyway, cause I had to change it back.
> 
> If remote device disconnects, the bnepX interface is not fully unregistered:
> 
> [/var/log/messages]:
> 
> kernel: pan0: port 1(bnep0) entering disabled state
> net.agent[12626]: remove event not handled
> kernel: unregister_netdevice: waiting for bnep0 to become free. Usage 
> count = 1
> 
> The last message is repeated at regular intervals.
> 
> `brctl show` shows bnep0 in pan0 bridge interface
> 
> `brctl delif pan0 bnep0` results in "interface bnep0 does not exist!"
> 
> `ifconfig` or `ifdown bnep0` freeze up
> 
> I can't even turn of the computer regulary, I have to hard reset it.
> 
> Is this a bug?

sounds like a bug in the bridge code. What kernel do you use?

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
