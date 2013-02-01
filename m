Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2013 15:23:45 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded locking
Message-ID: <20130201172344.GA4733@joana>
References: <1359673930-18226-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359673930-18226-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2013-01-31 20:12:10 -0300]:

> This patch removes unneeded locking in hci_le_adv_report_evt. There
> is no need to lock hdev before calling mgmt_device_found.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 4 ----
>  1 file changed, 4 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
