Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1490663534-30177-1-git-send-email-hyuk0512.lee@samsung.com>
References: <CGME20170328011217epcas5p22d24014478494faeb29c66c21cd21fb2@epcas5p2.samsung.com>
 <1490663534-30177-1-git-send-email-hyuk0512.lee@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 28 Mar 2017 16:35:32 +0300
Message-ID: <CABBYNZK4_Z3KKwwX+7XaWXygYM1kOc6YbY_SQDR=kYazm_fP9Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools: Fix the sock handle leak
To: Lee Hyuk <hyuk0512.lee@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 28, 2017 at 4:12 AM,  <hyuk0512.lee@samsung.com> wrote:
> From: Lee Hyuk <hyuk0512.lee@samsung.com>
>
> This patch adds function "close" for fixing the socket handle leak.
> ---
>  tools/rfcomm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/rfcomm.c b/tools/rfcomm.c
> index 809c240..03359be 100644
> --- a/tools/rfcomm.c
> +++ b/tools/rfcomm.c
> @@ -310,6 +310,7 @@ static void cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **arg
>
>                 if (setsockopt(sk, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
>                         perror("Can't set linger option");
> +                       close(sk);
>                         return;
>                 }
>         }
> --
> 1.9.1

I can probably guess where this is coming from, a static analyzer,
well guess what if the process exits right away all the fd opened are
closed so this is most likely useless.

-- 
Luiz Augusto von Dentz
