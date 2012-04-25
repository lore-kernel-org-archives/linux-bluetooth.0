Return-Path: <cyrus@holtmann.org>
Message-ID: <1335336245.16897.408.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Remove useless code in hci_connect
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 25 Apr 2012 08:44:05 +0200
In-Reply-To: <1335294671-25585-1-git-send-email-andre.guedes@openbossa.org>
References: <1335294671-25585-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch removes unneeded variable assignments in hci_connect.
> 'sec_level' is already assigned to BT_SECURITY_LOW in hci_le_connect
> and 'pending_sec_level' and 'auth_type' are assigned right after
> if statement.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c |    3 ---
>  1 file changed, 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


