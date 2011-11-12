Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: Pass all message parameters to
 mgmt_start_discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 13 Nov 2011 08:30:48 +0900
In-Reply-To: <1321091902-6815-1-git-send-email-johan.hedberg@gmail.com>
References: <1321091515-6543-1-git-send-email-johan.hedberg@gmail.com>
	 <1321091902-6815-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321140651.15441.442.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The mgmt_start_discovery command contains the type of discovery that
> should be started so this should be passed to the start_discovery
> function. This patch doesn't yet add any action depending on the type of
> the requested discovery.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Fix stupid copy-paste error with the MGMT_OP in case of an invalid
> message length.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


