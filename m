Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Re: Bluetooth enabled products codes
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <cnd36h$dmi$1@sea.gmane.org>
References: <cncjb4$rrr$1@sea.gmane.org> <1100600361.7208.108.camel@pegasus>
	 <cncqln$iuc$1@sea.gmane.org> <1100610864.7235.1.camel@notepaq>
	 <cnd36h$dmi$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1100616695.7235.11.camel@notepaq>
Mime-Version: 1.0
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
Date: Tue, 16 Nov 2004 15:51:35 +0100

Hi,

> so, what I didn't understant was that those four hexadecimal numbers in the
> table represent the whole feature mask of the specific device. I was looking
> to the 1.2 BT specification and new extended (AFH) features make necessary
> more bytes to mask the features

for Bluetooth 1.1 only the first three bytes are used. Starting with 1.2
the full 8 byte range is used and it can also be extended.

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
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
