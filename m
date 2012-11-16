Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Nov 2012 10:24:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 8/8] neard: Set device class in device object
Message-ID: <20121116082449.GA10952@x220>
References: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
 <1353000701-16605-8-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1353000701-16605-8-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, Nov 15, 2012, Frédéric Danis wrote:
> This will create a new device object and generate DeviceCreated signal
> ---
>  plugins/neard.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Your commit message doesn't explain why the old object needs to be
removed (imo it shouldn't need to be removed).

The other patches in this set have been applied.

> +	device = adapter_get_device(adapter, remote_address);
> +
>  	/* store OOB data */

Missing check for failed adapter_get_device() return (NULL).

Johan
