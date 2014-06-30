Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC v2 1/4] Bluetooth: Connection parameters check helper
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403743975-31114-1-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 30 Jun 2014 17:43:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CFA7C547-35F2-44B2-8E73-0AFEF57B2EFC@holtmann.org>
References: <1403743975-31114-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch renames l2cap_check_conn_param() to hci_check_conn_params()
> and moves it to hci_core.h so it can reused in others files. This helper
> will be reused in the next patch.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h | 21 +++++++++++++++++++++
> net/bluetooth/l2cap_core.c       | 23 +----------------------
> 2 files changed, 22 insertions(+), 22 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

