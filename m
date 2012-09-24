Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Sep 2012 12:06:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 05/18] oob: Allow to register pairing complete callback
Message-ID: <20120924090626.GB19184@x220>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
 <1348230995-8967-6-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348230995-8967-6-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Sep 21, 2012, Szymon Janc wrote:
> --- a/src/mgmt.c
> +++ b/src/mgmt.c
> @@ -1193,6 +1193,7 @@ static void pair_device_complete(int sk, uint16_t index, uint8_t status,
>  	info = &controllers[index];
>  
>  	bonding_complete(info, &rp->addr.bdaddr, status);
> +	oob_pairing_complete(&info->bdaddr, &rp->addr.bdaddr, status);
>  }

Can't we be a bit smarter than always notifying the oob code. Don't we
e.g. have the possibility to look at the IO capabilities used in the
pairing process or some other means from which we can conclude that this
was an OOB-based pairing that completed?

Johan
