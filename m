Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABuKQigFTmsni5cGhgMdneez_K78-cKTrg1LG6qHZjmK2tpj7g@mail.gmail.com>
References: <1479123009-7190-1-git-send-email-luiz.dentz@gmail.com>
 <20161114115118.GA5921@x1c> <CABuKQigFTmsni5cGhgMdneez_K78-cKTrg1LG6qHZjmK2tpj7g@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Nov 2016 16:12:28 +0200
Message-ID: <CABBYNZK3B61f4gVuCGMM+7pSB3ik-jvAx+=6GWMwkS7mAecaKQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/adapter: Fix using wrong address type to
 listen ATT
To: Trump DD <wrxzzj@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 14, 2016 at 3:53 PM, Trump DD <wrxzzj@gmail.com> wrote:
> this patch look like fix part bug of BLE devices reconnect
>
> when I restart bluetoothd , all works fine.
> such as:
> systemctl stop bluetooth
> systemctl start bluetooth
> click BLE mouse button, reconnect success.
>
> but this issue existed after apply this patch
> 1.  reboot computer, bluetoothd the first time startup, BLE mouse
> reconnect failed with loop
> Connected: yes
> Connected: no
> ...
> ...

Are you sure this is exact the same version after you reboot? Because
from the logs it looks like the exact same problem so perhaps you have
the older version being restored or something else is loading the old
binary, for me this works all the time even after rebooting, or
actually running a vm, but Im running it from source directly.
