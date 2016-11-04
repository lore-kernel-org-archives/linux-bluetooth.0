Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1478203433-37526-1-git-send-email-pgynther@google.com>
References: <1478203433-37526-1-git-send-email-pgynther@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 4 Nov 2016 14:46:14 +0200
Message-ID: <CABBYNZKUR5w4Yt0zF3_+t9DYpbS8hnLXm6hNa22a67Satxa2Wg@mail.gmail.com>
Subject: Re: [PATCH] input/hog: Remove unused attioid from hog_device
To: Petri Gynther <pgynther@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Thu, Nov 3, 2016 at 10:03 PM, Petri Gynther <pgynther@google.com> wrote:
> ---
>  profiles/input/hog.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 9836a6c..7d318cd 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -60,7 +60,6 @@
>  #define HOG_UUID               "00001812-0000-1000-8000-00805f9b34fb"
>
>  struct hog_device {
> -       guint                   attioid;
>         struct btd_device       *device;
>         struct bt_hog           *hog;
>  };
> --
> 2.8.0.rc3.226.g39d4020

Nice catch, applied thanks.

-- 
Luiz Augusto von Dentz
