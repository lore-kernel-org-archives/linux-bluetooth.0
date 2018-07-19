Return-Path: <jaganath.k.os@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1530876485-17218-2-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1530876485-17218-2-git-send-email-jaganathx.kanakkassery@intel.com>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Thu, 19 Jul 2018 15:24:07 +0530
Message-ID: <CAJzH+br11gYoWaBCZxyn2kHuhhVGja0brZbLcHSSiQ5vVc=12Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] monitor: Fix 2-DH5 packet type print
To: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 6, 2018 at 4:57 PM, Jaganath Kanakkassery
<jaganath.k.os@gmail.com> wrote:
> 3-DH5 is printed instaed of 2-DH5
> ---
>  monitor/packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 6798373..bf69859 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -762,7 +762,7 @@ static const struct {
>         {  9, "3-DH3 may not be used"   },
>         { 10, "DM3 may be used"         },
>         { 11, "DH3 may be used"         },
> -       { 12, "3-DH5 may not be used"   },
> +       { 12, "2-DH5 may not be used"   },
>         { 13, "3-DH5 may not be used"   },
>         { 14, "DM5 may be used"         },
>         { 15, "DH5 may be used"         },

This is a bug fix in the existing code and is independent of 5.0 changes.

Thanks,
Jaganath
