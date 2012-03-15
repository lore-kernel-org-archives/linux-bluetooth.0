Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PAe8PR-Urt3kF+QhhgK-=WZEQQt6upwP_A=dBCT_yTJg@mail.gmail.com>
References: <1331808559-12880-1-git-send-email-arik@wizery.com>
 <1331808559-12880-6-git-send-email-arik@wizery.com> <CAJdJm_PAe8PR-Urt3kF+QhhgK-=WZEQQt6upwP_A=dBCT_yTJg@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Thu, 15 Mar 2012 14:18:02 +0200
Message-ID: <CA+XVXfeo6xmp8aGnsxRaY5bYnX0uj=WQ_RrP=XTGfqHHKU-18w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] proximity: immediate alert: implement immediate
 alert server
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
>> +void register_imm_alert(struct btd_adapter *adapter, DBusConnection *conn);
>> +void unregister_imm_alert(struct btd_adapter *adapter);
>> +const char *imm_get_alert_level(struct btd_device *device);
>
> Same suggestion applies here:
>
> imm_alert_register()
> imm_alert_unregister()
> imm_alert_get_level()
>

Sure.
