Return-Path: <cyrus@holtmann.org>
Message-ID: <1332762488.1870.95.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Check for minimum data length in
 eir_has_data_type()
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 26 Mar 2012 13:48:08 +0200
In-Reply-To: <1332760902-16071-2-git-send-email-johan.hedberg@gmail.com>
References: <1332760902-16071-1-git-send-email-johan.hedberg@gmail.com>
	 <1332760902-16071-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If passed 0 as data_length the (parsed < data_length - 1) test will be
> true and cause a buffer overflow. In practice we need at least two bytes
> for the element length and type so add a test for it to the very
> beginning of the function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


