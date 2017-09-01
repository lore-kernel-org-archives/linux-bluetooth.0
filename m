Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: LE New PHYs implementation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJzH+boScGTf16artQxnFSK5G=AdDv8xh1kyrZM=OhaQ+_c_JQ@mail.gmail.com>
Date: Fri, 1 Sep 2017 14:32:21 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <51322678-6D7A-4747-B932-24CF99F4DA47@holtmann.org>
References: <CAJzH+boScGTf16artQxnFSK5G=AdDv8xh1kyrZM=OhaQ+_c_JQ@mail.gmail.com>
To: Jaganath K <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> Are there any plans to implement LE new PHYs defined in 5.0?
> 
> I think the first step would be to define the kernel API for setting new PHY
> 
> How abt implementing mgmt command or l2cap socket option for "Set PHY"
> and mgmt event for "PHY Update".
> 
> I suppose socket option for "Set PHY" would be more convenient for
> applications especially for L2CAP CoC usecases like OTS.
> 
> If multiple fds (apps) sets different PHYs then priority should be in
> the order of Coded, 2M, 1M since long range would not break 2M use
> cases (data rate will be affected) where as other way around might not
> work as expected.
> 
> Any leads would be appreciated.

I was thinking about using bdaddr_type for it or introducing a phy_type. This is not yet fully thought through. It needs a bit of figuring out what would work best. In addition we also need proper reporting in scan reports via mgmt. There either bdaddr_type or maybe an extra flags field to indicate LE coded.

Regards

Marcel

