Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Sep 2013 14:30:55 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Bluetooth: Add new mgmt_set_advertising command
Message-ID: <20130925173055.GA27476@joana>
References: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com>
 <1380104770-8022-8-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380104770-8022-8-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2013-09-25 johan.hedberg@gmail.com <johan.hedberg@gmail.com>:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds a new mgmt command for enabling and disabling
> LE advertising. The command depends on the LE setting being enabled
> first and will return a "rejected" response otherwise. The patch also
> adds safeguards so that there will ever only be one set_le or
> set_advertising command pending per adapter.
> 
> The response handling and new_settings event sending is done in an
> asynchronous request callback, meaning raw HCI access from user space to
> enable advertising (e.g. hciconfig leadv) will not trigger the
> new_settings event. This is intentional since trying to support mixed
> raw HCI and mgmt access would mean adding extra state tracking or new
> helper functions, essentially negating the benefit of using the
> asynchronous request framework. The HCI_LE_ENABLED and HCI_LE_PERIPHERAL
> flags however are updated correctly even with raw HCI access so this
> will not completely break subsequent access over mgmt.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |  2 +
>  net/bluetooth/mgmt.c         | 97 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 98 insertions(+), 1 deletion(-)

All patches have been applied to bluetooth-next. Thanks.

	Gustavo
