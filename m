Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352811160-12722-1-git-send-email-szymon.janc@tieto.com>
References: <1352811160-12722-1-git-send-email-szymon.janc@tieto.com>
Date: Tue, 13 Nov 2012 15:14:51 +0200
Message-ID: <CABBYNZLR54sQM9VSybJYnBHaPpxD0q6O=TMeymALLHVwzotBLQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] avctp: Fix dead assignment in control_response
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 13, 2012 at 2:52 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Value stored to req is never read before writing it again.
>
> ---
>  audio/avctp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 6ba25e4..29756f6 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -577,7 +577,7 @@ static void control_response(struct avctp_channel *control,
>                                         size_t operand_count)
>  {
>         struct avctp_pending_req *p = control->p;
> -       struct avctp_control_req *req = p->data;
> +       struct avctp_control_req *req;
>         GSList *l;
>
>         if (p && p->transaction == avctp->transaction) {
> --
> 1.7.9.5

Pushed, thanks.


-- 
Luiz Augusto von Dentz
