Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331196259-16010-1-git-send-email-divya.yadav@samsung.com>
References: <1331196259-16010-1-git-send-email-divya.yadav@samsung.com>
Date: Thu, 8 Mar 2012 10:27:51 +0100
Message-ID: <CA+i+Aw1K6xnd0pVssFSsGWy1=AaQYJ=MRvmV-py0NdVGzXS6-A@mail.gmail.com>
Subject: Re: [PATCH obexd 1/3] map_ap.c: Add implementation for map_ap_get*
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Divya Yadav <divya.yadav@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

On Thu, Mar 8, 2012 at 9:44 AM, Divya Yadav <divya.yadav@samsung.com> wrote:
> ---
>  src/map_ap.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 54 insertions(+), 4 deletions(-)
>
> diff --git a/src/map_ap.c b/src/map_ap.c
> index 54e3bcf..dd3ed6b 100644
> --- a/src/map_ap.c
> +++ b/src/map_ap.c
> @@ -246,22 +246,72 @@ uint8_t *map_ap_encode(map_ap_t *ap, size_t *length)
>
>  gboolean map_ap_get_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t *val)
>  {
> -       return FALSE;
> +       struct ap_entry *entry;
> +       int offset = find_ap_def_offset(tag);
> +
> +       if (offset < 0 || ap_defs[offset].type != APT_UINT8)
> +               return FALSE;
> +
> +       entry = g_hash_table_lookup(ap, GINT_TO_POINTER(tag));
> +
> +       if (!entry)
> +               return FALSE;
> +
> +       *val = entry->val.u8;
> +
> +       return TRUE;
>  }
>
>  gboolean map_ap_get_u16(map_ap_t *ap, enum map_ap_tag tag, uint16_t *val)
>  {
> -       return FALSE;
> +       struct ap_entry *entry;
> +       int offset = find_ap_def_offset(tag);
> +
> +       if (offset < 0 || ap_defs[offset].type != APT_UINT16)
> +               return FALSE;
> +
> +       entry = g_hash_table_lookup(ap, GINT_TO_POINTER(tag));
> +
> +       if (!entry)
> +               return FALSE;
> +
> +       *val = entry->val.u16;
> +
> +       return TRUE;
>  }
>
>  gboolean map_ap_get_u32(map_ap_t *ap, enum map_ap_tag tag, uint32_t *val)
>  {
> -       return FALSE;
> +       struct ap_entry *entry;
> +       int offset = find_ap_def_offset(tag);
> +
> +       if (offset < 0 || ap_defs[offset].type != APT_UINT32)
> +               return FALSE;
> +
> +       entry = g_hash_table_lookup(ap, GINT_TO_POINTER(tag));
> +
> +       if (!entry)
> +               return FALSE;
> +
> +       *val = entry->val.u32;
> +
> +       return TRUE;
>  }
>
>  const char *map_ap_get_string(map_ap_t *ap, enum map_ap_tag tag)
>  {
> -       return NULL;
> +       struct ap_entry *entry;
> +       int offset = find_ap_def_offset(tag);
> +
> +       if (offset < 0 || ap_defs[offset].type != APT_STR)
> +               return NULL;
> +
> +       entry = g_hash_table_lookup(ap, GINT_TO_POINTER(tag));
> +
> +       if (!entry)
> +               return NULL;
> +
> +       return g_strdup(entry->val.str);
>  }
>
>  gboolean map_ap_set_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t val)

Well, those are obviously quite right, as those are copies of
appropriate map_ap_set_* functions made by me, with the logic reversed
for reading. So almost exactly identical to what I have done already
and what I would send is some next series of patches (but now another
series are waiting to accepted). The only difference is that I do not
strdup string value in map_ap_get_string(), because there's no point
in it.

Patch no 2 is not how I did this and how I like it to be done.
Especially ugly are the checks for parameters presence performed
inside get and puts functions by string comparing MIME types. Those
comparison is already done for selecting mime driver so parameter
verification can be done in appropriate functions for those drivers.
So in this case e.g. in your message_status_open().

I don't know how this could work. I told you already that I also have
a code for setting message statuses or message parsing and uploading
and this will come next when browsing is fully accepted upstream. So
what is the point of reinventing the wheel, i.e. rewriting what is
already written and waiting to be upstreamed?

> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Slawomir Bochenski
