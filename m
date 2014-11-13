Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415893972-18656-4-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415893972-18656-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1415893972-18656-4-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 13 Nov 2014 16:58:09 +0100
Message-ID: <CAMudyAsX05tvKnXCKh2ZjZQDSRJsnpMHiSDe43AHtf-OJPLmyg@mail.gmail.com>
Subject: Re: [PATCH 3/3] android/handsfree: Remove find default device
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 13 November 2014 16:52, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Now when Android provide bdaddr in all hfp calls we can remove
> find_defaul_device. We can use bdaddr to find device on the device
> queue.
> ---

Ignore this patch. Just realized that we need this for kitkat support

\Lukasz

>  android/handsfree.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/android/handsfree.c b/android/handsfree.c
> index 9bb8f43..2c7d53d 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -273,13 +273,6 @@ static void device_destroy(struct hf_device *dev)
>         free(dev);
>  }
>
> -static struct hf_device *find_default_device(void)
> -{
> -       /* TODO should be replaced by find_device() eventually */
> -
> -       return queue_peek_head(devices);
> -}
> -
>  static bool match_by_bdaddr(const void *data, const void *match_data)
>  {
>         const struct hf_device *dev = data;
> @@ -290,8 +283,6 @@ static bool match_by_bdaddr(const void *data, const void *match_data)
>
>  static struct hf_device *find_device(const bdaddr_t *bdaddr)
>  {
> -       if (!bacmp(bdaddr, BDADDR_ANY))
> -               return find_default_device();
>
>         return queue_find(devices, match_by_bdaddr, bdaddr);
>  }
> --
> 1.8.4
>
