Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335328441-20307-1-git-send-email-hemant.gupta@stericsson.com>
References: <1335328441-20307-1-git-send-email-hemant.gupta@stericsson.com>
Date: Wed, 25 Apr 2012 08:13:24 -0400
Message-ID: <CAJdJm_O5tke32fB352Pbkrvt98EgZiowgOpAbp2JK9QspgxDxw@mail.gmail.com>
Subject: Re: [PATCH v1] Store LE device address type with primary list
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Wed, Apr 25, 2012 at 12:34 AM, Hemant Gupta
<hemant.gupta@stericsson.com> wrote:
> -       /* FIXME: Get the correct LE addr type (public/random) */
> -       device = device_create(connection, adapter, key, ADDR_TYPE_LE_PUBLIC);
> +       /* Check if address type and space can be parsed properly */
> +       if (sscanf(value, "%d ", &addr_type) == 2)

Are you sure "2" is the correct return value here? The manpage says:

"These functions return the number of input items successfully matched
and assigned [...]"

So I would imagine it should return 1 if addr_type is filled, 0
otherwise. Can you verify this?

(unless sscanf() counts the whitespace as input.)

> +               /* Increment by 2 (address type and space) */
> +               value += 2;
> +
> +       device = device_create(connection, adapter, key, addr_type);
>        if (!device)
>                return;

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
