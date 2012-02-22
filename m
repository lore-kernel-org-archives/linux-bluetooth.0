Return-Path: <cyrus@holtmann.org>
Message-ID: <1329909445.2049.33.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: mgmt: Make Set SSP command callable
 while powered off
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 12:17:25 +0100
In-Reply-To: <1329909172-19958-3-git-send-email-johan.hedberg@gmail.com>
References: <1329909172-19958-1-git-send-email-johan.hedberg@gmail.com>
	 <1329909172-19958-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch makes it possible to enable SSP through mgmt even when
> powered off. The setting will then get automatically actiated when
> powering on.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_event.c        |   20 +++++++---------
>  net/bluetooth/mgmt.c             |   44 +++++++++++++++++++++++++++++++-------
>  3 files changed, 46 insertions(+), 20 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


