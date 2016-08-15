Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1470990389-9434-1-git-send-email-luiz.dentz@gmail.com>
References: <1470990389-9434-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Aug 2016 13:13:19 +0300
Message-ID: <CABBYNZJLhJw2ez_zyi_afjL8VD=KU98j9hfXcA2UkjW-hh+PBg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/device: Fix not connecting services properly
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 12, 2016 at 11:26 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Device.Connect shall check if the service discovery is pending or no
> service have been connected yet before switching to LE otherwise these
> services may never be connected.
> ---
>  src/device.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 6c6be92..c103bb2 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1779,9 +1779,18 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
>         struct btd_device *dev = user_data;
>         uint8_t bdaddr_type;
>
> -       if (dev->bredr_state.connected)
> -               bdaddr_type = dev->bdaddr_type;
> -       else if (dev->le_state.connected && dev->bredr)
> +       if (dev->bredr_state.connected) {
> +               /*
> +                * Check if services have been resolved and there is at list
> +                * one connected before switching to connect LE.
> +                */
> +               if (dev->bredr_state.svc_resolved &&
> +                       find_service_with_state(dev->services,
> +                                               BTD_SERVICE_STATE_CONNECTED))
> +                       bdaddr_type = dev->bdaddr_type;
> +               else
> +                       bdaddr_type = BDADDR_BREDR;
> +       } else if (dev->le_state.connected && dev->bredr)
>                 bdaddr_type = BDADDR_BREDR;
>         else
>                 bdaddr_type = select_conn_bearer(dev);
> --
> 2.7.4

Applied.


-- 
Luiz Augusto von Dentz
