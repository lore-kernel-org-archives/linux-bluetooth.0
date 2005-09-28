Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch(Error Messages)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05092607273355fded@mail.gmail.com>
References: <e1effdeb05092607273355fded@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1127896709.5321.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 28 Sep 2005 10:38:29 +0200

Hi Claudio,

> 2. Use error ranges
>    Define only one error message name(org.bluez.EFailed), signature:
> sq
>    - 0x0000 - 0x00FF Bluetooth error codes
>    - 0x0100 - 0x01FF D-Bus errors
>    - 0x0200 - 0x02FF System errors (0x0200 + system error value)
>    - 0x0300 - 0xFFFF reserved to future error classes

I like to go with this approach and a name like org.bluez.Error, because
this makes it easy to map the Bluetooth errors. Question is if we should
use uint16 or uint32. Maybe the Bluetooth specification extend their
error codes to an uint16 instead of an uint8 and then I like to have a
free space in this range. Do you think this is a problem?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
