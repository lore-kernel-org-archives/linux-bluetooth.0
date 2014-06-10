Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix check for connection encryption
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402383264-24508-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Jun 2014 11:16:00 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7EDA2AF9-4170-4457-9963-5F4EF084C5B1@holtmann.org>
References: <1402383264-24508-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The conn->link_key variable tracks the type of link key in use. It is
> set whenever we respond to a link key request as well as when we get a
> link key notification event.
> 
> These two events do not however always guarantee that encryption is
> enabled: getting a link key request and responding to it may only mean
> that the remote side has requested authentication but not encryption. On
> the other hand, the encrypt change event is a certain guarantee that
> encryption is enabled. The real encryption state is already tracked in
> the conn->link_mode variable through the HCI_LM_ENCRYPT bit.
> 
> This patch fixes a check for encryption in the hci_conn_auth function to
> use the proper conn->link_mode value and thereby eliminates the chance
> of a false positive result.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

