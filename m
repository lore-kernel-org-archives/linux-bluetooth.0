Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Nov 2013 10:37:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 1/3] android: Update bond state on incoming bonding
Message-ID: <20131111083735.GA4541@x220.p-661hnu-f1>
References: <1383925711-26374-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1383925711-26374-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383925711-26374-2-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Nov 08, 2013, Lukasz Rymanowski wrote:
> Before sending any ssp request or pin code request up to HAL library we
> need to send bond state change with bonding state. Otherwise incoming
> bonding is impossible.
> ---
>  android/adapter.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

Wont this cause HAL_BOND_STATE_BONDING to be sent twice if the pairing
was locally initiated through create_bond()?

Johan
