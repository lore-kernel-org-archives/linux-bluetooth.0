Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326451712-21784-4-git-send-email-lkslawek@gmail.com>
References: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
	<1326451712-21784-4-git-send-email-lkslawek@gmail.com>
Date: Fri, 13 Jan 2012 14:13:24 +0200
Message-ID: <CABBYNZJ7OwbpEDpdSQe8L5tOSVWQhmHVaobudYPLM2WyNFYxjA@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] map_ap.c: Add dumping of map_ap_t after decoding
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawomir,

On Fri, Jan 13, 2012 at 12:48 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> ---
>  src/map_ap.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/src/map_ap.c b/src/map_ap.c
> index 2e7758e..38e9500 100644
> --- a/src/map_ap.c
> +++ b/src/map_ap.c
> @@ -125,6 +125,29 @@ static int find_ap_def(uint8_t tag)
>        return -1;
>  }
>
> +static void ap_entry_dump(gpointer tag, gpointer val, gpointer user_data)
> +{
> +       struct ap_entry *entry = val;
> +       int tago;
> +
> +       tago = find_ap_def(GPOINTER_TO_INT(tag));
> +
> +       switch (ap_defs[tago].type) {
> +       case APT_UINT8:
> +               DBG("%-30s %08x", ap_defs[tago].name, entry->val8u);
> +               break;
> +       case APT_UINT16:
> +               DBG("%-30s %08x", ap_defs[tago].name, entry->val16u);
> +               break;
> +       case APT_UINT32:
> +               DBG("%-30s %08x", ap_defs[tago].name, entry->val32u);
> +               break;
> +       case APT_STR:
> +               DBG("%-30s %s", ap_defs[tago].name, entry->valstr);
> +               break;
> +       }
> +}
> +
>  static void ap_entry_free(gpointer val)
>  {
>        struct ap_entry *entry = val;
> @@ -228,6 +251,8 @@ skip:
>                done += hdr->len + sizeof(struct obex_ap_header);
>        }
>
> +       g_hash_table_foreach(ap, ap_entry_dump, NULL);
> +

You are dumping on free isn't that more efficient to dump while decoding?

-- 
Luiz Augusto von Dentz
