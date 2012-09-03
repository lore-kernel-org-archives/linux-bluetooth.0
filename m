Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120830233451.GA972@x220.sheraton.com>
References: <1346364960-7699-1-git-send-email-jprvita@openbossa.org>
	<1346364960-7699-2-git-send-email-jprvita@openbossa.org>
	<20120830233451.GA972@x220.sheraton.com>
Date: Mon, 3 Sep 2012 15:16:38 -0300
Message-ID: <CAAngNMaDp89OB82zALNf9SvBsCxmx0FwUuhMcfpauamNzj6znQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 01/15] core: Fix missing g_io_channel_ref
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 30, 2012 at 8:34 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi João Paulo,
>
> On Thu, Aug 30, 2012, João Paulo Rechi Vita wrote:
>> ---
>>  src/device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 3b44d9b..2c40ec2 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -2027,7 +2027,7 @@ static gboolean att_connect(gpointer user_data)
>>               return FALSE;
>>       }
>>
>> -     device->att_io = io;
>> +     device->att_io = g_io_channel_ref(io);
>>
>>       return FALSE;
>>  }
>
> This doesn't look right to me. bt_io_connect returns a reference for the
> caller and you shouldn't need to re-increment the ref count again unless
> you store a pointer in multiple places (which you don't). If this patch
> fixes some behavior the real bug must be somewhere else.
>

Yes, this became wrong due to spliting this code out of "core:
Mutually exclude concurrent connections". I'll fix that and re-send
the series one more time.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
