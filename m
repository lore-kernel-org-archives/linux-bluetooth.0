Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJzH+boScGTf16artQxnFSK5G=AdDv8xh1kyrZM=OhaQ+_c_JQ@mail.gmail.com>
References: <CAJzH+boScGTf16artQxnFSK5G=AdDv8xh1kyrZM=OhaQ+_c_JQ@mail.gmail.com>
From: Emil Lenngren <emil.lenngren@gmail.com>
Date: Fri, 1 Sep 2017 13:37:57 +0200
Message-ID: <CAO1O6sekNZQwK7R08g1axLKVO8HOw8YYE-92tG9eAJd-D0Ubww@mail.gmail.com>
Subject: Re: LE New PHYs implementation
To: Jaganath K <jaganath.k.os@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There should be options when scanning devices as well to scan on the
LE Coded PHY. However when scanning you specify as a bitmask which
PHYs you want to scan on so there it's easier if there are multiple
apps that want to scan on different PHYs.

2017-09-01 9:09 GMT+02:00 Jaganath K <jaganath.k.os@gmail.com>:
> Hi,
>
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
>
> Thanks,
> Jaganath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
