Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 1/8] Bluetooth: Store RSSI for connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399555935-702-2-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Thu, 8 May 2014 08:03:04 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C19FD62F-86E3-4AB6-946A-1DA31581D798@holtmann.org>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com> <1399555935-702-2-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> This patch adds support to store RSSI for connection when reply for
> HCI_Read_RSSI is received.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
> include/net/bluetooth/hci.h      | 10 ++++++++++
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_event.c        | 23 +++++++++++++++++++++++
> 3 files changed, 34 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

