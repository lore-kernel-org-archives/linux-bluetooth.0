Return-Path: <cyrus@holtmann.org>
Message-ID: <1330634868.3392.108.camel@aeonflux>
Subject: Re: [PATCH 4/5] Bluetooth: mgmt: Add defines for command sizes
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Mar 2012 12:47:48 -0800
In-Reply-To: <1330634012-4502-4-git-send-email-johan.hedberg@gmail.com>
References: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
	 <1330634012-4502-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> These defines are shorter than "sizeof(struct mgmt_cp_foo_bar...)" and
> will be helpful when extending the command lookup table to contain the
> expected command size information.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


