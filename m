Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Zaurus and PAN profile
From: Marcel Holtmann <marcel@holtmann.org>
To: "Mateo, Jose-Luis" <Jose-Luis.Mateo@t-systems.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <D971A27FCD3DE04689089E8A98D8AF710361C30C@G9JJ1.mgb01.telekom.de>
References: 
	 <D971A27FCD3DE04689089E8A98D8AF710361C30C@G9JJ1.mgb01.telekom.de>
Content-Type: text/plain
Message-Id: <1088007009.4209.114.camel@pegasus>
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
Date: Wed, 23 Jun 2004 18:10:09 +0200

Hi Jose,

> I'm trying to connect a Zaurus PDA with a Laptop using the PAN Profile. I can ping with l2ping and connect using hcitool, but not using pand. The message error is: Connection refused (111).

sounds like a PIN problem. Look with "hcidump -x" at it. What does
"hciconfig -a" say?

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
