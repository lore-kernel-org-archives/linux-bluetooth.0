Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331891164-24588-6-git-send-email-arik@wizery.com>
References: <1331891164-24588-1-git-send-email-arik@wizery.com>
	<1331891164-24588-6-git-send-email-arik@wizery.com>
Date: Fri, 16 Mar 2012 07:54:41 -0400
Message-ID: <CAJdJm_PevgTAKTzTGQEWUeAWYLA3pv5JNDE1NgLHXSe-mvefyg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] proximity: immediate alert: implement immediate
 alert server
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Fri, Mar 16, 2012 at 5:46 AM, Arik Nemtsov <arik@wizery.com> wrote:
> +void imm_alert_register(struct btd_adapter *adapter, DBusConnection *conn);
> +void imm_alert_unregister(struct btd_adapter *adapter);
> +const char *imm_get_alert_level(struct btd_device *device);

You may also fix this (to keep same prefix for non-local functions):

imm_get_alert_level -> imm_alert_get_level

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
