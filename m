Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200610231025.51818.denis.kenzior@trolltech.com>
References: <200610231025.51818.denis.kenzior@trolltech.com>
Date: Mon, 23 Oct 2006 05:13:13 +0200
Message-Id: <1161573193.8388.12.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Proposed DTD
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Denis,

> Here's the proposed DTD for SDP over XML.  It closely follows the SDP profile 
> doc.  I wasn't sure whether sequences can be empty (which makes no sense to 
> me), so I required at least one element in a sequence.    The sizes for Text, 
> URLs and Sequences was dropped.  It can easily be inferred from parsing the 
> document.  

since it is XML, keep everything lower-case and no extra "sdp" prefix.
It should be enough to call the root element "record". And I think it is
better and easier to use something like:

	<data type="uuid16" value="0x1002"/>

And to be fully in sync with the specification we need to differentiate
between text8, text16 and text32 (and of course for url, too). For
convenience we can then have all data types without the size value and
then the server will determine the most appropriate one by itself.

> I'd like to get some feedback as to how to manage things like Record Handle, 
> and RFCOMM/L2Cap channels, etc.  For record handle I think it is easy, just 
> remove that particular attribute and let the SDP server figure it out.  For 
> RFCOMM channel, etc it is more tricky.  Should we use a magic value or just 
> override it behind the scenes?  We can always rely on the user to pick a 
> correct channel as well (and fail registration if they pick a channel that is 
> already in use)

Actually at the moment you have to let the server pick the record
handle, because specifying the handle doesn't work. It should work, but
I never found the actual bug in the code that prevents it.

Using the proposed way of the "data" element, we can have special values
for "value" like "%channel" etc. that can be filled in by the server.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
