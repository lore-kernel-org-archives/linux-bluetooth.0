Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "blookk -" <blookk@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY1-F35NpqhNPPzQT400022b78@hotmail.com>
Subject: [Bluez-devel] RFCOMM connection
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Nov 2004 16:50:25 +0000


Hello!

I am doing some pobes with RFCOMM.

Betwen two PC, the connection RFCOMM gives me a problem:
" Can't connect RFCOMM socket: Connection refused  ".

In server side i write:
rfcomm listen /dev/rfcomm0

In client side I write:
rfcomm connect /dev/rfcomm0 00:11:22:33:44:55  1

In both sides I load the modules rfcomm and l2cap and launch the demons sdpd 
and hcid.

I do not know why occurs this.  I think the pc do not accept connections, 
because i try the connection with a other module  is not a pc and all works 
correctly.

Regards

Carlos.

_________________________________________________________________
La información más fresca desde diferentes puntos de vista en la Revista de 
Prensa de MSN. http://es.newsbot.msn.com/



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
