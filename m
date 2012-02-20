Return-Path: <cyrus@holtmann.org>
Message-ID: <1329776729.2049.0.camel@aeonflux>
Subject: Re: [PATCH 1/4] Bluetooth: mgmt: Add address type parameter to Stop
 Discovery command
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 20 Feb 2012 23:25:29 +0100
In-Reply-To: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
References: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds an address type parameter to the Stop Discovery command
> which should match the value given to Start Discovery.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    3 +++
>  net/bluetooth/mgmt.c         |   33 ++++++++++++++++++++++-----------
>  2 files changed, 25 insertions(+), 11 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


