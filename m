Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1410211320-16111-1-git-send-email-roylee@paypal.com>
References: <1410211320-16111-1-git-send-email-roylee@paypal.com>
Date: Mon, 15 Sep 2014 10:00:34 +0300
Message-ID: <CABBYNZ+d0B1ecR1P328=X6+PVOHGuMQFV9Es82_-uDBP=b1TMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] tools: Fix usage for hciattach command
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: roylee17@gmail.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 9, 2014 at 12:21 AM,  <roylee17@gmail.com> wrote:
> From: Tzu-Jung Lee <roylee17@gmail.com>
>
> ---
>  tools/hciattach.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/hciattach.c b/tools/hciattach.c
> index 1904ac5..542b5b3 100644
> --- a/tools/hciattach.c
> +++ b/tools/hciattach.c
> @@ -1276,7 +1276,7 @@ static void usage(void)
>  {
>         printf("hciattach - HCI UART driver initialization utility\n");
>         printf("Usage:\n");
> -       printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
> +       printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [sleep|nosleep] [bdaddr]\n");
>         printf("\thciattach -l\n");
>  }
>
> --
> 2.0.4

It doesn't look like you are doing anything with sleep|nosleep here,
also you should probably a add more information regarding what it is
fixing.

-- 
Luiz Augusto von Dentz
