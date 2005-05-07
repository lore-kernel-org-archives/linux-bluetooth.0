Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pand seem to ignore any pin configurations
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200505072203.45598.rdorsch@web.de>
References: <200505072203.45598.rdorsch@web.de>
Content-Type: text/plain
Message-Id: <1115498144.9031.19.camel@pegasus>
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
Date: Sat, 07 May 2005 22:35:44 +0200

Hi Rainer,

> I have setup a PAN network with a NAP (bluez-utils 2.15/kernel 2.6.7) and a 
> PANU (bluez-utils/kernel-2.6.8). Each has an usb bt dongle and runs Debian 
> sarge. Surprisingly, they seem to ignore any pin configuration. If there is 
> good documentation on this somewhere, I would be happy with a pointer.
> 
> 
> My assumption is that the PANU provides a PIN and NAP needs to confirm it.
> 
> My first problem is that I do not understand, where to provide a PIN on the 
> PANU.

start pand with --encrypt on the NAP side. While looking at it, I
realized that the --auth option is missing. However --encrypt should
imply --auth by definition of the Bluetooth specification.

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
