Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm - "Connection refused"
From: Marcel Holtmann <marcel@holtmann.org>
To: David Feldman <wb0gaz@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040620170410.96A6F530.wb0gaz@hotmail.com>
References: <20040620170410.96A6F530.wb0gaz@hotmail.com>
Content-Type: text/plain
Message-Id: <1087789335.4781.175.camel@pegasus>
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
Date: Mon, 21 Jun 2004 05:42:15 +0200

Hi David,

> This continues my work to get a bluetooth connection going from
> my RH9 laptop to a Sony Ericsson T68 (not i) cell phone.

what kernel are you using? The credit based flow control is wrong here.
The T68 don't supports the RFCOMM flow control of Bluetooth 1.1, but our
code still tries to set the PF-bit. Install yourself the latest kernel
and everything should be fine.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
