Return-Path: <cyrus@holtmann.org>
Message-ID: <1332762451.1870.94.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Don't increment twice in
 eir_has_data_type()
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 26 Mar 2012 13:47:31 +0200
In-Reply-To: <1332760902-16071-1-git-send-email-johan.hedberg@gmail.com>
References: <1332760902-16071-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The parsed variable is already incremented inside the for-loop so there
> no need to increment it again (not to mention that the code was
> incrementing it the wrong amount).
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


