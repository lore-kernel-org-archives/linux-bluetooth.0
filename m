Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 19:08:14 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH] Bluetooth: Fix missing break in hci_cmd_complete_evt
Message-ID: <20120413220814.GE1680@joana>
References: <1334313162-12290-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334313162-12290-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2012-04-13 12:32:42 +0200]:

> Command complete event for HCI_OP_USER_PASSKEY_NEG_REPLY would result
> in calling handler function also for HCI_OP_LE_SET_SCAN_PARAM. This
> could result in undefined behaviour.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/hci_event.c |    1 +
>  1 file changed, 1 insertion(+)

Applied to both bluetooth and bluetooth-next trees. Thanks.

	Gustavo
