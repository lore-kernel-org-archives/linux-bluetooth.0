Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH V2] bluetooth: btusb: Fix issue with suspend
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1410030368-23289-1-git-send-email-Larry.Finger@lwfinger.net>
Date: Mon, 8 Sep 2014 18:25:27 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	netdev@vger.kernel.org,
	Champion Chen <champion_chen@realsil.com.cn>
Message-Id: <EE5EAEAA-DA2E-4B0D-B961-8819F958E052@holtmann.org>
References: <1410030368-23289-1-git-send-email-Larry.Finger@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

> Suspend could fail for some platforms because
> btusb_suspend==> btusb_stop_traffic ==> usb_kill_anchored_urbs,
> 
> When btusb_bulk_complete returns before system suspend and resubmits an urb,
> the system cannot enter suspend state.
> 
> Signed-off-by: Champion Chen <champion_chen@realsil.com.cn>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> V2 - Fix incorrect test as noted by Marcel.
> 
> ---
> Johan,
> 
> To help Champion with the process, I have formatted the patch in
> the correct manner. I hope I understand the issue correctly and
> stated it in a coherent manner in the commit message.
> 
> Larry
> ---
> drivers/bluetooth/btusb.c | 9 +++++++++
> 1 file changed, 9 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

