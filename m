Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Dec 2011 16:55:54 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH-v1 1/1] Bluetooth: Incorrect address while storing LTK.
Message-ID: <20111223185554.GC5287@joana>
References: <1324618644-17551-1-git-send-email-hemant.gupta@stericsson.com>
 <1324618644-17551-2-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324618644-17551-2-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

* Hemant Gupta <hemant.gupta@stericsson.com> [2011-12-23 11:07:24 +0530]:

> This patch fixes incorrect address storage while storing
> Long Term Key for LE Devices using SMP (Security Manager Protocol).
> The address stored should be of remote device and not of source device.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/smp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Patch has been applied, thanks.

	Gustavo
