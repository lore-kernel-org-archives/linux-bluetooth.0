Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] configure: error: Bluetooth library not found
From: Marcel Holtmann <marcel@holtmann.org>
To: sandro.weiser@gmx.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405281710.07594.sandro.weiser@gmx.de>
References: <200405281710.07594.sandro.weiser@gmx.de>
Content-Type: text/plain
Message-Id: <1085757910.3321.35.camel@pegasus>
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
Date: Fri, 28 May 2004 17:25:10 +0200

Hi Sandro,

> I've installed libs and libs2, configure of utils and compiling works, but 
> configure in utils2 alwas ends with this:
> 
> checking bluetooth/bluetooth.h usability... yes
> checking bluetooth/bluetooth.h presence... yes
> checking for bluetooth/bluetooth.h... yes
> checking for bt_inquiry in -lbluetooth... no
> configure: error: Bluetooth library not found

you can't install libs and libs2 with the same prefix. However you don't
really need libs2 and utils2 right now.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
