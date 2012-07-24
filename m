Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 20:42:05 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove locking in hci_user_passkey_request_evt
Message-ID: <20120724234201.GO20029@joana>
References: <1343078344-22759-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343078344-22759-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-07-23 18:19:04 -0300]:

> This patch removes hdev locking in hci_user_passkey_request_evt
> since it is not needed. mgmt_user_passkey_request simply calls
> mgmt_event which does not require hdev locking at all.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 4 ----
>  1 file changed, 4 deletions(-)

Patch has been applied to bluuetooth-next. Thanks.

	Gustavo
