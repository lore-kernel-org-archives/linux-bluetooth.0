Return-Path: <cyrus@holtmann.org>
Message-ID: <1329840549.2049.16.camel@aeonflux>
Subject: Re: [PATCH 1/9] Bluetooth: mgmt: Fix powered checks for commands
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 21 Feb 2012 17:09:09 +0100
In-Reply-To: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Having the HCI_AUTO_OFF flag set means that from a mgmt interface
> perspective we're still not powered, so all tests for HCI_UP should also
> include a test for HCI_AUTO_OFF. This patch adds a convenience macro for
> it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   26 ++++++++++++++------------
>  1 files changed, 14 insertions(+), 12 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


