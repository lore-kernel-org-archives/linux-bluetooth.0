Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v2 3/3] Bluetooth: Add 'sync' specifier to synchronous request APIs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447141495-31126-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Nov 2015 18:16:07 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C17721B5-63AF-4D2E-99AF-9D1FE0B1D0EB@holtmann.org>
References: <1447141495-31126-1-git-send-email-johan.hedberg@gmail.com> <1447141495-31126-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To make it clear which HCI request APIs target specifically
> synchronous requests, add 'sync' to the API names.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c    | 28 ++++++++++++++--------------
> net/bluetooth/hci_request.c |  6 +++---
> net/bluetooth/hci_request.h |  6 +++---
> 3 files changed, 20 insertions(+), 20 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

