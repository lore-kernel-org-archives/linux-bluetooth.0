Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426583744-10750-1-git-send-email-hychao@chromium.org>
References: <1426583744-10750-1-git-send-email-hychao@chromium.org>
Date: Tue, 17 Mar 2015 17:47:16 +0200
Message-ID: <CABBYNZKc3fsrp1bga5dYALr-FAhJjBFKqQydSefsN5U1KWFY0A@mail.gmail.com>
Subject: Re: [PATCH] audio/avdtp: Fix crash at NULL cb of discover_callback
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arman Uguray <armansito@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 17, 2015 at 11:15 AM, Hsin-Yu Chao <hychao@chromium.org> wrote:
> This fixes a crash with below trace that a discover_callback
> object has a NULL cb function pointer being triggered, which
> may due to an error happened in avdtp_discover() and left it
> unset.
>
> 0x00000000 in ?? ()
> 0xb6f5606e in finalize_discovery (err=22, session=0xb7514a00)
>   at profiles/audio/avdtp.c:1043
> connection_lost (session=session@entry=0xb7514a00, err=err@entry=22)
>   at profiles/audio/avdtp.c:1143
> 0xb6f57cf6 in avdtp_connect_cb (chan=<optimized out>, err=0xb7514410,
>   user_data=0xb7514a00) at profiles/audio/avdtp.c:2373
> 0xb6f723e4 in accept_cb (io=0xb7516a10, cond=<optimized out>,
>   user_data=0xb7516b48) at btio/btio.c:203
> 0xb6e6cf10 in ?? ()
> ---
>  profiles/audio/avdtp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 4be2d25..f38188f 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1033,7 +1033,8 @@ static void finalize_discovery(struct avdtp *session, int err)
>         if (discover->id > 0)
>                 g_source_remove(discover->id);
>
> -       discover->cb(session, session->seps, err ? &avdtp_err : NULL,
> +       if (discover->cb)
> +               discover->cb(session, session->seps, err ? &avdtp_err : NULL,
>                                                         discover->user_data);
>         g_free(discover);
>         session->discover = NULL;
> --
> 2.2.0.rc0.207.ga3a616c

Applied, thanks.


-- 
Luiz Augusto von Dentz
