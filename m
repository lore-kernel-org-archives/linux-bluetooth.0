Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319104011-27747-6-git-send-email-sancane@gmail.com>
References: <1319104011-27747-1-git-send-email-sancane@gmail.com>
	<1319104011-27747-2-git-send-email-sancane@gmail.com>
	<1319104011-27747-3-git-send-email-sancane@gmail.com>
	<1319104011-27747-4-git-send-email-sancane@gmail.com>
	<1319104011-27747-5-git-send-email-sancane@gmail.com>
	<1319104011-27747-6-git-send-email-sancane@gmail.com>
Date: Thu, 20 Oct 2011 08:18:06 -0300
Message-ID: <CAJdJm_PdUWdF0t6wXkww8nODiVJLvUZRdy238DjVA_JBXHp3Zw@mail.gmail.com>
Subject: Re: [PATCH 5/8] Enable final measurement indications when first
 watcher is enabled
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Oct 20, 2011 at 6:46 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> +static void final_measurement_cb (guint8 status, const guint8 *pdu,
> +                                               guint16 len, gpointer user_data)

There should be no space before "(" in function definitions/declarations.

> +{
> +       gchar *msg = user_data;
> +
> +       if (status != 0) {
> +               error("%s failed", msg);

You don't need to g_free(msg) in case of error?

> +               return;
> +       }
> +
> +       g_free(msg);
> +}
> +

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
