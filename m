Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1419920868-4637-1-git-send-email-s.syam@samsung.com>
References: <1419920868-4637-1-git-send-email-s.syam@samsung.com>
Date: Thu, 8 Jan 2015 01:34:43 +0530
Message-ID: <CAFBvHifqO=3F0HdewPO1j0v5g=-N25CW_9+3mnef7nFdJPeqVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/bluemoon: Remove dead code
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 30, 2014 at 11:57 AM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> return statement never get executed after goto.
> ---
>  tools/bluemoon.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/bluemoon.c b/tools/bluemoon.c
> index 1fd516a..663d1f9 100644
> --- a/tools/bluemoon.c
> +++ b/tools/bluemoon.c
> @@ -776,7 +776,6 @@ static void analyze_firmware(const char *path)
>         if (len != st.st_size) {
>                 fprintf(stderr, "Failed to read complete firmware file\n");
>                 goto done;
> -               return;
>         }
>
>         if ((size_t) len < sizeof(*css)) {
> --

ping
