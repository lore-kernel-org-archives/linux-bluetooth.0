Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] fujitsu-siemens pc card
From: Marcel Holtmann <marcel@holtmann.org>
To: Lengyel Gabor <lgaga@freemail.hu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3F7BF2EC.2080000@freemail.hu>
References: <3F7BF2EC.2080000@freemail.hu>
Content-Type: text/plain
Message-Id: <1065090512.1733.75.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 02 Oct 2003 12:28:26 +0200

Hi Gabor,

> I recently obtained a Fujitsu-Siemens Bluetooth PC Card and tried a lot 
> but could not make it work. I tried with debian sid, kernel 2.4.22 (from 
> kernel.org, not the debian one), on an Asus L3400Tp notebook.

it seems that this is a serial cardbus card with a Bluetooth chip on it.
So please use the yenta_socket PCMCIA bridge driver and you must find
out which Bluetooth chip they are using.

Do you got this card working with Windows? If yes, please try to get
access to another machine with Bluetooth running Linux and run

	hcitool info <bdaddr>

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
