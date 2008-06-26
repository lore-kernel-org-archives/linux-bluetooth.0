Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Thu, 26 Jun 2008 20:56:45 +0000 (UTC)
Message-ID: <loom.20080626T205559-101@post.gmane.org>
References: <52cf60ee0806261127r15b88ccod1bdba8d42ed4e59@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Meaning of hcitool -i dev con
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Jui-Hao Chiang <windtracekimo <at> gmail.com> writes:

> 
> Hi, dear all:
> I am currently using Cyber-Blue Bluetooth USB adapter and Motorola
> Razr V3 for experiments.
> My goal is to use one adapter to open 3 SCO connections with 3 V3 cell phones.
> The chan_mobile in Asterisk gives me the way to connect the adapter to
> one phone. But when I use hcitool -i hci1 con to show the connections,
> I don't know how to explain the output (00:19:2C:D5:90:DF is cell
> phone's address):
> 
> Connections:
> 	> SCO 00:19:2C:D5:90:DF handle 2 state 1 lm SLAVE
> 	< ACL 00:19:2C:D5:90:DF handle 1 state 1 lm MASTER ENCRYPT
> 
> Does this mean that the USB adapter is playing TWO roles (master and
> slave) at the same moment??
> 
> Hope some one can give some hint.
> Best regards
> 
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> 


I just tried to use the following to query the link mode of the adapter
[command]
hcitool -i hci1 cmd 0x02 0x0009 0x02 0x00
[output]
< HCI Command: ogf 0x02, ocf 0x0009, plen 2
  02 00 
> HCI Event: 0x0e plen 7
  01 09 08 00 02 00 00 
(If I did not make anything wrong)
0x02 is the OGF for Link Policy Command
0x0009 is the OCF for HCI_Role_Discovery
0x02 0x00 is the unit16 of connection handle

At the same time, I use "hcidump -i hci1 -w log" to listen, and then use
wireshark to view the log.
The last byte of HCI Event shows the current role is Master for this connection
handle.
So it seems confusing that "hcitool -i hci1 con" shows "Slave".




-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
