Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btwilink: remove DEBUG define
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1430809757-23282-1-git-send-email-leo.yan@linaro.org>
Date: Wed, 13 May 2015 23:01:31 +0200
Cc: linux-bluetooth@vger.kernel.org, Pavan Savoy <pavan_savoy@ti.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org
Message-Id: <7627AAA7-7C83-4C14-B4AD-E448911A257B@holtmann.org>
References: <1430809757-23282-1-git-send-email-leo.yan@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Leo,

> Remove the DEBUG define as the debug code; so can remove mass debug info
> from log buffer when using dmesg.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
> drivers/bluetooth/btwilink.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

