Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329743814-7172-1-git-send-email-divya.yadav@samsung.com>
References: <1329743814-7172-1-git-send-email-divya.yadav@samsung.com>
Date: Mon, 20 Feb 2012 15:39:55 +0200
Message-ID: <CABBYNZKT=yrqPbM4-ayOfagq6tWJqb8xnaB7FoG42pmn5LMo+w@mail.gmail.com>
Subject: Re: [PATCH obexd] Obexd: Add parse apparam support to Obex Put
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Divya Yadav <divya.yadav@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Divya,

On Mon, Feb 20, 2012 at 3:16 PM, Divya Yadav <divya.yadav@samsung.com> wrote:
> Add parse apparam support to Obex put, which is missing in
> current code.
> ---
>  src/obex.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/src/obex.c b/src/obex.c
> index 5b580d3..f9b7e22 100644
> --- a/src/obex.c
> +++ b/src/obex.c
> @@ -978,6 +978,7 @@ static void cmd_put(GObex *obex, GObexPacket *req, gpointer user_data)
>        parse_name(os, req);
>        parse_length(os, req);
>        parse_time(os, req);
> +       parse_apparam(os, req);
>
>        if (!os->checked) {
>                if (!check_put(obex, req, user_data))
> --
> 1.7.0.4

Please use "core:" prefix when the patch changes code in src/, btw if
there are plugins depending on this than it is a real fix and you
should start with "core: Fix..." otherwise Im fine with the patch even
if nobody uses apparam for PUT.

-- 
Luiz Augusto von Dentz
