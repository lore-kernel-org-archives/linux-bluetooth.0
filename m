Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Apr 2010 18:19:13 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
Cc: linux-bluetooth@vger.kernel.org, shitiz_kumar@ti.com
Subject: Re: l2cap connection id in user-space
Message-ID: <20100413211913.GA20489@vigoh>
References: <112852.88977.qm@web94911.mail.in2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <112852.88977.qm@web94911.mail.in2.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

* Pavan Savoy <pavan_savoy@yahoo.co.in> [2010-04-14 02:26:41 +0530]:

> Is there a possibility as of now for me to extract the l2cap connection ID into my application ?

bluez-hcidump does that. Look to its source code to learn how.

> 
> I require 2 sets of information about an L2CAP connection in my bluetooth application, I require the connection ID on connection to a remote headset/sink, and also the maximum packet size for that connection (which I think is the MTU, I can get via the getsockopt).
> 

-- 
Gustavo F. Padovan
http://padovan.org
