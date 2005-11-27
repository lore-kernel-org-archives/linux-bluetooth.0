Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] multiple rfcomm listeners
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0511271455120.20980-100000@redbean.intranet.gw-instruments.de>
References: 
	 <Pine.LNX.4.33.0511271455120.20980-100000@redbean.intranet.gw-instruments.de>
Content-Type: text/plain
Message-Id: <1133116410.13629.6.camel@blade>
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
Date: Sun, 27 Nov 2005 19:33:30 +0100

Hi Peter,

> > I've heard that bluetooth clients are supposed to check for the SP
> > channel via sdp on every connect, but bluez doesn't do that in its
> > rfcomm bindings, eh? Do other devices check the channel only when pairing?
> This behaviour is completly implementation depended. The Widcom stack and
> even some other implementaions do request the server channel number for a
> service just before connection setup. Other implementations just store the
> server channel during pairing. The SDP variant has the problem that it is
> not realy possible to distinguish between two identical services which
> only have different server channels, e.g. many mobile phones and some
> other devices offer two SPP channels. With the SDP variant it is likely
> that you connect to the wrong service.
> The pairing variant has the drawback that you can not connect to a service
> anymore if its server channel changes dynamicly. This again is
> implementation depoendent on the client side. However, most devices I'm
> aware off use fixed server channels.

this is a problem with the Bluetooth specification and its qualication.
The SDP defines a time-to-live for the service record, but nobody uses
it. However I can remember what's the default behavior if this attribute
doesn't exists.

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
