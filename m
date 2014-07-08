Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix connectable and discoverable supported settings values
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404824854-1358-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 8 Jul 2014 15:12:40 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D58B7D54-E90E-4C3F-90B3-912096549FED@holtmann.org>
References: <1404824854-1358-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The connectable and discoverable mgmt settings are supported both for LE
> and BR/EDR controllers so they do not belong behind a lmp_bredr_capable()
> condition. This patch fixes the issue in get_supported_settings().
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

