Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: how to add local name in scan response when setting
 MGMT_ADV_FLAG_LOCAL_NAME in Bluez
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALvjcs91hPqUGCGh286U4wDU8rfd1BfMVGHov9o9522MwrNpvw@mail.gmail.com>
Date: Thu, 3 Aug 2017 01:54:56 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <5AD53E84-B68F-4F00-B0E1-EF555ADCBC91@holtmann.org>
References: <CALvjcs8cbrO1sE_bgKXsLZ6C5omO=Y_duXjkRC1Rww-z156v9w@mail.gmail.com>
 <CABBYNZLhS+-ugFxXKZ6mmk2BvCHmLG8sxWhfdnW1U05OMqqNHA@mail.gmail.com>
 <CABBYNZL98uajaq0+GHyKWBsp_aZPNxQkG0YCimzu0510vVR=cw@mail.gmail.com>
 <CABBYNZ+nO7hM8mR7ERbGd=Quy=VvbUdTZbU6LVHf2DzLeVGn9w@mail.gmail.com>
 <CALvjcs91hPqUGCGh286U4wDU8rfd1BfMVGHov9o9522MwrNpvw@mail.gmail.com>
To: Yunhan Wang <yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunnan,

> Thanks for your reply. I think kernel should support scan response
> because I am able to set different local name in scan rsp using hci
> socket instead of Dbus API. Have you ever post your patch or sample
> code in this thread or any other place? May I have a try on your
> patch? It would be doable and useful to put Local name change as
> property, like include tx power, so that we can set it in scan rsp
> when enabling advertisement.

have you actually checked that local name is supported via advertising instances. The Read Advertising Features mgmt command is pretty clear in its description that support for adding local name in scan response is optional. The command is also pretty clear in that if that flag is given, the local name is managed via the kernel and can only be modified via Set Local Name mgmt command. If you want to use any other name in scan response, you need to not specify that flag.

Using raw HCI sockets is like packet injection. That does not count. Also you will never make that work correctly since you essentially by-passing the kernel and programming the hardware directly.

Regards

Marcel

