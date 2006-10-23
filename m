Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200610231359.04570.denis.kenzior@trolltech.com>
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<1161573193.8388.12.camel@localhost>
	<200610231359.04570.denis.kenzior@trolltech.com>
Date: Mon, 23 Oct 2006 06:11:04 +0200
Message-Id: <1161576664.8388.21.camel@localhost>
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

> > > Here's the proposed DTD for SDP over XML.  It closely follows the SDP
> > > profile doc.  I wasn't sure whether sequences can be empty (which makes
> > > no sense to me), so I required at least one element in a sequence.    The
> > > sizes for Text, URLs and Sequences was dropped.  It can easily be
> > > inferred from parsing the document.
> >
> > since it is XML, keep everything lower-case and no extra "sdp" prefix.
> > It should be enough to call the root element "record". And I think it is
> > better and easier to use something like:
> >
> > 	<data type="uuid16" value="0x1002"/>
> >
> 
> I can see your point on being lower case, so this is something I agree with.
> 
> I don't really like using the single data tag for everything.  I think I 
> prefer the e.g. <uuid16>0x1002</uuid16> syntax.  However, since this is XML 
> there's no right or wrong way to do this.  Perhaps others can chime in?

my main reason is that the D-Bus Introspection goes this way. And I
personally find this way simpler and more intuitive.

> > And to be fully in sync with the specification we need to differentiate
> > between text8, text16 and text32 (and of course for url, too). For
> > convenience we can then have all data types without the size value and
> > then the server will determine the most appropriate one by itself.
> >
> 
> Why though?  This is something that can be easily computed while parsing the 
> XML structure and creating the internal data representation.  The user should 
> not have to deal with this implementation detail.  I suppose I'm open to 
> adding text8, text16 and text32 tags in "expert" mode.  But how will we 
> handle sequences and alternatives in this case?  

If you specify the DTD the size is not important. Say for example it is
a UUID and the server can detect if it is a UUID-128, UUID-32 or UUID-16
and so the actual application programmer can use the convenient way to
specify the record with thinking about the actual sizes. The server will
do the right thing.

However this only works for "uuid", "text" and "url", because all others
might be used with special meaning from profile to profile.

Having the sized version around and retrieving a record from a remote
server gives you the chance to see the actual record how it is stored on
the remote side. For example some implementation use UUID-32 for no real
reason. Even if a UUID-16 would have been enough. I wanna see these
differences.

> For me I'd rather let the underlying system pick whatever is optimal.  If I 
> want to deal with such low level details, I'll program in the low-level API.  
> Isn't the goal to be as user-friendly as possible?

The problem with SDP is that you can't make it really simple. So far we
tried four times and nothing simple came around. This protocol and data
representation is simply messed up.

> > > I'd like to get some feedback as to how to manage things like Record
> > > Handle, and RFCOMM/L2Cap channels, etc.  For record handle I think it is
> > > easy, just remove that particular attribute and let the SDP server figure
> > > it out.  For RFCOMM channel, etc it is more tricky.  Should we use a
> > > magic value or just override it behind the scenes?  We can always rely on
> > > the user to pick a correct channel as well (and fail registration if they
> > > pick a channel that is already in use)
> >
> > Actually at the moment you have to let the server pick the record
> > handle, because specifying the handle doesn't work. It should work, but
> > I never found the actual bug in the code that prevents it.
> >
> > Using the proposed way of the "data" element, we can have special values
> > for "value" like "%channel" etc. that can be filled in by the server.
> 
> I think this can be accomplished easily by using a hint attribute or a special 
> value, e.g.
> 
> <uint16 type="auto_rfcomm_channel">0x0000</uint16>
> 
> or
> 
> <uint16>AUTO_RFCOMM_CHANNEL</uint16>

I prefer the "%channel" way. Most people with programming skills will
understand what it means.

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
