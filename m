Return-Path: <cyrus@holtmann.org>
Message-ID: <1329938052.2049.40.camel@aeonflux>
Subject: Re: [PATCH 1/3] Bluetooth: Add hdev->short_name for EIR generation
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 20:14:12 +0100
In-Reply-To: <1329937615-29893-1-git-send-email-johan.hedberg@gmail.com>
References: <1329937615-29893-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It's possible to provide a short name through the mgmt interface and
> this name can be used for EIR generation when the full name doesn't fit
> there. This patch adds the preliminary tracking of the provided short
> name.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    3 +++
>  include/net/bluetooth/mgmt.h     |    2 +-
>  net/bluetooth/mgmt.c             |    3 +++
>  3 files changed, 7 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


