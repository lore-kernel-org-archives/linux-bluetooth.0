Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Encryption, authentication with Bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: Julien Campana <juliencampana@yahoo.fr>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1083758037.1541.36.camel@fischer>
References: <1083758037.1541.36.camel@fischer>
Content-Type: text/plain
Message-Id: <1083761997.4420.4.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 05 May 2004 14:59:57 +0200

Hi Julien,

> With the hciconfig tool, authentication and encryption can be switch to
> on/off. 
> But if I well understood, this affects the local device and therefore
> every future connection. 

if you switch auth and encrypt on with hciconfig or in hcid.conf then
you are in security mode 3.

> Is there any way to have two connections, one using authentication and
> not the other?

This is security mode 2 (also called service level security) and of
course this is possible. You can trigger auth or switch encryption with
hcitool.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
