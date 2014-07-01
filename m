Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: btmrvl: wait for HOST_SLEEP_ENABLE event in suspend
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404248414-23650-1-git-send-email-bzhao@marvell.com>
Date: Tue, 1 Jul 2014 23:24:26 +0200
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Scott James Remnant <keybuk@chromium.org>,
	Chin-Ran Lo <crlo@marvell.com>,
	Jeff CF Chen <jeffc@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Xinming Hu <huxm@marvell.com>
Message-Id: <AB9D03FD-4896-4BEF-BF6D-7BDC314DA344@holtmann.org>
References: <1404248414-23650-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> After BT_CMD_HOST_SLEEP_ENABLE command finishes, driver should
> wait until getting BT_EVENT_HOST_SLEEP_ENABLE event to complete
> suspend procedure.
> Without this patch the suspend handler would return success
> earlier. By the time when the BT_EVENT_HOST_SLEEP_ENABLE event
> comes in the controller driver could have already turned off the
> bus clock. This causes kernel crash or system reboot eventually.
> 
> Cc: <stable@vger.kernel.org> # 3.13+
> Signed-off-by: Chin-Ran Lo <crlo@marvell.com>
> Signed-off-by: Jeff CF Chen <jeffc@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> drivers/bluetooth/btmrvl_drv.h  |  1 +
> drivers/bluetooth/btmrvl_main.c | 25 ++++++++++++++++++++++++-
> 2 files changed, 25 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

