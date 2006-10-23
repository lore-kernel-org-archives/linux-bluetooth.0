Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200610231431.28318.denis.kenzior@trolltech.com>
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610231359.04570.denis.kenzior@trolltech.com>
	<1161576664.8388.21.camel@localhost>
	<200610231431.28318.denis.kenzior@trolltech.com>
Date: Mon, 23 Oct 2006 09:27:07 +0200
Message-Id: <1161588427.7694.11.camel@aeonflux.holtmann.net>
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

> > > I can see your point on being lower case, so this is something I agree
> > > with.
> > >
> > > I don't really like using the single data tag for everything.  I think I
> > > prefer the e.g. <uuid16>0x1002</uuid16> syntax.  However, since this is
> > > XML there's no right or wrong way to do this.  Perhaps others can chime
> > > in?
> >
> > my main reason is that the D-Bus Introspection goes this way. And I
> > personally find this way simpler and more intuitive.
> 
> Ok in this case, agreed.  I will make the necessary changes.

Great.

> > However this only works for "uuid", "text" and "url", because all others
> > might be used with special meaning from profile to profile.
> 
> Yep, hence I made the int8..128 and uint8..128.  I think this is unavoidable.  
> This is also the reason why I explicitly specify uuid16..128.  Do you think 
> the uuid one is unnecessary?

It actually is, because the UUID-128 has a well defined representation
and it is simple to distinguish between UUID-16 and UUID-32. However if
someone wants to force another UUID, then we might should have them in
case.

> > Having the sized version around and retrieving a record from a remote
> > server gives you the chance to see the actual record how it is stored on
> > the remote side. For example some implementation use UUID-32 for no real
> > reason. Even if a UUID-16 would have been enough. I wanna see these
> > differences.
> 
> I understand, but this is more of a developer thing.  Can sdptool be made to 
> fill this gap?  It already has this functionality.  I think the XML format 
> should be kept as simple as possible, unless extra complexity is unavoidable.

I am not sure. For example if you wanna auto detect some special
devices, you might wanna have this extra bit of information. This can
become handy with all the special devices using the serial port profile
and are something special like a blood pressure device etc.

> Perhaps two dtds are in order.  One that is "explicit" (you specify sizes for 
> all elements, including Sequences and Alternates, Text, URL and UUID) and one 
> that is not?

No. Two DTDs will make it too complex. We can have both ways within one
DTD and the registering application can use the simple one, while the
server will always hand out the detailed one. Leave the rest to the XML
parser.

> Something that occurred to me is that I think in the real implementation it 
> would be a lot easier to specify the l2cap and rfcomm channels separately and 
> just override the parsed SDP record.  Don't know if this is good though.  
> E.g. 
> 	RegisterXMLRecordRFCOMM(byte[] xml, int rfcomm_channel)
> 	RegisterXMLRecordL2CAP...

I am against putting too much information into the methods itself. This
never gave us any advantage in the past. The Bluetooth SIG is inventing
new records all the time and in case of HCRP and HID you have two L2CAP
PSMs which makes this more complicated.

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
