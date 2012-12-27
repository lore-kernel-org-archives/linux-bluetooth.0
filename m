Return-Path: <cyrus@holtmann.org>
Message-ID: <1356630354.19248.58.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Update management interface revision
From: Marcel Holtmann <marcel@holtmann.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 27 Dec 2012 09:45:54 -0800
In-Reply-To: <1356615418-4351-2-git-send-email-s.syam@samsung.com>
References: <1356615418-4351-1-git-send-email-s.syam@samsung.com>
	 <1356615418-4351-2-git-send-email-s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> This enable us to introduce a check in user space to know
> whether it's safe to pass non-16bit UUID's to kernel or not.
> Currently the kernel support only 16bit UUID's in the EIR.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NAK. As I said before, I want the kernel to support 32-bit and 128-bit
UUIDs. There is no point in doing a minimal fix. I want to see this
fixed properly.

Regards

Marcel


