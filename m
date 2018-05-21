Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1526615864-23577-1-git-send-email-nagaraj.dr@samsung.com>
References: <CGME20180518035758epcas1p180d3cc8c19a1fbdf2819a35d7062804d@epcas1p1.samsung.com>
 <1526615864-23577-1-git-send-email-nagaraj.dr@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 May 2018 11:32:25 +0300
Message-ID: <CABBYNZKYKtPepCw10m8gRT5GKAU9rSgAfgkWrgFdMocsjfHbHg@mail.gmail.com>
Subject: Re: [PATCH] Fix Memory leak
To: Nagaraj D R <nagaraj.dr@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Syam Sidhardhan <s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 18, 2018 at 6:57 AM, Nagaraj D R <nagaraj.dr@samsung.com> wrote:
> Memory associated with 'adv_data' will be leaked in case of
> 'generate_scan_rsp' failure
> ---
>  src/advertising.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 441d0a2..b087b48 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -752,6 +752,7 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
>         scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);
>         if (!scan_rsp && scan_rsp_len) {
>                 error("Scan data couldn't be generated.");
> +               free(adv_data);
>                 return -EINVAL;
>         }
>
> --
> 1.9.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
