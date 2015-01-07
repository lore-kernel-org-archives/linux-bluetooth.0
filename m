Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001c01d02a60$26466900$72d33b00$@samsung.com>
References: <1418997688-16691-1-git-send-email-gowtham.ab@samsung.com>
	<001c01d02a60$26466900$72d33b00$@samsung.com>
Date: Wed, 7 Jan 2015 11:34:13 -0200
Message-ID: <CABBYNZL3c2PRoXRz3C1Rq_UAPDr-ayQHQRRbWn9txo5jdRcOeg@mail.gmail.com>
Subject: Re: [PATCH] src/att: Fix usage of memory after it is freed.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 7, 2015 at 7:56 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Friday, December 19, 2014 7:31 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: d.kasatkin@samsung.com; bharat.panda@samsung.com;
>> cpgs@samsung.com; Gowtham Anandha Babu
>> Subject: [PATCH] src/att: Fix usage of memory after it is freed.
>>
>> warning: Use of memory after it is freed
>>       respond_not_supported(att, opcode);
>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ---
>>  src/shared/att.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/shared/att.c b/src/shared/att.c index 4be0652..a98909e
>> 100644
>> --- a/src/shared/att.c
>> +++ b/src/shared/att.c
>> @@ -692,14 +692,14 @@ static void handle_notify(struct bt_att *att,
> uint8_t
>> opcode, uint8_t *pdu,
>>
>>       queue_foreach(att->notify_list, notify_handler, &data);
>>
>> -     bt_att_unref(att);
>> -
>>       /*
>>        * If this was a request and no handler was registered for it,
> respond
>>        * with "Not Supported"
>>        */
>>       if (!data.handler_found && get_op_type(opcode) ==
>> ATT_OP_TYPE_REQ)
>>               respond_not_supported(att, opcode);
>> +
>> +     bt_att_unref(att);
>>  }
>>
>>  static bool can_read_data(struct io *io, void *user_data)
>> --
>> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
