Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN
From: Marcel Holtmann <marcel@holtmann.org>
To: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <f79eaf238e.f238ef79ea@estudiants.urv.es>
References: <f79eaf238e.f238ef79ea@estudiants.urv.es>
Content-Type: text/plain
Message-Id: <1083067127.28880.175.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 27 Apr 2004 13:58:47 +0200

Hi Albert,

> I already have two computers to try the PAN on them
> with two USB dongles,  but I still have some problems.
> 
> In one computer I run:
> 
> modprobe bnep
> hcid
> pand --listen --role GN
> 
> And in the other one:
> modprobe bnep
> hcid
> pand --connect 00:0A:3A:50:20:3C
> 
> then, I look at ifconfig (on both sides) and the
> connection is ok for a while, but when I check
> ifconfig again it has disappeared!!
> 
> Then, If _I do a pand --show on the client side, I
> see nothing, but on the master side, it is shown as
> if the connection was still ok!
> 
> Could you help me to mantain stable this connection??

try to use "ifconfig -a" so you also see unconfigured interfaces. Do you
have somekind of DHCP running? What Bluetoth chip is on the Belkin
dongles (check with "hciconfig -a")? Run "hcidump -w <file>" as root on
one machine and send us the binary dump file. Do you see any errors when
calling dmesg?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
