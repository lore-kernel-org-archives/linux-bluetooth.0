Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1410785956-6887-1-git-send-email-gowtham.ab@samsung.com>
References: <1410785956-6887-1-git-send-email-gowtham.ab@samsung.com>
Date: Mon, 15 Sep 2014 16:03:49 +0300
Message-ID: <CABBYNZL0NCd3o0_oXmW=TQw1MGoRkSJ9zBQRwULSD1zn7G-XCA@mail.gmail.com>
Subject: Re: [PATCH] obexd/client/map: Check msg value is valid
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 15, 2014 at 3:59 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Checks for the NULL msg-value, before passing it to the callback.
> ---
>  obexd/client/map.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 520e492..fb8ebd8 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -1132,7 +1132,8 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
>
>                 for (parser = msg_parsers; parser && parser->name; parser++) {
>                         if (strcasecmp(key, parser->name) == 0) {
> -                               parser->func(msg, values[i]);
> +                               if(values[i])
> +                                       parser->func(msg, values[i]);
>                                 break;
>                         }
>                 }
> --
> 1.9.1

Ive just pushed a similar patch, but thanks anyway.


-- 
Luiz Augusto von Dentz
