Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Mar 2013 17:13:40 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 6/6] Bluetooth: Check req->err in hci_req_add
Message-ID: <20130309201340.GA9938@joana>
References: <1362752418-8688-1-git-send-email-andre.guedes@openbossa.org>
 <1362752418-8688-6-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362752418-8688-6-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2013-03-08 11:20:18 -0300]:

> If req->err is set, there is no point in queueing the HCI command
> in HCI request command queue since it won't be sent anyway.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> Acked-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)

All patches have been applied to bluetooth-next. Thanks.

	Gustavo
