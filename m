Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <563B42D3.80208@streamunlimited.com>
References: <563B42D3.80208@streamunlimited.com>
Date: Fri, 6 Nov 2015 12:16:47 +0200
Message-ID: <CABBYNZKPUUpiu_eCtLU-ikmRYQYO7zowCtToioNpF0AnDd49Gg@mail.gmail.com>
Subject: Re: Concurrent BLE central and peripheral mode with BlueZ-4.101
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: edo.sevc@streamunlimited.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Edo,

On Thu, Nov 5, 2015 at 1:51 PM, Edo Sevc <edo.sevc@streamunlimited.com> wrote:
> Hello,
>
> Our embedded  platform is running Linux Kernel 4.1 and BlueZ-4.101.
> We have received a new requirement to work simultaneously in LE Central and
> Peripheral modes, a functionality introduced in Bluetooth 4.1.
> Would it be feasible to get the concurrent Central and Peripheral modes
> running on BlueZ-4.101 by backporting the corresponding changes from newer
> BlueZ (and kernel) versions?
> Or do we have to migrate to BlueZ-5?

4.101 is too old afaik it doesn't support LE peripheral mode, so I
would suggest you to upgrade to BlueZ 5 since you already have a quite
recent kernel.


-- 
Luiz Augusto von Dentz
