Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] null bytes in 'SDP_TEXT_STR8' data element
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <001301c57a9b$69a0c2b0$fefda8c0@planetmunich.buci.de>
References: <001301c57a9b$69a0c2b0$fefda8c0@planetmunich.buci.de>
Content-Type: text/plain
Message-Id: <1119851418.15397.4.camel@pegasus>
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
Date: Mon, 27 Jun 2005 07:50:18 +0200

Hi Raimund,

> I have problems adding a "TEXT" attribute value to a service
> record that contains '0x00' bytes. First, it seems like the sdp_data_alloc()
> function does use strlen() for text entries which will use these
> bytes as string terminators.
> 
> Second, I use the JSR-82 library from Avetana, where the service record
> gets registered via send_req_w4_rsp which seems to be null-byte safe.
> However, when someone queries the record, the string element is again
> truncated which seems to happen in the sdp_gen_pdu() function in
> sdp/sdp.c [of bluez-libs-2.17], l. 686, where strlen() is used to
> determine the string element's length. Would it be possible to use
> d->unitSize in this place instead?

it is fine to use unitSize. Send in a patch for both problems.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
