Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140211111202.GC8980@aemeltch-MOBL1>
References: <1391614102-21639-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20140211111202.GC8980@aemeltch-MOBL1>
Date: Tue, 11 Feb 2014 20:34:26 +0200
Message-ID: <CABBYNZLrBZDFs+0kYTppNzn6Lf7oGOYLYVsR1gZYFXPuZ-+hgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] unit/avctp: Use pre-defined values instead of magic numbers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 11, 2014 at 1:12 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> ping
>
> On Wed, Feb 05, 2014 at 05:28:21PM +0200, Andrei Emeltchenko wrote:
>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>
>> ---
>>  unit/test-avctp.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/unit/test-avctp.c b/unit/test-avctp.c
>> index 581f88c..9d94ae0 100644
>> --- a/unit/test-avctp.c
>> +++ b/unit/test-avctp.c
>> @@ -277,8 +277,8 @@ static void test_client(gconstpointer data)
>>  {
>>       struct context *context = create_context(0x0100, data);
>>
>> -     avctp_send_vendordep_req(context->session, 0, 0, NULL, 0,
>> -                                             handler_response, context);
>> +     avctp_send_vendordep_req(context->session, AVC_CTYPE_CONTROL, 0, NULL,
>> +                                             0, handler_response, context);
>>
>>       execute_context(context);
>>  }
>> @@ -290,8 +290,8 @@ static void test_server(gconstpointer data)
>>       if (g_str_equal(context->data->test_name, "/TP/NFR/BV-03-C")) {
>>               int ret;
>>
>> -             ret = avctp_register_pdu_handler(context->session, 0x00,
>> -                                                             handler, NULL);
>> +             ret = avctp_register_pdu_handler(context->session,
>> +                                     AVC_OP_VENDORDEP, handler, NULL);
>>               DBG("ret %d", ret);
>>               g_assert_cmpint(ret, !=, 0);
>>       }
>> --
>> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
