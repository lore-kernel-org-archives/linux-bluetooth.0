Return-Path: <cyrus@holtmann.org>
Date: Sun, 14 Mar 2010 20:16:59 +0000 (GMT)
To: Daniel Abraham <daniel.shrugged@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bug in parsing of SDP_ServiceSearchAttributeResponse?
In-Reply-To: <1268574616.6238.903.camel@dabraham-mobl>
References: <1268344653.9884.42.camel@dabraham-mobl>  <1268352254.586562.6662.nullmailer@galant.ukfsn.org> <1268574616.6238.903.camel@dabraham-mobl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1268597819.922651.10305.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 14 Mar 2010, Daniel Abraham wrote:

> > You can probably use "sdptool search" to find specific services ok?
>
> Actually "sdptool" is just an example, the real problem is that when
> BlueZ discovers that device, the SDP PDU truncation causes it to appear
> to be profile-less, so I can't actively connect to any service, only
> passively accept connections.

Well, I'm not sure how BlueZ works in this regard but my question covers
searching for a specific service in general - eg if you perform a
ServiceSearchAttribute with a specific UUID and possibly a limited
AttributeIDList then the response will be a whole lot smaller and probably
fit into the L2CAP packet..

> > Although sdptool has no way to increase the "Incoming MTU" on the SDP
> > connection, if you could work out how to do that it might allow more
> > information to be received (in lib/sdp.c:sdp_connect_l2cap() set
> > L2CAP_OPTIONS with imtu at some large number than 672, before the
> > connect())
>
> Although the PDU truncation is a bug not in BlueZ, I still think it
> uncovers a point for improvement in BlueZ.
>
> Up until the truncation point, the PDU still contains 6-7 valid
> attribute lists, which are discarded. Why not use them despite the
> malformed PDU?

The code that parses the response from the remote side is told that there
are XXX bytes in the following data, but only yyy are in the packet.. what
to do? Its obviously an error and you can't necessarily guess what the
other side intended to send..

On the other hand, if BlueZ were to set the MaximiumAttributeByteCount to
a lower value (eg see patch below), that might help your remote device to
do the right thing.. if that works, the count could be calculated at
runtime as

   MTU - 5(pdu hdr) - 2(attr count) - 17(max cont state)

rather than using a fixed value.

iain

--- lib/sdp.c.orig	2010-03-14 19:56:19.000000000 +0000
+++ lib/sdp.c	2010-03-14 19:56:53.000000000 +0000
@@ -95,7 +95,7 @@
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB }
 };

-#define SDP_MAX_ATTR_LEN 65535
+#define SDP_MAX_ATTR_LEN 600

 static sdp_data_t *sdp_copy_seq(sdp_data_t *data);
 static int sdp_attr_add_new_with_length(sdp_record_t *rec,


