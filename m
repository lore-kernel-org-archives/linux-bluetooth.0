Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120402145518.GC31518@x220.P-661HNU-F1>
References: <1333365444-9029-1-git-send-email-arik@wizery.com>
 <1333365444-9029-2-git-send-email-arik@wizery.com> <20120402145518.GC31518@x220.P-661HNU-F1>
From: Arik Nemtsov <arik@wizery.com>
Date: Mon, 2 Apr 2012 21:37:36 +0300
Message-ID: <CA+XVXffA_Ym1+983JaZR1QMyykb7+H8-JxQqKgwGrAYpc5yx7g@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] proximity: reporter: save global D-Bus connection
To: Arik Nemtsov <arik@wizery.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 2, 2012 at 17:55, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Arik,
>
> On Mon, Apr 02, 2012, Arik Nemtsov wrote:
>> --- a/proximity/reporter.c
>> +++ b/proximity/reporter.c
>> @@ -40,6 +40,7 @@
>>  #include "attrib-server.h"
>>  #include "reporter.h"
>>
>> +static DBusConnection *connection;
>>  #define IMMEDIATE_ALERT_SVC_UUID     0x1802
>>  #define LINK_LOSS_SVC_UUID           0x1803
>>  #define TX_POWER_SVC_UUID            0x1804
>
> Please move the new static variable after the defines and the enum.
> Thats's usually where we place them (right before the actual functions
> start).
>

Well this variable disappears in the patch "proximity: reporter:
implement D-Bus API", where we start saving the D-Bus connection per
reporter_adapter. So I'm guessing this is moot?

Arik
