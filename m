Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332711499-5928-6-git-send-email-arik@wizery.com>
References: <1332711499-5928-1-git-send-email-arik@wizery.com>
	<1332711499-5928-6-git-send-email-arik@wizery.com>
Date: Mon, 26 Mar 2012 09:26:39 -0400
Message-ID: <CAJdJm_MWyCVp6k+s2nmSkBMbVj0mtobjKUs7Y5t1kPz9veXduw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] proximity: immediate alert: implement immediate
 alert server
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Sun, Mar 25, 2012 at 5:38 PM, Arik Nemtsov <arik@wizery.com> wrote:
> +void imm_alert_unregister(struct btd_adapter *adapter)
> +{
> +       struct imm_alert_adapter *imadapter;
> +
> +       imadapter = find_imm_alert_adapter(adapter);
> +       if (!adapter)
> +               return;

The check above looks strange. Maybe you meant "if (!imadapter)"?

> +
> +       g_slist_foreach(imadapter->connected_devices, remove_condev_list_item,
> +                       NULL);
> +       dbus_connection_unref(imadapter->conn);
> +
> +       imm_alert_adapters = g_slist_remove(imm_alert_adapters, imadapter);
> +       g_free(imadapter);
> +}

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
