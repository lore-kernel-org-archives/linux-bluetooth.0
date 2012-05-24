Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120523142122.GA19662@x220.P-661HNU-F1>
References: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
	<20120523142122.GA19662@x220.P-661HNU-F1>
Date: Thu, 24 May 2012 11:33:40 +0300
Message-ID: <CABBYNZKCdE+obYyRphPKQ3jSQ4Wgrmt+MGEr9q5+wxHmzGhqaA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] AVCTP: Fix setting wrong transaction id
 expected for responses
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, May 23, 2012 at 5:21 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Tue, May 22, 2012, Luiz Augusto von Dentz wrote:
>> The id were incremented after being set to the request so it is always
>> +1 of the actual transaction.
>> ---
>>  audio/avctp.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/audio/avctp.c b/audio/avctp.c
>> index d98d097..f2d5954 100644
>> --- a/audio/avctp.c
>> +++ b/audio/avctp.c
>> @@ -981,7 +981,7 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
>>       struct avctp_rsp_handler *handler;
>>       int err;
>>
>> -     err = avctp_send(session, id++, AVCTP_COMMAND, code, subunit,
>> +     err = avctp_send(session, ++id, AVCTP_COMMAND, code, subunit,
>>                               AVC_OP_VENDORDEP, operands, operand_count);
>>       if (err < 0)
>>               return err;
>
> By switching to pre-increment you're essentially jumping over one
> possible value since the send_passthrough function uses post-increment.
> Not a very big issue, but what would be a bit cleaner imo is to drop the
> increment from the avctp_send call and instead do a post-increment
> together with the assignment to handler->id.

Yep, I will change as suggested.


-- 
Luiz Augusto von Dentz
