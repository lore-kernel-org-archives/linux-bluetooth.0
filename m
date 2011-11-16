Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 16:00:25 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Fix mgmt_pair_device imediate error
 responses
Message-ID: <20111116180025.GE16865@joana>
References: <1320962855-19036-1-git-send-email-johan.hedberg@gmail.com>
 <1320962855-19036-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320962855-19036-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-11 00:07:35 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When possible cmd_complete should be returned instead of cmd_status
> since it contains the remote address (this helps user-space track what
> exactly failed).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)

Both patches were applied, thanks.

	Gustavo
