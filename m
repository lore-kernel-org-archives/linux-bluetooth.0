Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380427749-14427-1-git-send-email-marcel@holtmann.org>
References: <1380427749-14427-1-git-send-email-marcel@holtmann.org>
Date: Sun, 29 Sep 2013 08:59:27 -0400
Message-ID: <CAJdJm_Ova_rzJy8pnO2VJRki7N=L=PEk=r=D5Zk1oPDkA=2mOA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Use only 2 bits for controller type information
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 29, 2013 at 12:09 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> The controller type is limited to BR/EDR/LE and AMP controllers. This
> can be easily encoded with just 2 bits and still leave enough room
> for future controller types.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 4549b5c..ebba5a6 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1610,7 +1610,7 @@ int hci_get_dev_info(void __user *arg)
>
>         strcpy(di.name, hdev->name);
>         di.bdaddr   = hdev->bdaddr;
> -       di.type     = (hdev->bus & 0x0f) | (hdev->dev_type << 4);
> +       di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x30) << 4);

Shouldn't it be (hdev->dev_type & 0x03) here?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
