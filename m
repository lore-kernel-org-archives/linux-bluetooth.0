Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Sony DSC-FX77 and BIP
From: Marcel Holtmann <marcel@holtmann.org>
To: Tom Bailly-Salins <tbaillys@free.fr>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40D043DF.4070306@free.fr>
References: <40D043DF.4070306@free.fr>
Content-Type: text/plain
Message-Id: <1087391351.4309.16.camel@pegasus>
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
Date: Wed, 16 Jun 2004 15:09:12 +0200

Hi Tom,

> I would like to ask two questions:
> 
>  - Does the BlueZ bluetooth library implement BIP (Basic Imaging Profile) ?
> 
>  - Does anyone know of a frontend software on Linux that would allow me 
> to operate a Sony DSC-FX77 bluetooth camera using BIP.

try the OBEX Push Daemon (http://oss.bdit.de/opd.html). The FX77 has no
full BIP support. You can push or receive images and use the remote
camera feature, but you can't retrieve any thumbnail or image from it
using the PC and tools like gPhoto etc.

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
