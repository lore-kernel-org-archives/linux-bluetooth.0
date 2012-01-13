Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
References: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
Date: Fri, 13 Jan 2012 14:02:04 +0200
Message-ID: <CABBYNZ+7ogaWV-9Xo6k6hKFRAAZ4tU1zd=FRcBF=w0EMJ0Zx+A@mail.gmail.com>
Subject: Re: [PATCH obexd 1/4] MAP: Implementation of MAP AP core functions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawomir,

On Fri, Jan 13, 2012 at 12:48 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>  map_ap_t *map_ap_new(void)
>  {
> -       return NULL;
> +       return g_hash_table_new_full(NULL, NULL, NULL, ap_entry_free);

I supposed you would like to use g_direct_hash and g_direct_equal
here, even if NULL mean the same it easier to understand and maintain
that way. Also it is not clear why the return of map_ap_new is
map_ap_t not a GHashTable?

>  }
>
>  void map_ap_free(map_ap_t *ap)
>  {
> +       if (!ap)
> +               return;

Are you sure you need this check, iirc most functions of glib does
NULL check already and sometime it even print warnings, so if this
check is to prevent warning I would suggest no to have because  it
will hide real bugs behind it.

-- 
Luiz Augusto von Dentz
