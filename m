Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v12 2/2] Bluetooth: Add restarting to service discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422860875-3966-2-git-send-email-jpawlowski@google.com>
Date: Sun, 1 Feb 2015 23:57:00 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8B856093-8D65-4CFC-B6C3-4D3A89A254C5@holtmann.org>
References: <1422860875-3966-1-git-send-email-jpawlowski@google.com> <1422860875-3966-2-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> When using LE_SCAN_FILTER_DUP_ENABLE, some controllers would send
> advertising report from each LE device only once. That means that we
> don't get any updates on RSSI value, and makes Service Discovery very
> slow. This patch adds restarting scan when in Service Discovery, and
> device with filtered uuid is found, but it's not in RSSI range to send
> event yet. This way if device moves into range, we will quickly get RSSI
> update.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/mgmt.c             | 53 ++++++++++++++++++++++++++++++++++++----
> 2 files changed, 49 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

