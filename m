Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: h5: Do not initialize Configuration field
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449759823-12800-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 10 Dec 2015 08:20:20 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7D4052ED-1A6D-4D9A-B37F-12358DAA2006@holtmann.org>
References: <1449759823-12800-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Initializing Configuration field in H5 Config message to 0x01 gives
> wrong impression that the value is used and needed. Later on the whole
> field is rewritten with h5_cfg_field().
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> drivers/bluetooth/hci_h5.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

