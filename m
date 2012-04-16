Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 12:41:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: mgmt: Fix address type while loading Long
 Term Key
Message-ID: <20120416094146.GA25816@x220.P-661HNU-F1>
References: <1334568460-24386-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334568460-24386-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Mon, Apr 16, 2012, Hemant Gupta wrote:
> This patch fixes the address type while loading long term keys when BT is
> switched on. Without this fix pairing is reinitated even though LTK
> exists for remote device because of mismatch of address type.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/mgmt.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
