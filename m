Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 19 Sep 2016 21:49:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?Q?Micha=C5=82?= Narajowski <michal.narajowski@codecoup.pl>
Subject: Re: [PATCH] Bluetooth: Set appearance only for LE capable controllers
Message-ID: <20160919184957.GA5171@t440s>
References: <1474288415-16308-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1474288415-16308-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michał,

On Mon, Sep 19, 2016, Michał Narajowski wrote:
> Setting appearance on controllers without LE support will result
> in No Supported error.
> 
> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
> ---
>  net/bluetooth/mgmt.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
