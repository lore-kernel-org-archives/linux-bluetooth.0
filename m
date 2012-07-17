Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+SDVpGJvwGZ02OSd7v8V7Xm5R=mWK-Q-s_7ANmjXGJ0w@mail.gmail.com>
References: <1341913016-23320-1-git-send-email-vani.patel@stericsson.com>
	<CABBYNZ+SDVpGJvwGZ02OSd7v8V7Xm5R=mWK-Q-s_7ANmjXGJ0w@mail.gmail.com>
Date: Tue, 17 Jul 2012 14:04:40 +0300
Message-ID: <CABBYNZ+P0z1CohYejRpBQ1-zP0u_taVsFA9Cr4NvAPX_FoGCeA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5] AVRCP: Register/Unregister Browsing handler
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Tue, Jul 17, 2012 at 1:55 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Vani,
>
> On Tue, Jul 10, 2012 at 12:36 PM, Vani-dineshbhai PATEL
> <vani.patel@stericsson.com> wrote:
>> From: Vani Patel <vani.patel@stericsson.com>
>>
>> Add functions to register and unregister Browsing
>> handler
>> ---
>>  audio/avctp.c |   28 ++++++++++++++++++++++++++++
>>  audio/avctp.h |    8 ++++++++
>>  2 files changed, 36 insertions(+), 0 deletions(-)
>>
>> diff --git a/audio/avctp.c b/audio/avctp.c
>> index 42eb7df..0b50611 100644
>> --- a/audio/avctp.c
>> +++ b/audio/avctp.c
>> @@ -159,6 +159,12 @@ struct avctp_pdu_handler {
>>         unsigned int id;
>>  };
>>
>> +struct avctp_browsing_pdu_handler {
>> +       avctp_browsing_pdu_cb cb;
>> +       void *user_data;
>> +       unsigned int id;
>> +};
>
> Browsing command are not encapsulated using AV/C frames, so perhaps
> the connection management of browsing channel can be done directly
> inside avrcp.c

Let me take it back since it still uses AVCTP header it is better to
stay on avctp.c for propertly tracking the transactions.


-- 
Luiz Augusto von Dentz
