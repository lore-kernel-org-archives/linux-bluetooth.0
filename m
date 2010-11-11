Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 23:16:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH v2 4/7] Initial advertising data parsing implementation
Message-ID: <20101111211616.GE24514@jh-x301>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
 <1289501521-21825-4-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289501521-21825-4-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 11, 2010, Vinicius Costa Gomes wrote:
> +	int8_t rssi = 0;
> +
> +	rssi = *(info->data + info->length);

There's no point in initializing rssi upon declaration since the very
next thing you do is assign a new value to it (not to mention that in
general we try to avoid initialization upon declaration in the code).

> +void btd_event_adv(bdaddr_t *local, le_advertising_info *info)

I'm not really a fan of the adv abreviation, and the function name isn't
even in danger of growing horribly long if you don't abreviate it. So
could you come up with something more clear? Maybe
btd_event_advertising_info or btd_event_advertising_report?

I'll stop reviewing this patch-set here since the rest seem to depend on
the name of this function.

Johan
