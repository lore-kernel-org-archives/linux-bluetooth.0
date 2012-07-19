Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 12:29:28 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove missing code
Message-ID: <20120719152928.GE5141@joana>
References: <1342709173-4967-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342709173-4967-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-07-19 11:46:13 -0300]:

> This patch removes the struct adv_entry since it is not used anymore.
> This struct should have been removed in commit 479453d (Bluetooth:
> Remove advertising cache).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h | 6 ------
>  1 file changed, 6 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
