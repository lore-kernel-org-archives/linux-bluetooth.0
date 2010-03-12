Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Mar 2010 00:04:14 +0000 (GMT)
To: Daniel Abraham <daniel.shrugged@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bug in parsing of SDP_ServiceSearchAttributeResponse?
In-Reply-To: <1268344653.9884.42.camel@dabraham-mobl>
References: <1268344653.9884.42.camel@dabraham-mobl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1268352254.586562.6662.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 11 Mar 2010, Daniel Abraham wrote:

> Hi, this is my first time here, so I'm not sure about etiquette, or
> if/where there's a BlueZ bug repository...
>
> I'm using BlueZ 4.62, and I ran the command line "sdptool browse <BD
> address>" against a remote computer. I got this error output: "Service
> search failed: Success".

what computer is that?

> According to hcidump (attached), the SDP_ServiceSearchAttributeResponse
> is malformed, but a different Bluetooth stack (IVT on Windows) is able
> to report correctly the remote computer's available services.

It could be that the different Bluetooth stacks fetch that information via
a different request than ServiceSearchAttributes, or that it queries the
services that it hopes to see individually rather than just the
PublicBrowseGroup to get everything as in this case.

> So I'm guessing this is a parsing error or interoperability weakness in
> BlueZ...? (Or, less likely but possible, a bug in the other 2 stacks?)

The PDU that the remote computer sends is truncated at the end of the
first L2CAP frame (all the 0's that hcidump shows are just empty buffer as
it does not check the actual frame length). But, each L2CAP frame is
supposed to contain an entire PDU and when the data exceeds the MTU it
sends a non zero Continuation State to enable the client to request more
data.

It might be that this computer was not expecting that the response would
overflow the L2CAP frame and they didn't write the code to handle that,
but in the meantime many services were added..

You can probably use "sdptool search" to find specific services ok?

Although sdptool has no way to increase the "Incoming MTU" on the SDP
connection, if you could work out how to do that it might allow more
information to be received (in lib/sdp.c:sdp_connect_l2cap() set
L2CAP_OPTIONS with imtu at some large number than 672, before the
connect())

regards,
iain


