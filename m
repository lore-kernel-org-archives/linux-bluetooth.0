Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <438A21B2.40609@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] multiple rfcomm listeners
References: <Pine.LNX.4.33.0511271455120.20980-100000@redbean.intranet.gw-instruments.de> <1133116410.13629.6.camel@blade>
In-Reply-To: <1133116410.13629.6.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Sun, 27 Nov 2005 14:14:26 -0700

Marcel

>>>I've heard that bluetooth clients are supposed to check for the SP
>>>channel via sdp
> this is a problem with the Bluetooth specification and its qualication.

this got me thinking that SP is the wrong service for gps. They should
have chosen a protocol that allows for multiple simultaneous plain l2cap
connections.

but... would it be possible for me to write an app that listens on an
l2cap socket on the right psm and implements a pseudo-rfcomm protocol
that allows for multiple simultaneous connections? if it can be done,
then sdp would just advertise a single SP service and multiple clients
could use it. they wouldn't even know about the fakery.

it would be sort of gross, but as long as it doesn't require surgery to
the stack or unloading rfcomm.ko, it wouldn't be that bad, eh?

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
