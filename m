Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKGzBROENrBs0g8RQPBR4faeugOqXr5=FyjykHu5fn3Kw@mail.gmail.com>
References: <1318324718-19760-1-git-send-email-dmitriy.paliy@nokia.com>
	<CABBYNZKGzBROENrBs0g8RQPBR4faeugOqXr5=FyjykHu5fn3Kw@mail.gmail.com>
Date: Tue, 11 Oct 2011 13:13:18 +0300
Message-ID: <CAHMBquWOHbNp8DLcNRRHwyPF8qs3GgFFz83AbkLJdFoBfk0Wpw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix call status in +CLCC for maemo6 telephony
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 11, 2011 at 12:44 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Dmitriy,
>
> On Tue, Oct 11, 2011 at 12:18 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
>> If list current calls is requested when there is second incoming call
>> and csd call status is CSD_CALL_STATUS_PROCEEDING, then returned 'state
>> of the call' value in +CLCC is 4 (incoming, MT call), which is incorrect.
>> Indication than proceeds from incoming to waiting state.
>>
>> This patch sets the corresponding value to 5 (waiting, MT call) in
>> maemo6 telephony driver for the second call.
>> ---
>>  audio/telephony-maemo6.c |    8 ++++++--
>>  1 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
>> index 102daeb..13bb198 100644
>> --- a/audio/telephony-maemo6.c
>> +++ b/audio/telephony-maemo6.c
>> @@ -932,8 +932,12 @@ static int csd_status_to_hfp(struct csd_call *call)
>>                /* PROCEEDING can happen in outgoing/incoming */
>>                if (call->originating)
>>                        return CALL_STATUS_DIALING;
>> -               else
>> -                       return CALL_STATUS_INCOMING;
>> +               else {
>> +                       if (g_slist_length(active_calls) > 0)
>> +                               return CALL_STATUS_WAITING;
>> +                       else
>> +                               return CALL_STATUS_INCOMING;
>> +               }
>
> I guess you could have else if (g_slist_length(active_calls) > 0)
> which is less indentation, other than that looks ok.

In this way it looks grouped in better way to my taste, since there
are two cases (incoming and dialing), and those have sub-cases. Note,
that dialing may have also two sub-cases in theory (2: dialling, 3:
alerting). Such structure
if (call->originating)
...
else if (g_slist_length(active_calls) > 0)
...
else
looks more confusing. What do you think?

Dmitriy
