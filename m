Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Kernel 2.6.6 + mh1 patch set -- linker error
From: Marcel Holtmann <marcel@holtmann.org>
To: fd@cisco.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1085206521.10621.17.camel@metal.cisco.com>
References: <1085206521.10621.17.camel@metal.cisco.com>
Content-Type: text/plain
Message-Id: <1085223910.22191.59.camel@pegasus>
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
Date: Sat, 22 May 2004 13:05:11 +0200

Hi Frederic,

> I have applied the -mh1 patch set on a 2.6.6 tree and get linker errors
> related to duplicate HID function definitions. I included the error
> messages as well as my .config.
> 
> There is apparently a conflict between hid-core and hidp. Is my config
> nonsensical ?

we already discussed this here and the problem is that you can't use
both hidp and usbhid built-in right now. I fixed it in my tree and with
-mh2 it should be possible again, but this patch isn't out yet. Use
modules to prevent this error.

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
