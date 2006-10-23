Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 23 Oct 2006 14:31:28 +1000
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610231359.04570.denis.kenzior@trolltech.com>
	<1161576664.8388.21.camel@localhost>
In-Reply-To: <1161576664.8388.21.camel@localhost>
MIME-Version: 1.0
Message-Id: <200610231431.28318.denis.kenzior@trolltech.com>
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

Marcel,

> >
> > I can see your point on being lower case, so this is something I agree
> > with.
> >
> > I don't really like using the single data tag for everything.  I think I
> > prefer the e.g. <uuid16>0x1002</uuid16> syntax.  However, since this is
> > XML there's no right or wrong way to do this.  Perhaps others can chime
> > in?
>
> my main reason is that the D-Bus Introspection goes this way. And I
> personally find this way simpler and more intuitive.

Ok in this case, agreed.  I will make the necessary changes.

> > Why though?  This is something that can be easily computed while parsing
> > the XML structure and creating the internal data representation.  The
> > user should not have to deal with this implementation detail.  I suppose
> > I'm open to adding text8, text16 and text32 tags in "expert" mode.  But
> > how will we handle sequences and alternatives in this case?
>
> If you specify the DTD the size is not important. Say for example it is
> a UUID and the server can detect if it is a UUID-128, UUID-32 or UUID-16
> and so the actual application programmer can use the convenient way to
> specify the record with thinking about the actual sizes. The server will
> do the right thing.
>

Yep, I prefer this.  See next.  

> However this only works for "uuid", "text" and "url", because all others
> might be used with special meaning from profile to profile.

Yep, hence I made the int8..128 and uint8..128.  I think this is unavoidable.  
This is also the reason why I explicitly specify uuid16..128.  Do you think 
the uuid one is unnecessary?

>
> Having the sized version around and retrieving a record from a remote
> server gives you the chance to see the actual record how it is stored on
> the remote side. For example some implementation use UUID-32 for no real
> reason. Even if a UUID-16 would have been enough. I wanna see these
> differences.

I understand, but this is more of a developer thing.  Can sdptool be made to 
fill this gap?  It already has this functionality.  I think the XML format 
should be kept as simple as possible, unless extra complexity is unavoidable.

Perhaps two dtds are in order.  One that is "explicit" (you specify sizes for 
all elements, including Sequences and Alternates, Text, URL and UUID) and one 
that is not?

> The problem with SDP is that you can't make it really simple. So far we
> tried four times and nothing simple came around. This protocol and data
> representation is simply messed up.

I completely agree with the last sentence :)

> > > Actually at the moment you have to let the server pick the record
> > > handle, because specifying the handle doesn't work. It should work, but
> > > I never found the actual bug in the code that prevents it.
> > >
> > > Using the proposed way of the "data" element, we can have special
> > > values for "value" like "%channel" etc. that can be filled in by the
> > > server.
> >
> > I think this can be accomplished easily by using a hint attribute or a
> > special value, e.g.
> >
> > <uint16 type="auto_rfcomm_channel">0x0000</uint16>
> >
> > or
> >
> > <uint16>AUTO_RFCOMM_CHANNEL</uint16>
>
> I prefer the "%channel" way. Most people with programming skills will
> understand what it means.
>

Something that occurred to me is that I think in the real implementation it 
would be a lot easier to specify the l2cap and rfcomm channels separately and 
just override the parsed SDP record.  Don't know if this is good though.  
E.g. 
	RegisterXMLRecordRFCOMM(byte[] xml, int rfcomm_channel)
	RegisterXMLRecordL2CAP...

> Regards
>
> Marcel
>

Thanks,
-Denis

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
