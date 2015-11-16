Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKafyqpqOgSueeyqDWPWeyaF11+WxbU28vAHdOp+yfE=Zz3gwg@mail.gmail.com>
References: <CAKafyqpqOgSueeyqDWPWeyaF11+WxbU28vAHdOp+yfE=Zz3gwg@mail.gmail.com>
Date: Mon, 16 Nov 2015 10:54:54 +0200
Message-ID: <CABBYNZLZtEBXkEBVvrU9GUPQTOeiL979vCs6Cewh7SThAsLS-A@mail.gmail.com>
Subject: Re: HoG Disconnection=> Reason: Connection Time out
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

On Mon, Nov 16, 2015 at 7:27 AM, Prabhu Chawandi <foss.chaws@gmail.com> wrote:
> Hi All,
>
>     When connecting a bonded HoG device, I am seeing the connection
> unsuccessful.
>
> When I saw hcidump, pasted comlete hcidump below. Please let me know
> what is the reason.
>
>> HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 75 reason 0x08
>     Reason: Connection Timeout

Looks like everything is fine until the timeout, does this manifest
every time? What controller do you have, perhaps you can try with
different controller to see if that helps, if it doesn't then you will
probably need a sniffer to find out why it is disconnecting.

Btw, can you share what device is it?


-- 
Luiz Augusto von Dentz
