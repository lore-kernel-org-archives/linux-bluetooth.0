Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1370865307-7433-1-git-send-email-gustavo@padovan.org>
References: <1370865307-7433-1-git-send-email-gustavo@padovan.org>
Date: Mon, 17 Jun 2013 14:03:11 +0300
Message-ID: <CABBYNZJqRvRz8VBU5rDckfzmxb-U1PLNrVwuFh3WwJ0N9E=scQ@mail.gmail.com>
Subject: Re: [PATCH] device: fix reporting of Connected state for PAN
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Emilio Pozuelo Monfort <emilio.pozuelo@collabora.co.uk>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Jun 10, 2013 at 2:55 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> The network interface handles the connected state as boolean so we never
> get an intermediate state CONNECTING. The old code was preventing the
> transition from DISCONNECTED to CONNECTED in network to be signaled in
> the Device interface.
> ---
>  src/device.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 57bfc86..34511bd 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4506,10 +4506,20 @@ static void service_state_changed(struct btd_service *service,
>         struct btd_device *device = btd_service_get_device(service);
>         int err = btd_service_get_error(service);
>
> -       if (old_state == BTD_SERVICE_STATE_CONNECTING)
> -               device_profile_connected(device, profile, err);
> -       else if (old_state == BTD_SERVICE_STATE_DISCONNECTING)
> +       switch (new_state) {
> +       case BTD_SERVICE_STATE_CONNECTED:
> +               if (old_state == BTD_SERVICE_STATE_CONNECTING ||
> +                               old_state == BTD_SERVICE_STATE_DISCONNECTED)
> +                       device_profile_connected(device, profile, err);
> +               break;
> +
> +       case BTD_SERVICE_STATE_DISCONNECTED:
>                 device_profile_disconnected(device, profile, err);
> +               break;
> +
> +       default:
> +               break;
> +       }
>  }
>
>  struct btd_service *btd_device_get_service(struct btd_device *dev,
> --
> 1.8.1.4

I believe I fixed a similar problem already thus the problem might be
fixed, but perhaps you want to rebase it and resend as it seems a
cleaner/more readable code.


--
Luiz Augusto von Dentz
