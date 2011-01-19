Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 20:41:58 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Rename gatt_primary_t to more generic name
Message-ID: <20110119151158.GC2112@jh-x301>
References: <1295293069-29637-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295293069-29637-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Mon, Jan 17, 2011, Bruna Moreira wrote:
> The gatt_primary_t typedef was renamed to gatt_cb_t because it will be
> used for primary and characteristic callbacks.
> ---
>  attrib/gatt.c |    4 ++--
>  attrib/gatt.h |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
