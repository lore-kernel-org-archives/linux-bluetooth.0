Return-Path: <cyrus@holtmann.org>
Message-ID: <1324625860.1965.236.camel@aeonflux>
Subject: Re: [PATCH-v1 1/1] Bluetooth: Incorrect address while storing LTK.
From: Marcel Holtmann <marcel@holtmann.org>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Date: Thu, 22 Dec 2011 23:37:40 -0800
In-Reply-To: <1324618644-17551-2-git-send-email-hemant.gupta@stericsson.com>
References: <1324618644-17551-1-git-send-email-hemant.gupta@stericsson.com>
	 <1324618644-17551-2-git-send-email-hemant.gupta@stericsson.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

> This patch fixes incorrect address storage while storing
> Long Term Key for LE Devices using SMP (Security Manager Protocol).
> The address stored should be of remote device and not of source device.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/smp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


