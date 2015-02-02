Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v11 2/2] Bluetooth: Add restarting to service discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422325138-20113-2-git-send-email-jpawlowski@google.com>
Date: Sun, 1 Feb 2015 21:13:57 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F15B3FE9-19A2-44BF-9DE1-137F0993965C@holtmann.org>
References: <1422325138-20113-1-git-send-email-jpawlowski@google.com> <1422325138-20113-2-git-send-email-jpawlowski@google.com>
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

this patch looks good. However I can only apply it once you added the comments to patch 1/2.

I have also run this patch now for a while with out own controllers and all seems to be working as expected. However I would like to see some test cases for mgmt-tester afterwards that ensures it is working correctly.

Regards

Marcel

