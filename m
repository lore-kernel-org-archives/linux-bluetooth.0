Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140317084210.GB16561@aemeltch-MOBL1>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
	<1395043737-8905-2-git-send-email-luiz.dentz@gmail.com>
	<20140317084210.GB16561@aemeltch-MOBL1>
Date: Mon, 17 Mar 2014 11:25:42 +0200
Message-ID: <CABBYNZJSi-0cTVUP30JONw2zDXOGQx-UJ2GWGQakWYvvWLgLZw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 02/12] android/avrcp-lib: Add support for parsing
 GetCapabilities PDU
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Mar 17, 2014 at 10:42 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> On Mon, Mar 17, 2014 at 10:08:47AM +0200, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  android/avrcp-lib.c | 32 ++++++++++++++++++++++++++++++++
>>  android/avrcp-lib.h |  2 ++
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
>> index ca01b50..9c19092 100644
>> --- a/android/avrcp-lib.c
>> +++ b/android/avrcp-lib.c
>> @@ -261,6 +261,37 @@ void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
>>       session->destroy_data = user_data;
>>  }
>>
>> +static ssize_t get_capabilities(struct avrcp *session, uint8_t transaction,
>
> Should it be handle_get_capabilities() to make it consistent with the
> other code.

I deliberately changed the name to avoid copying code around without
checking and to match the exact name that is used for the callback.
