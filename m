Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH ] tools/hciconfig: Configure LE adv data flags
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1428315384-4984-1-git-send-email-bharat.panda@samsung.com>
Date: Mon, 6 Apr 2015 10:24:46 -0700
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
Message-Id: <98490C74-4CA7-446A-A024-A270D63F0BA9@holtmann.org>
References: <1428315384-4984-1-git-send-email-bharat.panda@samsung.com>
To: Bharat Panda <bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

> Add support for LE advertisement data flags by adding a new command
> in hciconfig tool "leadvflags".
> 
> LE adv flag values can be refered from CSS 5, section 1.3.2, formats.
> ---
> tools/hciconfig.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 121 insertions(+)

this does not look like a useful addition to me. We have a proper mgmt support for LE advertising and this is just not helpful. You can achieve the same with a hcitool cmd execution. Especially since there is no guarantee that the advertising data will be overwritten by the kernel at any point in time. The kernel can not preserve data injected on HCI from userspace.

Regards

Marcel

