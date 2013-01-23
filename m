Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Jan 2013 02:20:58 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix Class of Device indication when powering
 off
Message-ID: <20130123042058.GD1632@joana>
References: <1358345734-17892-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358345734-17892-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-01-16 16:15:34 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When a HCI device is powered off the Management interface specification
> dictates that the class of device value is indicated as zero. This patch
> fixes sending of the appropriate class of device changed event when a
> HCI device is powered off.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    6 ++++++
>  1 file changed, 6 insertions(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
