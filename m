Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 17:59:35 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] Bluetooth: Disallow LE scanning and connecting in
 peripheral role
Message-ID: <20121024195935.GA3030@joana>
References: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
 <1351102323-4654-8-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351102323-4654-8-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-10-24 21:12:03 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When an adapter is in the LE peripheral role scanning for other devices
> or initiating connections to them is not allowed. This patch makes sure
> that such attempts will result in appropriate error returns.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_conn.c |    3 +++
>  net/bluetooth/hci_core.c |    3 +++
>  2 files changed, 6 insertions(+)

All 7 patches have been applied  to bluetooth-next. Thanks.

	Gustavo
