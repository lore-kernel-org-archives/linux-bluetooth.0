Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Disconnections are not being detected.
From: Marcel Holtmann <marcel@holtmann.org>
To: Vlad <vkorolev@nist.gov>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20040827T021529-764@post.gmane.org>
References: <loom.20040820T185934-862@post.gmane.org>
	 <1093073294.3544.12.camel@notepaq>
	 <003f01c48755$3dfe6a70$0301a8c0@zazoumobile>
	 <1093083055.3650.7.camel@notepaq> <loom.20040827T021529-764@post.gmane.org>
Content-Type: text/plain
Message-Id: <1093606399.2581.101.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 27 Aug 2004 13:33:20 +0200

Hi Vlad,

> But the official L2CAP specification.  (Version 1.1) says (page 288):
> 
> 	Result: 2 octets The result field indicates the outcome of
> 	the connection request. The result value of 0x0000 indicates
> 	success while a non-zero value indicates the connection request
> 	failed or is pending. A logical channel is established on the
> 	receipt of a successful result. Table 5.5 defines values for
> 	this field. If the result field is not zero. The DCID and SCID
> 	fields should be ignored when the result field indicates the
> 	connection was refused.
> 
> So although the BlueZ behavior is correct from common sense perspective,
> but it is not correct from the specification perspective. I am not sure
> what does version 1.2 of the spec say about this subject.

it is still the same for the 1.2 specification, but it is simply wrong
and stupid. You need at least the SCID to match the connect response to
a previous connect request. Otherwise this response is meaningless.

What we did wrong is sending the command reject for a response. I will
fix this, but this won't fix your problem. If we don't know for what
L2CAP channel we get a connection refused response, we can't do anything
else then waiting for a timeout event.

Check the bluetooth.org pages if they had an erratum for that and if not
ping them to correct it. Also write to SE about that.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
