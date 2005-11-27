Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] multiple rfcomm listeners
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <438A21B2.40609@xmission.com>
References: 
	 <Pine.LNX.4.33.0511271455120.20980-100000@redbean.intranet.gw-instruments.de>
	 <1133116410.13629.6.camel@blade>  <438A21B2.40609@xmission.com>
Content-Type: text/plain
Message-Id: <1133128026.13629.18.camel@blade>
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
Date: Sun, 27 Nov 2005 22:47:06 +0100

Hi Brad,

> >>>I've heard that bluetooth clients are supposed to check for the SP
> >>>channel via sdp
> > this is a problem with the Bluetooth specification and its qualication.
> 
> this got me thinking that SP is the wrong service for gps. They should
> have chosen a protocol that allows for multiple simultaneous plain l2cap
> connections.
> 
> but... would it be possible for me to write an app that listens on an
> l2cap socket on the right psm and implements a pseudo-rfcomm protocol
> that allows for multiple simultaneous connections? if it can be done,
> then sdp would just advertise a single SP service and multiple clients
> could use it. they wouldn't even know about the fakery.

the L2CAP supports multiple connections to the same PSM from the same
device (you need this for AVDTP). For RFCOMM these connections must come
from a different device. Meaning that the underlying L2CAP link must be
different.

Actually the concept of RFCOMM was bad in the first place, because an
L2CAP with flow control would have been solved almost everything.

> it would be sort of gross, but as long as it doesn't require surgery to
> the stack or unloading rfcomm.ko, it wouldn't be that bad, eh?

You can do whatever you like. Use UUID-128 to identify your service and
use PSM numbers starting with 4097 (0x1001).

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
