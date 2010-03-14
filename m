Return-Path: <cyrus@holtmann.org>
Subject: Re: Bug in parsing of SDP_ServiceSearchAttributeResponse?
From: Marcel Holtmann <marcel@holtmann.org>
To: Iain Hibbert <plunky@rya-online.net>
Cc: Daniel Abraham <daniel.shrugged@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1268352254.586562.6662.nullmailer@galant.ukfsn.org>
References: <1268344653.9884.42.camel@dabraham-mobl>
	 <1268352254.586562.6662.nullmailer@galant.ukfsn.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Mar 2010 13:40:30 -0700
Message-ID: <1268599230.3897.44.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> > According to hcidump (attached), the SDP_ServiceSearchAttributeResponse
> > is malformed, but a different Bluetooth stack (IVT on Windows) is able
> > to report correctly the remote computer's available services.
> 
> It could be that the different Bluetooth stacks fetch that information via
> a different request than ServiceSearchAttributes, or that it queries the
> services that it hopes to see individually rather than just the
> PublicBrowseGroup to get everything as in this case.
> 
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

you can decode only HCI and L2CAP like this:

	hcidump -r <file> -X -V hci l2cap

That will avoid involving the SDP parser and you see that it is one
L2CAP packet with 672 bytes in there (split over two ACL packets).

The remote stack is having a bug in L2CAP already anyway:

	> ACL data: handle 11 flags 0x02 dlen 14
	    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
	      Success

It is mandatory for the config response to include the MTU size to
confirm the configured value.

The SDP protocol is pretty clear in how to handle splitting long PDUs
over multiple L2CAP frames. This remote stack doesn't do it at all.
BlueZ handles this properly.

I wouldn't be surprised that even if you see the packet in hcidump, the
kernel actually dropped it. And it never was handed out to the
application because it was not fragmented properly. Check dmesg if the
kernel dropped a packet.

Regards

Marcel


