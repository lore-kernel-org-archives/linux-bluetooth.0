Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331808559-12880-5-git-send-email-arik@wizery.com>
References: <1331808559-12880-1-git-send-email-arik@wizery.com>
	<1331808559-12880-5-git-send-email-arik@wizery.com>
Date: Thu, 15 Mar 2012 08:09:08 -0400
Message-ID: <CAJdJm_Pud-XGo22C0i+rikYGBfUfsheb2eoNXxvCmqAQVKZBAw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] proximity: link loss: implement link loss server
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Thu, Mar 15, 2012 at 6:49 AM, Arik Nemtsov <arik@wizery.com> wrote:
> +void register_link_loss(struct btd_adapter *adapter, DBusConnection *conn);
> +void unregister_link_loss(struct btd_adapter *adapter);
> +const char *link_loss_get_alert_level(struct btd_device *device);

Given that these functions are exported, I suggest using a common
prefix so it is easier to detect where they come from, e.g.:

link_loss_register()
link_loss_unregister()
link_loss_get_alert_level()

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
