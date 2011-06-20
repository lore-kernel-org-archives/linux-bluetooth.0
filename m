Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308563100-18917-14-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
	<1308563100-18917-14-git-send-email-nami.li@atheros.com>
Date: Mon, 20 Jun 2011 13:10:20 +0300
Message-ID: <BANLkTi==UOvfvgya8UsfTo_kH5dwu1J13A@mail.gmail.com>
Subject: Re: [PATCH obexd 14/14] Fix compile error.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Nami <nami.li@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, haijun@qca.qualcomm.com,
	yongli@qca.qualcomm.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jun 20, 2011 at 12:45 PM, Nami <nami.li@atheros.com> wrote:
> ---
>  test/main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/test/main.c b/test/main.c
> index 37b307c..4bd8e19 100644
> --- a/test/main.c
> +++ b/test/main.c
> @@ -256,7 +256,7 @@ int main(int argc, char *argv[])
>                exit(1);
>        }
>
> -       obex = gw_obex_setup_fd(sk, target, target_len, NULL, &error);
> +       obex = gw_obex_setup_fd(sk, target, target_len, NULL, &error,FDOBEX_MT_STREAM);
>        if (obex == NULL) {
>                fprintf(stderr, "Failed to create OBEX session\n");
>                close(sk);
> --
> 1.7.1
>
> --

Fixes in place please, don't add fixes to code not upstream, git
rebase -i and/or git stash can help you with that.

-- 
Luiz Augusto von Dentz
