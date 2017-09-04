Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 4 Sep 2017 14:59:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?Q?=C5=81ukasz?= Rymanowski <lukasz.rymanowski@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] mesh: Fix for handling unprovisioned device
Message-ID: <20170904115953.GA30887@x1c.lan>
References: <20170831101257.1644-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170831101257.1644-1-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thu, Aug 31, 2017, Łukasz Rymanowski wrote:
> If there is no ServiceData there is no valid provisioning data for
> PB-GATT
> ---
>  mesh/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've applied patches 1 and 2 from this set. Thanks.

Johan
