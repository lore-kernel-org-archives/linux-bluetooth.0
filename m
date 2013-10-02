Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Fix REJECTED vs NOT_SUPPORTED mgmt responses
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380717922-25142-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 2 Oct 2013 14:53:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <55CB2C93-CEBC-4F8F-98A2-58AEC6888B94@holtmann.org>
References: <1380717922-25142-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The REJECTED management response should mainly be used when the adapter
> is in a state where we cannot accept some command or a specific
> parameter value. The NOT_SUPPORTED response in turn means that the
> adapter really cannot support the command or parameter value.
> 
> This patch fixes this distinction and adds two helper functions to
> easily get the appropriate LE or BR/EDR related status response.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 76 +++++++++++++++++++++++++++++++++++-----------------
> 1 file changed, 51 insertions(+), 25 deletions(-)

patch has been applied to bluetooth-next.

Regards

Marcel

