Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140911163752.GA27789@t440s>
References: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
	<20140911163752.GA27789@t440s>
Date: Thu, 11 Sep 2014 23:45:58 +0300
Message-ID: <CABBYNZJJGeaaPU7mgBCBzCVee9qUB6JXiE3m9-O_-+UUsB9CuA@mail.gmail.com>
Subject: Re: [PATCH 1/7] obexd/client : Handle the MAP Extended Event Report 1.1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 11, 2014 at 7:37 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Thu, Sep 11, 2014, Gowtham Anandha Babu wrote:
>>  struct map_event {
>> @@ -41,6 +42,10 @@ struct map_event {
>>       char *folder;
>>       char *old_folder;
>>       char *msg_type;
>> +     char *datetime;
>> +     char *subject;
>> +     char *sender_name;
>> +     char *priority;
>>  };
> <snip>
>> +static void parse_event_report_date_time(struct map_event *event,
>> +                                                        const char *value)
>> +{
>> +     event->datetime = g_strdup(value);
>> +}
>> +
>> +static void parse_event_report_subject(struct map_event *event,
>> +                                                        const char *value)
>> +{
>> +     event->subject = g_strdup(value);
>> +}
>> +
>> +static void parse_event_report_sender_name(struct map_event *event,
>> +                                                        const char *value)
>> +{
>> +     event->sender_name = g_strdup(value);
>> +}
>> +
>> +static void parse_event_report_priority(struct map_event *event,
>> +                                                        const char *value)
>> +{
>> +     event->priority = g_strdup(value);
>> +}
>
> Where are all these freed? Don't you need to update the map_event_free()
> function? If you're not yet doing so, please always test your code with
> "valgrind --leak-check=full".

And it is mentioned in the HACKING document.

-- 
Luiz Augusto von Dentz
