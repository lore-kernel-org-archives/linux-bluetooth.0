Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
References: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Sep 2016 17:09:19 +0300
Message-ID: <CABBYNZJHQ+svovaHQ_C13Wjq1bLgdrX=8p16GP4PT0QHg+o05w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] core/device: Load stored attributes before
 initializing GATT client
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 12, 2016 at 5:07 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> During gatt_client_init service are requested to accept the connection
> which may leads the driver to check existence of attributes.
> ---
>  src/device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index fd928fc..73bcc8f 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4823,12 +4823,12 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
>         dst = device_get_address(dev);
>         ba2str(dst, dstaddr);
>
> -       gatt_client_init(dev);
> -       gatt_server_init(dev, btd_gatt_database_get_db(database));
> -
>         if (gatt_db_isempty(dev->db))
>                 load_gatt_db(dev, srcaddr, dstaddr);
>
> +       gatt_client_init(dev);
> +       gatt_server_init(dev, btd_gatt_database_get_db(database));
> +
>         /*
>          * Remove the device from the connect_list and give the passive
>          * scanning another chance to be restarted in case there are
> --
> 2.7.4

Applied.


-- 
Luiz Augusto von Dentz
