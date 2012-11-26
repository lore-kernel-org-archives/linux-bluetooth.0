Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7243377.vN3q5Zuh5I@uw000953>
References: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
	<1353920860-14912-4-git-send-email-szymon.janc@tieto.com>
	<CAJdJm_OLsmmxvLddeT2T=Xg427=ADNNdmfSRre5+jB-inTiGBw@mail.gmail.com>
	<7243377.vN3q5Zuh5I@uw000953>
Date: Mon, 26 Nov 2012 08:57:19 -0400
Message-ID: <CAJdJm_PVBcvw=ZPNQ0hECbgApnWaLYaSWsqQxEZAbrnA4j4AXw@mail.gmail.com>
Subject: Re: [PATCH 4/5] adaptername: Remove not needed empty remove callback
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 26, 2012 at 6:52 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> On Monday 26 of November 2012 12:45:30 Anderson Lizardo wrote:
>> Hi Szymon,
>
> Hi Anderson,
>
>>
>> On Mon, Nov 26, 2012 at 5:07 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> >  static struct btd_adapter_driver adaptername_driver = {
>> >         .name   = "adaptername",
>> >         .probe  = adaptername_probe,
>> > -       .remove = adaptername_remove,
>> > +       .remove = NULL,
>> >  };
>>
>> This variable is static, so not explicitly initialized members will be NULL.
>
> Yes, yet according to code style for bluez statics should be initialized
> explicitly, right? Or this does not count for struct members?

I forgot to mention that I did run this:

egrep -r '^[[:space:]]*\.[a-z_]+[[:space:]]*=.*NULL' *

with no results, which means no other structs are initializing unused
members with NULL. But you are right that we are still initializing
non-compound static variables explicitly to NULL or 0, as per
convention.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
