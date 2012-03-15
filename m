Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Pud-XGo22C0i+rikYGBfUfsheb2eoNXxvCmqAQVKZBAw@mail.gmail.com>
References: <1331808559-12880-1-git-send-email-arik@wizery.com>
 <1331808559-12880-5-git-send-email-arik@wizery.com> <CAJdJm_Pud-XGo22C0i+rikYGBfUfsheb2eoNXxvCmqAQVKZBAw@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Thu, 15 Mar 2012 14:17:48 +0200
Message-ID: <CA+XVXfczNmY_WcQE3iJS1Lb082GdnmrrciCQf1CzBRCPffFwwA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] proximity: link loss: implement link loss server
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 15, 2012 at 14:09, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Arik,
>
> On Thu, Mar 15, 2012 at 6:49 AM, Arik Nemtsov <arik@wizery.com> wrote:
>> +void register_link_loss(struct btd_adapter *adapter, DBusConnection *conn);
>> +void unregister_link_loss(struct btd_adapter *adapter);
>> +const char *link_loss_get_alert_level(struct btd_device *device);
>
> Given that these functions are exported, I suggest using a common
> prefix so it is easier to detect where they come from, e.g.:
>
> link_loss_register()
> link_loss_unregister()
> link_loss_get_alert_level()

Makes sense. I'll change it.

Arik
