Return-Path: <cyrus@holtmann.org>
Subject: Re: Bug in parsing of SDP_ServiceSearchAttributeResponse?
From: Daniel Abraham <daniel.shrugged@gmail.com>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1268352254.586562.6662.nullmailer@galant.ukfsn.org>
References: <1268344653.9884.42.camel@dabraham-mobl>
	 <1268352254.586562.6662.nullmailer@galant.ukfsn.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Mar 2010 15:50:16 +0200
Message-ID: <1268574616.6238.903.camel@dabraham-mobl>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > So I'm guessing this is a parsing error or interoperability weakness in
> > BlueZ...? (Or, less likely but possible, a bug in the other 2 stacks?)
> 
> The PDU that the remote computer sends is truncated at the end of the
> first L2CAP frame (all the 0's that hcidump shows are just empty buffer as
> it does not check the actual frame length). But, each L2CAP frame is
> supposed to contain an entire PDU and when the data exceeds the MTU it
> sends a non zero Continuation State to enable the client to request more
> data.
> 
> It might be that this computer was not expecting that the response would
> overflow the L2CAP frame and they didn't write the code to handle that,
> but in the meantime many services were added..

Thanks! This is exactly the pointer I was looking for. I didn't
understand your answer at first, but it led me to study the right
section in the BT spec, so now I get it.

> You can probably use "sdptool search" to find specific services ok?

Actually "sdptool" is just an example, the real problem is that when
BlueZ discovers that device, the SDP PDU truncation causes it to appear
to be profile-less, so I can't actively connect to any service, only
passively accept connections.

> Although sdptool has no way to increase the "Incoming MTU" on the SDP
> connection, if you could work out how to do that it might allow more
> information to be received (in lib/sdp.c:sdp_connect_l2cap() set
> L2CAP_OPTIONS with imtu at some large number than 672, before the
> connect())

Although the PDU truncation is a bug not in BlueZ, I still think it uncovers a point for improvement in BlueZ.

Up until the truncation point, the PDU still contains 6-7 valid attribute lists, which are discarded. Why not use them despite the malformed PDU?

Thanks again

