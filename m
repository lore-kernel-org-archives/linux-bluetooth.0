Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030513104050.0d251ee8@unixmail.qualcomm.com>
Date: Tue, 13 May 2003 10:44:59 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000901c318df$6b11ad00$1a01010a@baked>
References: <1052584255.1133.13.camel@pegasus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 04:37 PM 5/12/2003, Daryl Van Vorst wrote:
>Re: l2cap config stuff:
>
>We don't need any more logs or anything for that do we?  I think we're just
>trying to understand what it is exactly that we're supposed to do and why.
Yep. No need for logs.

>Max - You mentioned that the spec says that what the stack does with a
>config reject can be implementation specific. I just had a look at the spec
>and couldn't find it. Could you tell me where to look in the spec? 

section 6.1 
page 297

"Since all L2CAP implementations are capable to support a minimum L2CAP
packet size, see Section 4 on page 280, MTU is not really a negotiated value
but rather an informational parameter to the remote device that the local device
can accommodate in this channel an MTU larger than the minimum required. In
the unlikely case that the remote device is only willing to send L2CAP packets
in this channel that are larger than the MTU announced by the local device,
then this Configuration Request will receive a negative response in which the
remote device will include the value of MTU that is indented to transmit. In this
case, it is implementation specific on whether the local device will continue the
configuration process or even maintain this channel."

Max
