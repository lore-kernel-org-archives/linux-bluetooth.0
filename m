Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MWyCVp6k+s2nmSkBMbVj0mtobjKUs7Y5t1kPz9veXduw@mail.gmail.com>
References: <1332711499-5928-1-git-send-email-arik@wizery.com>
 <1332711499-5928-6-git-send-email-arik@wizery.com> <CAJdJm_MWyCVp6k+s2nmSkBMbVj0mtobjKUs7Y5t1kPz9veXduw@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Mon, 26 Mar 2012 15:37:40 +0200
Message-ID: <CA+XVXfcU2NGc7=6nntfDaSRQ5R8TfeAkKFQBsT+VwgtGQ29dRw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] proximity: immediate alert: implement immediate
 alert server
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Anderson,

On Mon, Mar 26, 2012 at 15:26, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Arik,
>
> On Sun, Mar 25, 2012 at 5:38 PM, Arik Nemtsov <arik@wizery.com> wrote:
>> +void imm_alert_unregister(struct btd_adapter *adapter)
>> +{
>> +       struct imm_alert_adapter *imadapter;
>> +
>> +       imadapter = find_imm_alert_adapter(adapter);
>> +       if (!adapter)
>> +               return;
>
> The check above looks strange. Maybe you meant "if (!imadapter)"?

Yea that's a typo. Thanks.

Before fixing I'd be glad to get an ack on the patch series, to make
sure no other changes need to be made.

Regards,
Arik
