Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Piconet problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <IA5EZL$515602A938C639AD7C0D84FB93EBFF70@libero.it>
References: <IA5EZL$515602A938C639AD7C0D84FB93EBFF70@libero.it>
Content-Type: text/plain
Message-Id: <1105445208.8056.17.camel@pegasus>
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
Date: Tue, 11 Jan 2005 13:06:48 +0100

Hi Jers,

> I'm still trying to create a simple piconet with a master and two slaves. I upgrated my bluez and, on your website, I red the firmware of my dongles (Digicom Palladio CSR) is fit for my aims.
> Now the situation is as follows:
> 
> On the three sides I type
> 
> # modprobe bnep
> 
> On the master side:
> 
> # brctl addbr pan0
> # ifconfig pan0 10.0.0.1
> # brctl setfd pan0 0
> # brctl stp pan0 off
> # pand  --listen --master --role GN
> 
> On the slave1 side:
> # pand --connect <master bt_addr>
> # ifconfig bnep0 10.0.0.2
> 
> In most cases I obtain the following error:
> 
> SIOCSIFADDR: No such device
> bnep0: unknown interface: No such device
> 
> even if the command
> #hcitool con
> shows me an active connection.
> 
> When I obtain the connection I continue:
> 
> On the slave1 side:
> # route add default gw 10.0.0.1
> 
> On the master side:
> # brctl addif pan0 bnep0
> # ifconfigt bnep0 0.0.0.0
> 
> On the slave2 side:
> # pand --connect <master bt_addr>
> # ifconfig bnep0 10.0.0.3
> 
> and I always obtain the same error:
> 
> SIOCSIFADDR: No such device
> bnep0: unknown interface: No such device
> 
> even if the command
> #hcitool con
> shows me an active connection.
> 
> You pointed me out there is no link policy set  but  my file /etc/Bluetooth/hcid.conf is:
> 
> # Default settings for HCI devices
> device {
> 	# Local device name
> 	#   %d - device id
> 	#   %h - host name
> 	name "BlueZ (%d)";
> 
> 	# Local device class
> 	class 0x3e0100;
> 
> 	# Default packet type
> 	#pkt_type DH1,DM1,HV1;
> 
> 	# Inquiry and Page scan
> 	iscan enable; pscan enable;
> 
> 	# Default link mode
> 	#   none   - no specific policy 
> 	#   accept - always accept incoming connections
> 	#   master - become master on incoming connections,
> 	#            deny role switch on outgoing connections
> 	#
> 	lm accept,master;
> 	#
> 	#lm accept;

you changed this. Why? There can't be two device with a master role in
the same a piconet.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
