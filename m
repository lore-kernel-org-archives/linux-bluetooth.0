Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAB_54W6dSUbybTyWq+Bap0KqCLZGcgSbrJrFGLY_VLPHOC9DJw@mail.gmail.com>
References: <CGME20180117034755epcas5p1437f6831b91eb594a1106f0960204b81@epcas5p1.samsung.com>
 <1516160848-471-1-git-send-email-yi2010.guo@samsung.com> <CABBYNZJjOEandxFeqbnei3bWpsNetWTbnna+7zGi5FofzcS59g@mail.gmail.com>
 <CAB_54W6dSUbybTyWq+Bap0KqCLZGcgSbrJrFGLY_VLPHOC9DJw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jan 2018 11:00:43 -0200
Message-ID: <CABBYNZL9Xc5619AYf7Lqm3CPRG=ALQp9bLqbBKnJXVN6Bn0_Kg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix disconnect bug in 6lowpan
To: Alexander Aring <alex.aring@gmail.com>
Cc: Guo Yi <yi2010.guo@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, Jan 17, 2018 at 3:37 PM, Alexander Aring <alex.aring@gmail.com> wrote:
> Hi,
>
> 2018-01-17 7:15 GMT-05:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>> Hi,
>>
>> On Wed, Jan 17, 2018 at 1:47 AM, Guo Yi <yi2010.guo@samsung.com> wrote:
>>> This patch fix the bluetooth 6lowpan disconnect fail bug.
>>>
>>> The type of the same address type have different define value in HCI layer
>>> and L2CAP layer.That makes disconnect fail due to wrong network type.User
>>> will not be able to disconnect from console with the network type that used
>>> in connect.
>>>
>>> This patch add a var lookup_type, and covert the channel address type to
>>> HCI address type. By these means, user can disconnect successfuly.
>>>
>>> Signed-off-by: Guo Yi <yi2010.guo@samsung.com>
>>
>> While this fix seems alright the debugfs interface was never meant for
>> production, in fact we are working on a replacement:
>>
>
> Is the new API fixing the issue that the 6LoWPAN device creation is
> done by iproute e.g.:
>
> ip link add link wpan0 name lowpan0 type lowpan
>
> or is there a special bluetooth API call needed, like the current case
> with debugfs.
> I know hcis are not netdevs, but it bothers me that we running into
> two different worlds on how to deal with that and it just requires
> "more" special bluetooth specific handling in user space applications.
> Later more "netdev" capable link layers will maybe support 6LoWPAN and
> then bluetooth might the only subsystem where different handling is
> needed to do such job like that.

Keep in mind that the transport on Bluetooth happens to be in a
different layer, so you are basically suggesting that the kernel
maintain a L2CAP connection, similar to TCP, which has several
security implications.

> We maybe need to support a special handling in "ip link add" to map to
> bluetooth instead moving that to people in user space?

Afaik ip tool cannot support any tunnel interface since the kernel
cleanup any socket opened when the tool exit. Btw, with the patches
above bluetoothd would take care of adding/removing the links
automatically so at least this step will not be necessary. Other ip
commands should work though.

> - Alex



-- 
Luiz Augusto von Dentz
