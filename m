Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Issues with multiple (concurrent) rfcomm
	connections
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20050109T210055-110@post.gmane.org>
References: <loom.20050109T210055-110@post.gmane.org>
Content-Type: text/plain
Message-Id: <1105305890.8637.5.camel@pegasus>
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
Date: Sun, 09 Jan 2005 22:24:50 +0100

Hi George,

> I just ran across an issue with setting up multiple rfcomm connections from a 
> linux laptop with kernel 2.4.28-mh1 using an Anycom USB-120 dongle with Silicon 
> Wave chipset.
> 
> I just tried to maintain 2 connections to 2 seperate commercial rs232 adapters 
> (roalan wcs 232) using the socket API (test source attached). While connection 
> setup is ok, and reconnects (e.g. after powerfail of peers) work too for a 
> single device, running the same procedure in parallel leads to a behavor where 
> no more sockets can be opened. It starts with a write failed to the socket (ok 
> so far), but the following connection attempts lead to errors 16 (resource or 
> device busy) and 11 (resource temp. unavailable) or 110 (timeout). From this 
> state, the system does not recover and all bluez modules have to be reloaded ;-(
> 
> as an alternative I tried the same thing using seperate processes instead of 
> threads or, using the rfcomm utility and cat for sending data. I always end up 
> with the same errors.
> 
> I wonder whether this problem is known, or related to Silicon Wave. Could 
> anyone try this with a CSR based system?

try to reproduce it with a 2.6.10-mh1 kernel.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
