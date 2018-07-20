Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180719183430.9334-1-andrzej.kaczmarek@codecoup.pl>
References: <20180719183430.9334-1-andrzej.kaczmarek@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Jul 2018 13:27:28 +0300
Message-ID: <CABBYNZJy85nkSm9_mMfRv9VHU8En85AQK1Xugj6Lo7rRP_0K-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Allow Ellisys injection when reading from TTY
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Jul 19, 2018 at 9:34 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@codecoup.pl> wrote:
> ---
>  monitor/control.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/monitor/control.c b/monitor/control.c
> index 150bdcc44..1b62001fa 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -1307,6 +1307,8 @@ static void tty_callback(int fd, uint32_t events, void *user_data)
>
>                 btsnoop_write_hci(btsnoop_file, tv, 0, opcode, drops,
>                                         hdr->ext_hdr + hdr->hdr_len, pktlen);
> +               ellisys_inject_hci(tv, 0, opcode, hdr->ext_hdr + hdr->hdr_len,
> +                                       pktlen);
>                 packet_monitor(tv, NULL, 0, opcode,
>                                         hdr->ext_hdr + hdr->hdr_len, pktlen);
>
> --
> 2.18.0

Applied, thanks.

-- 
Luiz Augusto von Dentz
