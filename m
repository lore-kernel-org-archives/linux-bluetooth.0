Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1362405510-8685-2-git-send-email-luiz.dentz@gmail.com>
References: <1362405510-8685-1-git-send-email-luiz.dentz@gmail.com>
	<1362405510-8685-2-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 4 Mar 2013 21:12:31 -0400
Message-ID: <CAJdJm_O=bbq4NW3VXLzPQ_g4Ps+8SZ_wBFJwOGdtkuPsUis88A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4 v2] core: Add DisableProfiles entry to main.conf
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 4, 2013 at 9:58 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> +               if (g_pattern_match_simple(blacklist[i], profile->name) == 0)
> +                       return -EPROTONOSUPPORT;

g_pattern_match_simple() returns gboolean so IMHO it is more readable
if you use "== FALSE" or simply "if (!g_pattern_match_simple(...))"
above.

> +
> +               if (profile->local_uuid != NULL && strcasecmp(blacklist[i],
> +                                               profile->local_uuid) == 0)
> +                       return -EPROTONOSUPPORT;
> +
> +               if (profile->remote_uuids == NULL)
> +                       continue;
> +
> +               if (strcasecmp(blacklist[i], profile->remote_uuids[0]) == 0)
> +                       return -EPROTONOSUPPORT;
> +       }
> +
> +done:
>         profiles = g_slist_append(profiles, profile);
>         return 0;
>  }

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
