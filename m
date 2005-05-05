Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] listening for any packets
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200505051938.25308.viktor.teofanovic@bregenznet.at>
References: <200505051938.25308.viktor.teofanovic@bregenznet.at>
Content-Type: text/plain
Message-Id: <1115316792.8496.182.camel@pegasus>
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
Date: Thu, 05 May 2005 20:13:12 +0200

Hi Teos,

> is it possible to expand the BlueZ stack, that it is able to listen for any 
> incoming packtes (even BB_PDU's or LMP_PDU's) from the piconet? 

no it is not possible. No baseband or LMP traffic is routed through the
HCI for access by the host stack.

> I'm going to programm a simple sniffer tool for educational purposes (just 
> listen for packets without any encryption) and thus I should know, if I can 
> do this with the BlueZ stack?

First you need Bluetooth hardware that allows you to see the baseband or
LMP traffic. For example the BPA-100/105 or the CATC/LeCroy or Frontline
sniffers.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
