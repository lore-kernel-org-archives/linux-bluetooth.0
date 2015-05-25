Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btusb: fix Realtek suspend/resume
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432218230-11370-1-git-send-email-drake@endlessm.com>
Date: Mon, 25 May 2015 21:07:10 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>, carlo@endlessm.com,
	Larry.Finger@lwfinger.net, champion_chen@realsil.com.cn
Message-Id: <4A0E5411-A69D-4FB5-B618-A4BECE282562@holtmann.org>
References: <1432218230-11370-1-git-send-email-drake@endlessm.com>
To: Daniel Drake <drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> Realtek btusb devices don't currently work after suspend/resume because
> the updated firmware is quietly lost - the USB hub doesn't notice any
> status change upon resume, but some kind of reset has definitely
> happened as the LMP subversion has reverted to its original value.
> 
> Set the reset_resume flag to trigger probe and upload the new firmware
> again.
> 
> Like the vendor code, I assume this is not needed when the device is
> selected as a wakeup source and hence will retain power during suspend.
> On the 2 products I have to hand, when trying this configuration the
> hardware seems unable to keep the device powered up during suspend.
> The USB hub then detects a status change on resume and does a reset,
> so we do not end up in broken state.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
> drivers/bluetooth/btusb.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

