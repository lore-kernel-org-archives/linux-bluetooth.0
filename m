Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1274350142-19083-1-git-send-email-sancane@gmail.com>
References: <1274350142-19083-1-git-send-email-sancane@gmail.com>
Date: Thu, 20 May 2010 14:52:34 +0200
Message-ID: <AANLkTimv6CRgS-lPeadePxKXEmNmhEM7oLx-uTHuZfNF@mail.gmail.com>
Subject: Re: [PATCH] Fix device_match_pattern function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, May 20, 2010 at 12:09 PM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> This patch fixes a problem adding uuids to list provided when a
> driver is probed. Without this patch the same uuids were added
> more than once to list and if two or more uuids were in the
> same class id list only the first one was included repeatedly
> ---
>  src/device.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 6ba1612..d0768ce 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1053,7 +1053,7 @@ static GSList *device_match_pattern(struct btd_device *device,
>                        continue;
>
>                if (record_has_uuid(rec, match_uuid))
> -                       uuids = g_slist_append(uuids, profile_uuid);
> +                       uuids = g_slist_append(uuids, match_uuid);
>        }
>
>        return uuids;


It doesn't look right, if we do that the device will be probed by the
matched uuid which would not happen to have a record in the storage.
So in other words the list of uuids you get in the probe may not match
with the one present in the drivers .uuids. Also this would probably
break serial driver, did you tried this before submitting this to the
list?

-- 
Luiz Augusto von Dentz
Computer Engineer
