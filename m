Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Nov 2014 14:58:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] shared/gatt: Fix dereference before NULL check
 warnings
Message-ID: <20141127125823.GA29742@t440s>
References: <1416489195-26477-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416489195-26477-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Nov 20, 2014, Andrei Emeltchenko wrote:
> Add NULL check otherwise constructions like below give warnings:
> ...
> 	uint8_t pdu[4 + get_uuid_len(uuid)];
> 
> 	if (!att || !uuid || uuid->type == BT_UUID_UNSPEC)
> ...
> ---
>  src/shared/gatt-helpers.c | 3 +++
>  1 file changed, 3 insertions(+)

Both patches in this set have been applied. Thanks.

Johan
