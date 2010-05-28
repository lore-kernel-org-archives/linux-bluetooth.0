Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 May 2010 21:05:19 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [Patch v2 0/3] Bluetooth-Remove-extraneous-white-space.patch
Message-ID: <20100528000519.GA10826@vigoh>
References: <4BFEE8D0.7010306@codeaurora.org>
 <4BFEE93F.3020503@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BFEE93F.3020503@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

The commit titles of your patches are wrong. Use git format-patch and
git send-email to send your patches.

* Ron Shaffer <rshaffer@codeaurora.org> [2010-05-27 16:50:55 -0500]:

> 
> Deleted extraneous white space from the end of several lines

Merge the two patches that remove whitepaces into just one.

> 
> Signed-off-by: Ron Shaffer <rshaffer@codeaurora.org>
> ---
>  include/net/bluetooth/hci_core.h |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e42f6ed..4a664e6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1,4 +1,4 @@
> -/* 
> +/*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>  
> @@ -12,13 +12,13 @@
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
>     IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
> +   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
> +   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> +   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
>     OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>  
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
> +   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> +   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
>     SOFTWARE IS DISCLAIMED.
>  */
>  
> @@ -380,7 +380,7 @@ static inline void __hci_dev_put(struct hci_dev *d)
>  }
>  
>  static inline void hci_dev_put(struct hci_dev *d)
> -{ 
> +{
>  	__hci_dev_put(d);
>  	module_put(d->owner);
>  }
> -- 
> 1.7.0.2
> 
> -- 
> Ron Shaffer
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
