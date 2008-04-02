Return-Path: <cyrus@holtmann.org>
Message-ID: <014501c894ca$28e9e160$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Marcel Holtmann" <marcel@holtmann.org>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <200803290830.16736.dstockwell@frequency-one.com> <B234BE21-AF5C-42F9-9D04-CC003C70E78B@holtmann.org>
Subject: Re: [Bluez-devel] Proposed API for org.bluez.audio.control (AVRCP)
Date: Wed, 2 Apr 2008 09:02:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Thank you for your brief critique.

I believe a couple of message exchanges that could be buried into the daemon is the UnitInfo and SubUnitInfo, at least from the TG 
side, because the information for these is constant for any application (perhaps in a .conf file).  There is probably no need for 
the application to receive a signal indicating that something has requested Unit- or SubUnitInfo, and no need to construct and send 
that response.

However, a TG application may need to query and receive Unit and SubUnitInfo; this could be buried into the establishment of the 
link, which as far as I can tell takes place when opening the Device; I am still digging through the code.

I expressed a need (in a Connect method) to select whether the application running in "this" box, connecting to "this" side of the 
DBus is CT, TG, or both.  If only one-sided, it makes no sense to add both CT and TG records to SDP.  This is also constant for the 
application.

As far as other requirements go from my standpoint, I need full access to sending Metadata from TG to a remote CT using the 
VendorDependent message.  I did propose two methods: SendVendorDependent and SendMetadata (specifically for metadata).

I also need full access to Passthrough for receiving messages from a remote CT.  With respect to Passthrough, I believe receiving a 
signal is the better way to go (not just the key pressed, but also the vendor dependent operation_data_field).  I know the current 
implementation converts a subset of the messages received to simple "keystrokes" sent with /dev/uinput.  Maybe Johan could inform us 
of what he intended: his requirements, advantages, limitations, etc.

As far as my approach goes, there are obviously things that will be moved around, deleted, and rethought.  For now I intend to use 
the document I submitted as initial guidance and as a checklist until I have a complete working model: it's usually easier to cut 
out than to add later.

Incidentally, one of the other things that I have to think about when dealing with metadata is internationalization: displayable 
character set, passing non-Western character data, etc.

Thanks again for your comments.

All the best,

David Stockwell

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: <dstockwell@frequency-one.com>; "BlueZ development" <bluez-devel@lists.sourceforge.net>
Sent: Sunday, March 30, 2008 10:19 PM
Subject: Re: [Bluez-devel] Proposed API for org.bluez.audio.control (AVRCP)


Hi David,

> As promised, I have laid out a first draft interface for .control,
> which is
> largely based on AVRCP support provided by CSR.

I think it is a little bit too complex. Lets make this easier and put
the logic and intelligence into the daemon. Please write down what you
really do need by this API and don't try to export everything.

> It appears that the *-api.txt documents are created with groff (or
> something
> like that); this document I just quickly hacked together in KWrite
> (similar
> to MS Notepad).

It is free from :)

Regards

Marcel
