Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-devel] Problem with read on RFCOMM Sockets
Message-ID: <A1F0D47583A2D711919F00600819B3A45BDC12@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
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
Date: Wed, 16 Jun 2004 09:17:58 -0400


I understand why strlen should not be used in this case, but why
unsigned char instead of char ? There are many examples of the=20
use of the generic file I/O read() function in the literature=20
using char buffers. Is this case different ?

thanks, Best regards,

Rich

Hi,

> Here is the source code. For testing the receiving of
> data I tried commenting the select loop, and do just
> receiveData, and I get the same results: read returns
> the correct number of bytes, but in the buffer is
> copied just one byte of data. Please tell me if I'm
> doing smth wrong. Thanks a lot.

your buffer should be "unsigned char" and you shouldn't use strlen() to
check to length of your buffer. Rely on the return value of read().

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
