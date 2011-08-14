Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313162877-14945-2-git-send-email-frederic.dalleau@linux.intel.com>
References: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1313162877-14945-2-git-send-email-frederic.dalleau@linux.intel.com>
Date: Sun, 14 Aug 2011 19:42:38 +0300
Message-ID: <CABBYNZLd2bvbKM3XLvNcJ1t6AusPxm4HjKLmT_fp0vyJznD16g@mail.gmail.com>
Subject: Re: [PATCH 1/7] Add missing call to headset_remove_state_cb
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/12 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> ---
>  audio/device.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/audio/device.c b/audio/device.c
> index 18e873e..f61ef0f 100644
> --- a/audio/device.c
> +++ b/audio/device.c
> @@ -702,6 +702,9 @@ void audio_device_unregister(struct audio_device *device)
>  {
>        unix_device_removed(device);
>
> +       if (headset_callback_id != 0)
> +               headset_remove_state_cb(headset_callback_id);
> +
>        if (device->hs_preauth_id) {
>                g_source_remove(device->hs_preauth_id);
>                device->hs_preauth_id = 0;
> --
> 1.7.1
>

I don't think the callback is per-device, notice that it doesn't take
a device pointer, so if you got a problem with that it is basically
because the callback needs to check what device it is about (see
media.c as a reference)


-- 
Luiz Augusto von Dentz
