Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v6 1/4] Bluetooth: Move local identity address setting to a central place
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395685313-26085-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Mar 2014 13:31:35 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0ADEA46A-FAAD-4C68-BB34-2BA52E92046B@holtmann.org>
References: <1395685313-26085-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Any time hci_conn_add is used for an LE connection we need to ensure
> that the local identity address is correctly described in the src and
> src_type variables. This patch moves setting these values directly into
> hci_conn_add so that callers don't have to duplicate the effort
> themselves.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c  |  4 ++++
> net/bluetooth/hci_event.c | 16 ----------------
> 2 files changed, 4 insertions(+), 16 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

