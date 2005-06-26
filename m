Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001301c57a9b$69a0c2b0$fefda8c0@planetmunich.buci.de>
From: "Raimund Steger" <rs@mytum.de>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-devel] null bytes in 'SDP_TEXT_STR8' data element
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
Date: Mon, 27 Jun 2005 00:07:15 +0200

Hi,

I have problems adding a "TEXT" attribute value to a service
record that contains '0x00' bytes. First, it seems like the sdp_data_alloc()
function does use strlen() for text entries which will use these
bytes as string terminators.

Second, I use the JSR-82 library from Avetana, where the service record
gets registered via send_req_w4_rsp which seems to be null-byte safe.
However, when someone queries the record, the string element is again
truncated which seems to happen in the sdp_gen_pdu() function in
sdp/sdp.c [of bluez-libs-2.17], l. 686, where strlen() is used to
determine the string element's length. Would it be possible to use
d->unitSize in this place instead?

Thanks,

Raimund



-- 
R.Steger  ICQ# 16845346  Tel  +49-179-2981632



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
