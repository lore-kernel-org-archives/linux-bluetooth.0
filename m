Return-Path: <cyrus@holtmann.org>
Message-ID: <1328284893.2062.33.camel@aeonflux>
Subject: Re: [PATCHv1 1/2] Bluetooth: Recalculate sched HCI blk/pkt flow ctrl
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 03 Feb 2012 08:01:33 -0800
In-Reply-To: <1328279275-10303-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328279275-10303-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Split HCI scheduling for block and packet flow control.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |   85 ++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 79 insertions(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


