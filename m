Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389960506-10273-3-git-send-email-ncopa@alpinelinux.org>
References: <1389960506-10273-1-git-send-email-ncopa@alpinelinux.org>
	<1389960506-10273-3-git-send-email-ncopa@alpinelinux.org>
Date: Fri, 17 Jan 2014 16:37:15 +0200
Message-ID: <CABBYNZ+LYk1c0YUU0==JyKxJ_SbX6nNbcpwRCd==HUV1CKx+Ow@mail.gmail.com>
Subject: Re: [PATCH 3/3] unit: prevent use of glibc's error(3)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Natanael Copa <natanael.copa@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Natanael Copa <ncopa@alpinelinux.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natanael,

On Fri, Jan 17, 2014 at 2:08 PM, Natanael Copa <natanael.copa@gmail.com> wrote:
> When building the test-sdp we don't want src/sdpd-request.c end up
> using the incompatible GNU libc's error(3).
>
> This also fixes building on musl libc which misses the error(3) GNU
> extension.
> ---
>  unit/test-sdp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/unit/test-sdp.c b/unit/test-sdp.c
> index 6d699e2..eeed0cb 100644
> --- a/unit/test-sdp.c
> +++ b/unit/test-sdp.c
> @@ -134,6 +134,12 @@ void btd_debug(const char *format, ...)
>  {
>  }
>
> +void error(const char *format, ...);
> +
> +void error(const char *format, ...)
> +{
> +}
> +
>  static void context_quit(struct context *context)
>  {
>         g_main_loop_quit(context->main_loop);
> --
> 1.8.5.3

We could perhaps do the same thing we did in test-avdtp.c, build with
log support and add the following check:

if (g_test_verbose())
__btd_log_init("*", 0);


-- 
Luiz Augusto von Dentz
