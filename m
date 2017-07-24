Return-Path: <netdev-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170724172523.13135-2-sthemmin@microsoft.com>
References: <20170724172523.13135-1-sthemmin@microsoft.com> <20170724172523.13135-2-sthemmin@microsoft.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 24 Jul 2017 10:48:17 -0700
Message-ID: <CACKFLikMZ_HUYPgnvU2bNQfLy86XVEgVWpkGRYry+HUb-Z_1ow@mail.gmail.com>
Subject: Re: [PATCH net-next 1/6] bnxt: fix unsigned comparsion with 0
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
        David Miller <davem@davemloft.net>, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de,
        Netdev <netdev@vger.kernel.org>, linux-bluetooth@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 24, 2017 at 10:25 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> Fixes warning because location is u32 and can never be netative
> warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>

Acked-by: Michael Chan <michael.chan@broadcom.com>
