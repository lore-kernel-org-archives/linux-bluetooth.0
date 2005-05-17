Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] 3COM PCMCIA Bluetooth question
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <B7A120329D087840A54E2A221FCCE8D074732C@PSCMAIL01.rochester.itsphoenix.com>
References: 
	 <B7A120329D087840A54E2A221FCCE8D074732C@PSCMAIL01.rochester.itsphoenix.com>
Content-Type: text/plain
Message-Id: <1116339069.10063.97.camel@pegasus>
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
Date: Tue, 17 May 2005 16:11:09 +0200

Hi John,

> 
> Yes, I see two new tty devices:
>  
> ttyS03  at  port  0xF6000000  (irq = 153)  is  a  16C950/954
> ttyS04  at  port  0xF6000008  (irq = 153)  is  a  8250

then use "hciattach ttyS3 3com".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
