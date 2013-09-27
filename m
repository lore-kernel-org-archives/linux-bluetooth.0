Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380291161-10232-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1380291161-10232-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 27 Sep 2013 13:07:11 -0400
Message-ID: <CAJdJm_OxX5ZcdEtHdSKOcvRLumFQY9_HfYDskcSwfQXJ9SN6jA@mail.gmail.com>
Subject: Re: [RFC 09/16] android: Add adapter and device struct for BlueZ daemon
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Sep 27, 2013 at 10:12 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> +struct bt_adapter {
> +       int refcnt;
> +
> +       uint16_t dev_id;
> +       struct mgmt *mgmt;
> +       bdaddr_t bdaddr;
> +       uint32_t dev_class;
> +
> +       char *name;
> +       char *short_name;
> +
> +       uint32_t supported_settings;
> +       uint32_t current_settings;
> +
> +       GList *found_devices;

Why are you using GList instead of GSList above?

> +};
> +
> +extern GList *adapter_list;

Same here.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
