Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386602049-5533-2-git-send-email-szymon.janc@tieto.com>
References: <1386602049-5533-1-git-send-email-szymon.janc@tieto.com>
	<1386602049-5533-2-git-send-email-szymon.janc@tieto.com>
Date: Tue, 10 Dec 2013 16:13:12 +0200
Message-ID: <CABBYNZKY01yuTDq_LmDMvFAHyfGjY5NJFJEQzVK1-CxvmpAp_Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] android/bluetooth: Use single list for device caching
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> @@ -809,20 +778,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>                 return;
>         }
>
> -       if (!g_slist_find_custom(found_devices, bdaddr, bdaddr_cmp)) {
> -               bdaddr_t *new_bdaddr;
> -               char addr[18];
> -
> -               new_bdaddr = g_new0(bdaddr_t, 1);
> -               bacpy(new_bdaddr, bdaddr);
> -
> -               found_devices = g_slist_prepend(found_devices, new_bdaddr);
> -
> -               ba2str(new_bdaddr, addr);
> -               DBG("New device found: %s", addr);
> -
> -               new_dev = true;
> -       }
> +       new_dev = !g_slist_find_custom(devices, bdaddr, bdaddr_cmp);
> +       dev = get_device(bdaddr);

This is not very efficient since get_device does the lookup again you
might want to use what g_slist_find_custom return or split get_device
internally in 2 e.g. find_device and create_device which can be used
by get_device or separately.

-- 
Luiz Augusto von Dentz
