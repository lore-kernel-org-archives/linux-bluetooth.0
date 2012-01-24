Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327364511-6348-1-git-send-email-vinicius.gomes@openbossa.org>
References: <20120123132915.GA2879@samus>
	<1327364511-6348-1-git-send-email-vinicius.gomes@openbossa.org>
Date: Tue, 24 Jan 2012 06:40:03 -0400
Message-ID: <CAJdJm_N+FXcJfXm_1eEmjJUp0c4Ek2OL3gJrSnRyfjmoCPNG5A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix memory leak when loading keys
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Jan 23, 2012 at 8:21 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> @@ -3570,7 +3571,16 @@ static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
>        if (dev->keys != NULL)
>                return -EEXIST;
>
> -       dev->keys = keys;
> +       for (l = keys; l; l = l->next) {
> +               struct link_key_info *orig, *dup;
> +
> +               orig = l->data;
> +
> +               dup = g_memdup(orig, sizeof(*orig));
> +
> +               dev->keys = g_slist_prepend(dev->keys, dup);
> +       }
> +

No need to cleanup dev->keys first?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
