Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] updating the PSM in SDP..
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <00a001c4cee6$5271b4c0$0000fea9@zool>
References: <00a001c4cee6$5271b4c0$0000fea9@zool>
Content-Type: text/plain
Message-Id: <1100958396.7213.126.camel@pegasus>
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
Date: Sat, 20 Nov 2004 14:46:36 +0100

Hi Steffen,

> I have used your examples in dund.c to make a proper SDP client that
> can advertise my protocol (L2CAP) and PSM correctly to the sdpd
> daemon. All the attributes looks correctly and functions ok. 
> My question is now: How do I update my SDP record (more specifically
> the PSM attribute)?
> I can't find any example or anything. Explaination or example files
> are appriciated! :-)

I never did this. If you change the PSM maybe it is a good idea to
delete the old one and add a new record.

The library contains a sdp_record_update() function, but I never tried
it so far.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
