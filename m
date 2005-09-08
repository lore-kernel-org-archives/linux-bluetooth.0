Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How can I access Internet over PAN?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050908021239.16175.qmail@web15710.mail.cnb.yahoo.com>
References: <20050908021239.16175.qmail@web15710.mail.cnb.yahoo.com>
Content-Type: text/plain
Message-Id: <1126221429.5286.68.camel@blade>
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
Date: Fri, 09 Sep 2005 01:17:09 +0200

Hi Gadfly,

> I want to access Internet through PAN . I have to BT
> modules that work propely on two ARM9 platform (linux
> 2.4.18) .And I can create a BNEP connection between
> the PANU and the NAP following the steps in the
> HOWTO-PAN. 
> 
> 1.
> on NAP side:
> pand --listen --master --role=NAP
> on PANU side:
> pand -c <bt_addr>
> 
> 2.
> on NAP side:
> ifconfig bnep0 10.0.0.1
> on PANU side:
> ifconfig bnep0 10.0.0.2
> 
> Utill now,I can ping each other!
> $ pand --show
> bnep0 4A:49:4E:00:15:2D NAP
> 
> 3.
> on NAP side:
> brctl addbr pan0
> ifconfig pan0 10.0.0.1
> brctl setfd pan0 0
> brctl stp pan0 disable
> brctl addif pan0 eth0
> 
> $ brctl show
> bridge name     bridge id        STP enabled    
> interfaces
> pan0         8000.0000c0ffee08       no          eth0
> 
> on PANU side:
> route add default gw 10.0.0.1
> 
> Then,on PANU I ping the eth0 IP address of NAP ,but it
> says on "NETDEV WATCHDOG: eth0: transmit timed out "! 
> 
> What's the problem? How can I access Internet over
> PAN??
> 
> Do I have to enable ip_forward and iptables? But the
> 2.4.18 kernel seems don't work with these! I have
> build in iptables,but I still can't use "iptables"
> command!

it is a bad idea to bridge between eth0 and pan0. Use IP forwarding and
masquerading for this.

And the 2.4.18 is not a good choice. Try to update it, because I stopped
supporting it a long time ago.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
