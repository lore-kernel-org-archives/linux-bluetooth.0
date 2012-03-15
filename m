Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331808559-12880-6-git-send-email-arik@wizery.com>
References: <1331808559-12880-1-git-send-email-arik@wizery.com>
	<1331808559-12880-6-git-send-email-arik@wizery.com>
Date: Thu, 15 Mar 2012 08:09:16 -0400
Message-ID: <CAJdJm_PAe8PR-Urt3kF+QhhgK-=WZEQQt6upwP_A=dBCT_yTJg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] proximity: immediate alert: implement immediate
 alert server
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Thu, Mar 15, 2012 at 6:49 AM, Arik Nemtsov <arik@wizery.com> wrote:
> +void register_imm_alert(struct btd_adapter *adapter, DBusConnection *conn);
> +void unregister_imm_alert(struct btd_adapter *adapter);
> +const char *imm_get_alert_level(struct btd_device *device);

Same suggestion applies here:

imm_alert_register()
imm_alert_unregister()
imm_alert_get_level()

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
