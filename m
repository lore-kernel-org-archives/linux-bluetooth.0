Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 10:19:07 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Silence sparse warning
Message-ID: <20120320131907.GA20722@joana>
References: <1332232345-30828-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332232345-30828-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-20 10:32:25 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Silence sparse warning shown below:
> ...
> net/bluetooth/mgmt.c:448:15: warning: cast to restricted __le32
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/mgmt.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b8f9016..d93f2bf 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -443,9 +443,7 @@ static u16 get_uuid16(u8 *uuid128)
>  			return 0;
>  	}
>  
> -	memcpy(&val, &uuid128[12], 4);
> -
> -	val = le32_to_cpu(val);
> +	val = get_unaligned_le32(&uuid128[12]);
>  	if (val > 0xffff)
>  		return 0;

Patch is applied. Thanks.

Btw, this is the last change in maintainership (until we get the shared tree).
I solved all my internet problems (I was a bit offline last week) and then I'm
back to this task. Sorry for the inconvenience, won't happen again.

	Gustavo
