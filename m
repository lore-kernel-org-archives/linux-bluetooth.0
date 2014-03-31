Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1396013919-15122-1-git-send-email-luiz.dentz@gmail.com>
References: <1396013919-15122-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 31 Mar 2014 11:02:45 +0300
Message-ID: <CABBYNZ+eVt4JsqyjbNG-Y1Ad3f-uhm6md3TBbubRTt5gbg_+OA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] gobex/header: Add g_obex_header_new_tag function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 28, 2014 at 3:38 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This function can be used to set tag using GObexApparam as argument but
> for arbritary headers.
> ---
>  gobex/gobex-header.c | 9 +++++++--
>  gobex/gobex-header.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
> index 281f8ea..fe70c8b 100644
> --- a/gobex/gobex-header.c
> +++ b/gobex/gobex-header.c
> @@ -425,7 +425,7 @@ GObexHeader *g_obex_header_new_bytes(guint8 id, const void *data, gsize len)
>         return header;
>  }
>
> -GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam)
> +GObexHeader *g_obex_header_new_tag(guint8 id, GObexApparam *apparam)
>  {
>         guint8 buf[1024];
>         gssize len;
> @@ -434,7 +434,12 @@ GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam)
>         if (len < 0)
>                 return NULL;
>
> -       return g_obex_header_new_bytes(G_OBEX_HDR_APPARAM, buf, len);
> +       return g_obex_header_new_bytes(id, buf, len);
> +}
> +
> +GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam)
> +{
> +       return g_obex_header_new_tag(G_OBEX_HDR_APPARAM, apparam);
>  }
>
>  GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val)
> diff --git a/gobex/gobex-header.h b/gobex/gobex-header.h
> index 42a2a0c..c2f975f 100644
> --- a/gobex/gobex-header.h
> +++ b/gobex/gobex-header.h
> @@ -85,6 +85,7 @@ GObexHeader *g_obex_header_new_unicode(guint8 id, const char *str);
>  GObexHeader *g_obex_header_new_bytes(guint8 id, const void *data, gsize len);
>  GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val);
>  GObexHeader *g_obex_header_new_uint32(guint8 id, guint32 val);
> +GObexHeader *g_obex_header_new_tag(guint8 id, GObexApparam *apparam);
>  GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam);
>
>  GSList *g_obex_header_create_list(guint8 first_hdr_id, va_list args,
> --
> 1.8.5.3

Please hold on reviewing this set since I found a problem with it.


-- 
Luiz Augusto von Dentz
