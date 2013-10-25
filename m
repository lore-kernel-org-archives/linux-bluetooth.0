Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131025093616.GC6113@aemeltch-MOBL1>
References: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
	<1382691378-31940-6-git-send-email-szymon.janc@tieto.com>
	<20131025093616.GC6113@aemeltch-MOBL1>
Date: Fri, 25 Oct 2013 13:15:43 +0300
Message-ID: <CABBYNZ+edtiAGUL9rfyUd-kaLMc1L5CPr=isYU1Mb-4yBzVfCw@mail.gmail.com>
Subject: Re: [PATCH 06/15] android/hal: Add support for sending create bond command
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 25, 2013 at 12:36 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Szymon,
>
> On Fri, Oct 25, 2013 at 10:56:09AM +0200, Szymon Janc wrote:
>> This allows HAL to start bonding.
>> ---
>>  android/hal-bluetooth.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
>> index b81f8dd..6f7ef45 100644
>> --- a/android/hal-bluetooth.c
>> +++ b/android/hal-bluetooth.c
>> @@ -275,15 +275,17 @@ static int cancel_discovery(void)
>>
>>  static int create_bond(const bt_bdaddr_t *bd_addr)
>>  {
>> +     struct hal_cmd_create_bond cmd;
>> +
>>       DBG("");
>>
>>       if (!interface_ready())
>>               return BT_STATUS_NOT_READY;
>>
>> -     if (!bd_addr)
>> -             return BT_STATUS_PARM_INVALID;
>
> I think we can leave check here

If we are sure it will never be NULL then yes we can remove, otherwise leave it.



-- 
Luiz Augusto von Dentz
