Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch(Error Messages)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05092805194782ba65@mail.gmail.com>
References: <e1effdeb05092607273355fded@mail.gmail.com>
	 <1127896709.5321.7.camel@localhost.localdomain>
	 <e1effdeb05092805194782ba65@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1128011263.30743.11.camel@localhost.localdomain>
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
Date: Thu, 29 Sep 2005 18:27:43 +0200

Hi Claudio,

> it's possible use uint32 without problems.
> 
> - 0x00000000 - 0x000000FF Bluetooth error codes (current situation)
> - 0x00000100 - 0x0000FFFF Reserved for future Bluetooth error codes
> extension
> - 0x00010000 - 0x0001FFFF D-Bus errors
> - 0x00020000 - 0x0003FFFF System errors (0x00020000 + system error
> value)
> - 0x00040000 - 0xFFFFFFFF Reserved to future error classes
> 
> In order to make easier discover the error type, I defined the error
> values range 
> considering bitwise operations.

this looks good to me. Any complaints or comments from others.

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
