Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1365693884-15423-3-git-send-email-jefferson.delfes@openbossa.org>
References: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
	<1365693884-15423-3-git-send-email-jefferson.delfes@openbossa.org>
Date: Thu, 11 Apr 2013 13:41:35 -0400
Message-ID: <CAJdJm_My7fTEfmaUteynUyT5WvxNviPctO8yASR8H86R=fKBjA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] shared: Remove static address assignment in hciemu
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Thu, Apr 11, 2013 at 11:24 AM, Jefferson Delfes
<jefferson.delfes@openbossa.org> wrote:
> diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
> index 60a4f47..8cd6548 100644
> --- a/src/shared/hciemu.c
> +++ b/src/shared/hciemu.c
> @@ -192,20 +192,12 @@ static guint create_source_btdev(int fd, struct btdev *btdev)
>  static bool create_vhci(struct hciemu *hciemu)
>  {
>         struct btdev *btdev;
> -       uint8_t bdaddr[6];
> -       const char *str;
> -       int fd, i;
> +       int fd;
>
>         btdev = btdev_create(hciemu->btdev_type, 0x00);
>         if (!btdev)
>                 return false;
>
> -       str = hciemu_get_address(hciemu);
> -
> -       for (i = 5; i >= 0; i--, str += 3)
> -               bdaddr[i] = strtol(str, NULL, 16);
> -
> -       btdev_set_bdaddr(btdev, bdaddr);

Looks like you can remove btdev_set_bdaddr() (in a patch after this
one) because it was the only user of this function.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
