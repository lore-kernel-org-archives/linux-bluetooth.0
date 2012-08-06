Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Aug 2012 15:16:12 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] Bluetooth: Refactor in hci_le_conn_complete_evt
Message-ID: <20120806181612.GB3146@joana>
References: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
 <1343412616-25641-7-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343412616-25641-7-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-07-27 15:10:16 -0300]:

> This patch moves the hci_conn check to begining of hci_le_conn_
> complete_evt in order to improve code's readability and better
> error handling.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)

All seven patches have been applied to bluetooth-next, Thanks.

	Gustavo
