Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Using windows breaks bluetooth in linux? huh
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411190218.22275.wim.delvaux@adaptiveplanet.com>
References: <419AE72F.3030307@patbert.com>
	 <1100762008.7164.15.camel@pegasus> <419D45AE.5060306@patbert.com>
	 <200411190218.22275.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1100828535.7164.104.camel@pegasus>
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
Date: Fri, 19 Nov 2004 02:42:15 +0100

Hi Wim,

> What is that problem with the link_key file.  I have to remove that file from 
> time to time too.  I use a usb dongle and have to connect my device sometimes 
> to this system sometimes to another. 
> 
> Could you explain why a link_key file could get 'out of sync' ?

the link key is invalid when you pair the two devices on a different
operating system. It is that simple, because a new link key deprecates
the old one.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
