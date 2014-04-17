Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397692238-18642-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397692238-18642-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Thu, 17 Apr 2014 10:04:07 +0300
Message-ID: <CABBYNZ+DFa=sskPm-Wj=-AaNa021WC7=f7-XjUJ02b=c+83h3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] android/a2dp: Prefer master role on incoming connections
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Apr 17, 2014 at 2:50 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> ---
>  android/a2dp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/android/a2dp.c b/android/a2dp.c
> index 4ea16e2..8fb84a3 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -1577,6 +1577,7 @@ bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
>                                 BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
>                                 BT_IO_OPT_PSM, L2CAP_PSM_AVDTP,
>                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> +                               BT_IO_OPT_MASTER, true,
>                                 BT_IO_OPT_INVALID);
>         if (!server) {
>                 error("Failed to listen on AVDTP channel: %s", err->message);
> --
> 1.9.2

Pushed, thanks.


-- 
Luiz Augusto von Dentz
