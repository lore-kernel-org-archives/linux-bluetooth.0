Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4197C4FB.60905@gmx.ch>
From: Marco Trudel <soapy@gmx.ch>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] combination keys support?
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
Date: Sun, 14 Nov 2004 21:50:03 +0100

hello again. here the whole story...

I programmed a little bluetooth server and startet it on my computer.
I programmed a little bluetooth client and startet it on my mobile phone.

when i start the client and try to connect to my programmed service, i 
come to the pairing steps. my mobile phone then tells me "pairing and 
connection rejected because of security reasons".

searching on google for that, i found that my nokia mobile phone only 
works with combination keys. if the remote devices works with unit keys, 
the connection is refused because of security reasons.

so my question was:
does bluez work with unit keys or connection keys???
respectively, my second question: is this in the bluez level or in the 
firmware of my bluetooth dongle?

regards
Marco


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
