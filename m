Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Tue, 13 May 2003 11:36:08 -0700
Message-ID: <000801c3197e$8591e290$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5.1.0.14.2.20030513104050.0d251ee8@unixmail.qualcomm.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

> >Max - You mentioned that the spec says that what the stack 
> does with a 
> >config reject can be implementation specific. I just had a 
> look at the 
> >spec and couldn't find it. Could you tell me where to look 
> in the spec?
> 
> section 6.1 
> page 297
> 
> "Since all L2CAP implementations are capable to support a 
> minimum L2CAP packet size, see Section 4 on page 280, MTU is 
> not really a negotiated value but rather an informational 
> parameter to the remote device that the local device can 
> accommodate in this channel an MTU larger than the minimum 
> required. In the unlikely case that the remote device is only 
> willing to send L2CAP packets in this channel that are larger 
> than the MTU announced by the local device, then this 
> Configuration Request will receive a negative response in 
> which the remote device will include the value of MTU that is 
> indented to transmit. In this case, it is implementation 
> specific on whether the local device will continue the 
> configuration process or even maintain this channel."

What about flowspec and flush timeout?

In section 6.4.2 FlushTO is listed as one of the items in the response path
(along with MTU and InFlow). But in section 7.5 only MTU and InFlow are
listed.

I sent the above quote to Cetecom last week. They responded saying that MTU
isn't the only negotiated parameter.

-Daryl.
