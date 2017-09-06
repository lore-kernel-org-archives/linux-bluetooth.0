Return-Path: <jaganath.k.os@gmail.com>
MIME-Version: 1.0
In-Reply-To: <51322678-6D7A-4747-B932-24CF99F4DA47@holtmann.org>
References: <CAJzH+boScGTf16artQxnFSK5G=AdDv8xh1kyrZM=OhaQ+_c_JQ@mail.gmail.com>
 <51322678-6D7A-4747-B932-24CF99F4DA47@holtmann.org>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Wed, 6 Sep 2017 16:32:14 +0530
Message-ID: <CAJzH+brxbuYQWeJuP1aCskHtgfv6nQLRd9Q_WGr5ZG+UZKsDrg@mail.gmail.com>
Subject: Re: LE New PHYs implementation
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Sep 1, 2017 at 6:02 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaganath,
>
>> Are there any plans to implement LE new PHYs defined in 5.0?
>>
>> I think the first step would be to define the kernel API for setting new PHY
>>
>> How abt implementing mgmt command or l2cap socket option for "Set PHY"
>> and mgmt event for "PHY Update".
>>
>> I suppose socket option for "Set PHY" would be more convenient for
>> applications especially for L2CAP CoC usecases like OTS.
>>
>> If multiple fds (apps) sets different PHYs then priority should be in
>> the order of Coded, 2M, 1M since long range would not break 2M use
>> cases (data rate will be affected) where as other way around might not
>> work as expected.
>>
>> Any leads would be appreciated.
>
> I was thinking about using bdaddr_type for it or introducing a phy_type. This is not yet fully thought through. It needs a bit of figuring out what would work best.

If we use bdaddr_type, i think we would need combinations to use it
with PUBLIC and RANDOM. So i think introducing phy_type is better.
Can we add phy_type in struct mgmt_addr_info as a bit field?
It can be used in Socket Connect for phy preference and
mgmt_device_connected event to inform user abt the connected phy.

>In addition we also need proper reporting in scan reports via mgmt. There either bdaddr_type or maybe an extra flags field to indicate LE coded.

I suppose adding extra flags is better. We can have new DEV_FOUND
flags to inform abt primary and secondary phys of the scan report
Also Is it Ok to always scan on LE coded  as well, if the controller supports?

Thanks,
Jaganath
