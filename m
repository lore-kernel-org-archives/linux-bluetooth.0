Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Possible bug in sdp.c
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43F1CA4F.8030102@yahoo.com>
References: <43F1B8DE.3060206@yahoo.com>  <43F1CA4F.8030102@yahoo.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1139990590.26072.8.camel@localhost>
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
Date: Wed, 15 Feb 2006 09:03:10 +0100

Hi Pedro,

> > I have seen what *may* be a possible bug in sdp.c. If there is an err=
or=20
> > in a SDP PDU sent by a bluetooth device, it seems that the SDP parsin=
g=20
> > code in sdp.c enters an infinite loop filling syslog with the followi=
ng=20
> > message: "Unknown sequence type, aborting".
> >=20
> > I have been tracking down the cause and I have found where the proble=
m=20
> > might be. The function sdp_extract_seqtype() may return 0 in case of=20
> > unrecognized data, but this case does not seem to be handled in the=20
> > calls to this function (for example, in sdp_service_search_attr_req()=
 or=20
> > in sdp_extract_pdu()).
> >=20
> > Could anybody tell me whether am I right or wrong? Has anybody seen a=
=20
> > similar behaviour?
> >=20
>=20
> I have been doing some further research and it is a Samsung. In previou=
s=20
> posts, there have been some bug reports regarding this brands, such as=20
> raising SIGSEGV while looking up for DUN service. Lo=C3=AFc Lefort sent=
 a=20
> patch that works pretty well with many phones, but there seems to be a=20
> new Samsung phone that sends other unexpected SDP data, but I still do=20
> not know which model.

I actually thought we fixed that problem, but SDP is a horrible protocol
anyway, so expect more bugs. I don't have a Samsung phone and so I can't
easily reproduce it. However you need to send in a binary hcidump log
for the crash.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
