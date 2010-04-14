Return-Path: <cyrus@holtmann.org>
Subject: Re: l2cap connection id in user-space
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
Cc: linux-bluetooth@vger.kernel.org, shitiz_kumar@ti.com
In-Reply-To: <112852.88977.qm@web94911.mail.in2.yahoo.com>
References: <112852.88977.qm@web94911.mail.in2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Apr 2010 17:59:32 -0700
Message-ID: <1271206772.22838.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

> Is there a possibility as of now for me to extract the l2cap connection ID into my application ?
> 
> I require 2 sets of information about an L2CAP connection in my bluetooth application, I require the connection ID on connection to a remote headset/sink, and also the maximum packet size for that connection (which I think is the MTU, I can get via the getsockopt).

you need a recent kernel and then getsockname() and getpeername() will
give you the SCID and DCID.

Regards

Marcel


