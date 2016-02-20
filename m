Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: hci_intel: Fix a wrong comparison
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1455124974-27428-1-git-send-email-a.s.protopopov@gmail.com>
Date: Fri, 19 Feb 2016 16:57:25 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <D14C1492-7528-48D2-B63B-F80760A2272F@holtmann.org>
References: <1455124974-27428-1-git-send-email-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anton,

> A return value of the intel_wait_booting() function compared with
> a constant ETIMEDOUT instead of -ETIMEDOUT.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
> drivers/bluetooth/hci_intel.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

