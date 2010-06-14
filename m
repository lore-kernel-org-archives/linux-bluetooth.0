Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Jun 2010 21:50:41 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: "Andrew Kohlsmith (mailing lists account)" <aklists@mixdown.ca>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: odd cid change in l2cap negotiation
Message-ID: <20100614005041.GB6390@vigoh>
References: <201006131728.36687.aklists@mixdown.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201006131728.36687.aklists@mixdown.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrew,

* Andrew Kohlsmith (mailing lists account) <aklists@mixdown.ca> [2010-06-13 17:28:35 -0400]:

> Good afternoon,
> 
> I'm working on a small embedded system with its own stack and using BlueZ on 
> Ubuntu 9.04 (4.32 according to apt-cache).
> 
> I am using a very stupid l2cap test program (listed below) to just open a 
> connection to psm 0x1001 and send "Hello, World!".
> 
> The embedded system receives the L2CAP connection request from BlueZ (scid of 
> 0x0040) and responds by sending a configuration request. It uses dcid 0x0040.  
> BlueZ responds to the configuration request with a successful configuration 
> response, but it sets the scid to 0x0.000 and I can't for the life of me figure 
> out why.
> 
> The raw HCI packets (obtained from hcidump) are as follows:
> 
> BlueZ connection request:
> 02 2a 20 0c 00 08 00 01 00 02 02 04 00 01 10 40 00

There is a missing connection response from the Embedded here. It sends
the configure response directly.
Bluez shouldn't even send a config request in this case, this is another
bug btw. Not related to yours.

> 
> Embedded configure request:
> 02 2a 20 10 00 0c 00 01 00 04 02 08 00 40 00 00 00 01 02 96 00
> 
> BlueZ configure response:
> 02 2a 20 12 00 0e 00 01 00 05 02 0a 00 00 00 00 00 00 00 01 02 96 00
> 
> BlueZ configure request:
> 02 2a 20 0c 00 08 00 01 00 04 03 04 00 00 00 00 00
> 
> As you can see, the connection request is using scid 0x0040 to psm 0x1001, and 
> the configure request coming back to BlueZ is using dcid 0x0040. The BlueZ 
> configure response (and subsequent request) are using channel id 0x0000. Why is 
> this?
> 
> If I patch out the embedded system's L2CAP handler code to accept the 
> configuration response coming from the wrong cid BlueZ continues by sending the 
> data packet ("Hello, World!" but again, to dcid 0x0000...
> 
> Why is BlueZ flipping the channel ID like this? I am assuming that I am making 
> a mistake somewhere as BlueZ gets a LOT more use than this embedded stack, but 
> I can't figure out what this is happening for nor how to correctly work with 
> it.
> 

-- 
Gustavo F. Padovan
http://padovan.org
