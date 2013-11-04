Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131101131141.GA30191@x220.p-661hnu-f1>
References: <1383308405-17782-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<20131101131141.GA30191@x220.p-661hnu-f1>
Date: Mon, 4 Nov 2013 09:40:41 +0100
Message-ID: <CAHCYCowJsBgYL-ivZfR2FdAWK5Ji4n1dyAyH+zBxuv401wNCVg@mail.gmail.com>
Subject: Re: [PATCH] android/client: Fix pin reply call when pin argument
 missing in cmd
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On 1 November 2013 14:11, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Ravi,
>
> On Fri, Nov 01, 2013, Ravi kumar Veeramally wrote:
>> If condition checks number of arguments properly but still executes
>> EXEC command. It should display error message and return.
>> ---
>>  android/client/if-bt.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/android/client/if-bt.c b/android/client/if-bt.c
>> index 3d97458..2c3cc4a 100644
>> --- a/android/client/if-bt.c
>> +++ b/android/client/if-bt.c
>> @@ -719,12 +719,15 @@ static void pin_reply_p(int argc, const char **argv)
>>       RETURN_IF_NULL(if_bluetooth);
>>       VERIFY_ADDR_ARG(2, &addr);
>>
>> -     if (argc > 3) {
>> -             accept = 1;
>> -             pin_len = strlen(argv[3]);
>> -             memcpy(pin.pin, argv[3], pin_len);
>> +     if (argc != 4) {
>> +             haltest_error("Usage <address> <pin>\n");
>> +             return;
>>       }
>>
>> +     accept = 1;
>> +     pin_len = strlen(argv[3]);
>> +     memcpy(pin.pin, argv[3], pin_len);
>> +
>>       EXEC(if_bluetooth->pin_reply, &addr, accept, pin_len, &pin);
>
> It seems to me that the original code might have been trying to do (if
> it hadn't been broken like it now is) a negative pin reply in the case
> that no parameter was given. At least I don't see any other code trying
> to call if_bluetooth->pin_reply with accept=1 in haltest. So I'd
> consider fixing that instead.

Idea here was: no pin given set accept to 0, so user would not need to
type accept argument at all.
What is missing though, is initialization of accept to 0.

-- 
Jerzy
