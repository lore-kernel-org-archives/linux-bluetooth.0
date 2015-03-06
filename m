Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425476811-25651-1-git-send-email-luiz.dentz@gmail.com>
References: <1425476811-25651-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 6 Mar 2015 15:23:24 +0200
Message-ID: <CABBYNZKSsCAskyfugrqY7NgKKkvy4rYuMdGxhQG1pDQq5Zo2Lg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] android: Remove unused field
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 4, 2015 at 3:46 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> struct avdtp_server is no longer needed.
> ---
>  android/avdtp.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/android/avdtp.c b/android/avdtp.c
> index b8a2147..3e32e57 100644
> --- a/android/avdtp.c
> +++ b/android/avdtp.c
> @@ -376,8 +376,6 @@ struct avdtp {
>
>         uint16_t version;
>
> -       struct avdtp_server *server;
> -
>         guint auth_id;
>
>         GIOChannel *io;
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz
