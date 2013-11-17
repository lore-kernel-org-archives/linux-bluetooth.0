Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMXE1-oyrNbBKrRpXVwo1p29Q-RASucDZOBPvMOr-Nita-zcEQ@mail.gmail.com>
References: <1384611208-18536-1-git-send-email-szymon.janc@tieto.com>
	<1384611208-18536-3-git-send-email-szymon.janc@tieto.com>
	<CAMXE1-oyrNbBKrRpXVwo1p29Q-RASucDZOBPvMOr-Nita-zcEQ@mail.gmail.com>
Date: Sun, 17 Nov 2013 23:32:12 +0100
Message-ID: <CAOR4+gLs9DOzstVn_Qjjx5xR9BjEhXeFmRRBdtLhY9gxBWTaxA@mail.gmail.com>
Subject: Re: [PATCH 2/5] android/hal-bluetooth: Register IPC message handlers
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Bluetooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Sun, Nov 17, 2013 at 8:39 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Szymon,
>
> On Sat, Nov 16, 2013 at 4:13 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>>
>> Register handlers on service init. Since this requires all handlers to
>> be registered (unknown opcode is considered IPC error) missing handlers
>> stubs are provided.
>> ---
>>  android/hal-bluetooth.c | 223 ++++++++++++++++++++++++++++++------------------
>>  android/hal.h           |   1 -
>>  2 files changed, 142 insertions(+), 82 deletions(-)
>>
>> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
>> index 078d537..2ec7c10 100644
>> --- a/android/hal-bluetooth.c
>> +++ b/android/hal-bluetooth.c
>> @@ -35,7 +35,7 @@ static const bt_callbacks_t *bt_hal_cbacks = NULL;
>>         *pe = *((uint8_t *) (hal_prop->val)); \
>>  } while (0)
>>
>> -static void handle_adapter_state_changed(void *buf)
>> +static void handle_adapter_state_changed(void *buf, uint16_t len, int fd)
>
> Why do we need fd here and in all other places? Who uses it?

This is needed for health HAL for bthl_channel_state_callback callback.
But since this seems to be the only user for that, this can be removed
from callback prototype and a getter function could be added to obtain
fd in notification handler (we do process one notification at time
after all).

Opinions?

-- 
BR
Szymon Janc
