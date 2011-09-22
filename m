Return-Path: <cyrus@holtmann.org>
Message-ID: <002f01cc78fa$f27c95f0$2947dd0a@ALEXM>
From: <alexvm12e@mail.ru>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <E1R47Z5-0000QH-00.alexvm12e-mail-ru@f167.mail.ru><CABBYNZJzJPf1KYVpDJvr_UO722DTYzRV0vG6X7OnUHZVK8aq_A@mail.gmail.com><1E0C6F4C3D9940BA8E8D3BA2FC16B573@alexm> <CABBYNZ+hXiRQv7KesdgX790wWPabYXvUecq0D=2PjgmVEWTL2A@mail.gmail.com>
Subject: Re: obexd: obex_handle_input: poll event HUP ERR
Date: Thu, 22 Sep 2011 00:40:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Luiz,


> Can you try the following:

> diff --git a/src/obex.c b/src/obex.c
> index d8f4648..7b68814 100644
> --- a/src/obex.c
> +++ b/src/obex.c
> @@ -985,6 +985,7 @@ static gboolean check_put(obex_t *obex, obex_object_t 
> *obj)
>        unsigned int hlen;
>        uint8_t hi;
>        int ret;
> +       GError *err = NULL;
>
>        os = OBEX_GetUserData(obex);
>
> @@ -1010,7 +1011,12 @@ static gboolean check_put(obex_t *obex,
> obex_object_t *obj)
>                                continue;
>
>                        os->name = g_convert((const char *) hd.bs, hlen,
> -                                       "UTF8", "UTF16BE", NULL, NULL, NULL);
> +                                       "UTF8", "UTF16BE", NULL, NULL, &err);
> +                       if (err) {
> +                               error("%s", err->message);
> +                               g_error_free(err);
> +                       }
> +
>                        DBG("OBEX_HDR_NAME: %s", os->name);
>                        break;

obexd[844]: Conversion from character set 'UTF16BE' to 'UTF8' is not supported

As I understood this is a glib problem not obexd. Thanks for your help.

Alex. 

