Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Vlad <vkorolev@nist.gov>
Message-ID: <loom.20040827T021529-764@post.gmane.org>
References: <loom.20040820T185934-862@post.gmane.org>  <1093073294.3544.12.camel@notepaq>  <003f01c48755$3dfe6a70$0301a8c0@zazoumobile> <1093083055.3650.7.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: Disconnections are not being detected.
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
Date: Fri, 27 Aug 2004 00:17:08 +0000 (UTC)



Marcel and Xavier,

Thank you for such a prompt response to my post.  Here are some
more details regarding this problem.

As Marcel pointed out:

  actually that is not quite right. The server (phone) sends back a
  connect response with PSM not supported error status. And we then send a
  command reject for that. This is really stupid. What kernel version do
  you use and what kind of hardware is this? Can you reproduce it with the
  latest 2.4 or 2.6 kernel?

You right ... I didn't pay close attention to the direction where the
command reject packet is being sent. The above log came from the laptop
that was running kernel version 2.4.24, but I believe that such behavior
can be repeated on the more recent versions. [see below]


and as Xavier wrote:
 
  I guess the command reject is due to scid and dcid being both set to 0 by
  the remote device. So bluez doesn't know who it's to talking to (as we can
  have several cid on one ACL link) ...

Marcel wrote:

  you are right. It should fill in dcid and scid. The remote device is
  broken. Blame SE about that. I still don't know where the command reject
  came from :(

You are both right, about why is this happening. Here is a link to the
linux kernel source.

    http://lxr.linux.no/source/net/bluetooth/l2cap.c?v=2.4.26#L1450 

But the official L2CAP specification.  (Version 1.1) says (page 288):

	Result: 2 octets The result field indicates the outcome of
	the connection request. The result value of 0x0000 indicates
	success while a non-zero value indicates the connection request
	failed or is pending. A logical channel is established on the
	receipt of a successful result. Table 5.5 defines values for
	this field. If the result field is not zero. The DCID and SCID
	fields should be ignored when the result field indicates the
	connection was refused.

So although the BlueZ behavior is correct from common sense perspective,
but it is not correct from the specification perspective. I am not sure
what does version 1.2 of the spec say about this subject.


So since my project requires this to be implemented corrected. I will 
come up with some kind of patch for this and post in on this mailing
list. (Within next couple of weeks). Meanwhile I would appreciate any
suggestions on how this could be implemented with the least pain for
everybody.


						Vlad











-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
