Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Nov 2011 12:32:35 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix mgmt response when adapter goes down
 or is removed
Message-ID: <20111103143235.GD23913@joana>
References: <1320317931-15260-1-git-send-email-johan.hedberg@gmail.com>
 <1320324033-16280-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320324033-16280-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-03 14:40:33 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When an adapter gets powered off or is removed any pending commands
> should receive a ENETDOWN or ENODEV status response.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Fix uint8_t -> u8
> 
>  net/bluetooth/mgmt.c |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
