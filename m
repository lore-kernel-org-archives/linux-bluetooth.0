Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Nov 2010 17:29:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Merge service UUIDs from different BR/EDR EIR data
Message-ID: <20101119152930.GE28815@jh-x301>
References: <1290178241-8358-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290178241-8358-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Fri, Nov 19, 2010, Anderson Lizardo wrote:
> For LE devices, service UUIDs present in advertising data are merged
> into a single list. This change makes the same thing for BR/EDR devices.
> ---
>  src/adapter.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)

Pushed upstream. Thanks.

Johan
