Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm connection setup
From: Marcel Holtmann <marcel@holtmann.org>
To: Patrick Duchstein <patrick-bluez.org@prote.st>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040608230122.3504775c.patrick-bluez.org@prote.st>
References: <20040608230122.3504775c.patrick-bluez.org@prote.st>
Content-Type: text/plain
Message-Id: <1086735971.5040.52.camel@pegasus>
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
Date: Wed, 09 Jun 2004 01:06:11 +0200

Hi Patrick,

> I am currently working on my own embedded solution of a Bluetooth
> protocol stack, and always actively testing its interoperability with
> BlueZ. First thing to say: great work for reference, thanks a lot!
> 
> I am currently stuck on setting up an rfcomm connection. L2CAP works
> totally fine, but when connecting over an rfcomm socket with either
> rctest or rfcomm, bluez does not seem to send out a SABM frame on DLCI 0
> as mentioned in the specification; a timeout appears after some time.
> 
> Since I do not have any other BT devices to check it, I would be very
> pleased if somebody on this list could help me by just sending me the
> full debugging output of the bluez modules (3 kernel definitons) of a
> successfully established rfcomm connection using rctest -s -N 2. Though
> I am by now very familiar with both the Bluetooth 1.1 and TS 07.10
> specs, I probably understood something wrong; thus, a connection trace
> would help me a lot.

since you mention "rctest -s -N 2" I assume that you try to connect from
BlueZ to your stack. Run "hcidump -w <file>" as root on the BlueZ side
and show us the resulting file.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
