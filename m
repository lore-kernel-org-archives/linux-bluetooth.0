Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Fri, 1 Sep 2017 12:39:39 +0530
Message-ID: <CAJzH+boScGTf16artQxnFSK5G=AdDv8xh1kyrZM=OhaQ+_c_JQ@mail.gmail.com>
Subject: LE New PHYs implementation
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Are there any plans to implement LE new PHYs defined in 5.0?

I think the first step would be to define the kernel API for setting new PHY

How abt implementing mgmt command or l2cap socket option for "Set PHY"
and mgmt event for "PHY Update".

I suppose socket option for "Set PHY" would be more convenient for
applications especially for L2CAP CoC usecases like OTS.

If multiple fds (apps) sets different PHYs then priority should be in
the order of Coded, 2M, 1M since long range would not break 2M use
cases (data rate will be affected) where as other way around might not
work as expected.

Any leads would be appreciated.

Thanks,
Jaganath
