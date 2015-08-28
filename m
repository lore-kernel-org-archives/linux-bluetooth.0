Return-Path: <cyrus@holtmann.org>
Message-ID: <55E08AE0.2040900@intel.com>
Date: Fri, 28 Aug 2015 18:22:56 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: marcel@holtmann.org
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_intel: Retrieve host-wake IRQ
References: <1440778843-29860-1-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1440778843-29860-1-git-send-email-loic.poulain@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>



On 28/08/2015 18:20, Loic Poulain wrote:
> An IRQ can be retrieved from the pdev resources. This irq will be used
> in case of LPM suspend mode to wake-up the host and resume the link.
> This resource can be declared as a GPIO-Interrupt which requires to be
> converted into IRQ.
>
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
>   drivers/bluetooth/hci_intel.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 61 insertions(+), 1 deletion(-)
>
v2: move irq claim into set_power

-- 
Intel Open Source Technology Center
http://oss.intel.com/
