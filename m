Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] bluetooth: btrtl: Change message for missing config file
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170220020457.577-1-Larry.Finger@lwfinger.net>
Date: Mon, 27 Mar 2017 16:27:53 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <582A264E-0FFC-4266-9DDF-A9E5C8EED160@holtmann.org>
References: <20170220020457.577-1-Larry.Finger@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

> The message concerning missing config files for 8723b, 8821a, and
> 8761a should have been issued with BT_INFO() rather than BT_ERR() as
> this condition is not fatal. After looking at that code, I have
> reworked the logic to log such messages only if the device needs such a
> config file. At the moment, only the 8822b fits that description.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> Acked-by: 陆朱伟 <alex_lu@realsil.com.cn>
> ---
> drivers/bluetooth/btrtl.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

