Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Nov 2010 17:28:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Extract flags from advertising data
Message-ID: <20101119152811.GD28815@jh-x301>
References: <1290175048-16026-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290175048-16026-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Fri, Nov 19, 2010, Bruna Moreira wrote:
> These flags will be used to decide if GATT service discovery will happen
> over LE (for single mode devices) or BR/EDR (for dual mode and non-LE
> devices).
> ---
>  src/adapter.c |   14 ++++++++++++++
>  src/adapter.h |    1 +
>  src/sdpd.h    |   10 ++++++++++
>  3 files changed, 25 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
