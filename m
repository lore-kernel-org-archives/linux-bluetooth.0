Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2626729.yqIRdlFYHe@uw000953>
References: <1412898611-12199-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1412898611-12199-6-git-send-email-lukasz.rymanowski@tieto.com>
	<2626729.yqIRdlFYHe@uw000953>
Date: Thu, 23 Oct 2014 17:00:33 +0200
Message-ID: <CAMudyAuc==ZCs63sXoL757-Ffk81gTcAE2Y1fuvE7P-KESGx2Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] shared/hfp: Add HFP HF parser
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 22 October 2014 13:00, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Łukasz,
>
> On Friday 10 of October 2014 01:50:05 Lukasz Rymanowski wrote:
>> This patch adds parser for AT responses and unsolicited results.
>> ---
>>  src/shared/hfp.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 129 insertions(+)
>>
>> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
>> index b1cf08e..5179092 100644
>> --- a/src/shared/hfp.c
>> +++ b/src/shared/hfp.c
>> @@ -868,6 +868,126 @@ static void destroy_event_handler(void *data)
>>       free(handler);
>>  }
>>
>> +static void hf_skip_whitespace(struct hfp_hf_result *result)
>> +{
>> +     while (result->data[result->offset] == ' ')
>> +             result->offset++;
>> +}
>> +
>> +static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
>> +{
>> +     struct event_handler *handler;
>> +     const char *separators = ";:\0";
>> +     struct hfp_hf_result result_data;
>> +     char lookup_prefix[18];
>> +     uint8_t pref_len = 0;
>> +     const char *prefix;
>> +     int i;
>> +
>> +     result_data.offset = 0;
>> +     result_data.data = data;
>> +
>> +     hf_skip_whitespace(&result_data);
>> +
>> +     if (strlen(data + result_data.offset) < 2)
>> +             return;
>> +
>> +     prefix = data + result_data.offset;
>> +
>> +     pref_len = strcspn(prefix, separators);
>> +     if (pref_len > 17 || pref_len < 2)
>> +             return;
>> +
>> +     for (i = 0; i < pref_len; i++)
>> +             lookup_prefix[i] = toupper(prefix[i]);
>> +
>> +     lookup_prefix[pref_len] = '\0';
>> +     result_data.offset += pref_len + 1;
>> +
>> +     handler = queue_find(hfp->event_handlers, match_handler_event_prefix,
>> +                                                             lookup_prefix);
>> +     if (!handler)
>> +             return;
>> +
>> +     handler->callback(&result_data, handler->user_data);
>> +}
>> +
>> +static char *find_cr_lf(char *str, size_t len)
>> +{
>> +     char *ptr;
>> +     int count;
>> +     int offset;
>> +
>> +     offset = 0;
>> +
>> +     ptr = memchr(str, '\r', len);
>> +     while (ptr) {
>> +             /*
>> +              * Check if there is more data after '\r'. If so check for
>> +              * '\n'
>> +              */
>> +             count = ptr-str;
>
> Style: spaces around -

>
>> +             if ((count < (int) (len - 1)) && *(ptr + 1) == '\n')
>> +                     return ptr;
>
> If you make count size_t then this cast is not needed.
>
>> +
>> +             /* There is only '\r'? Let's try to find next one */
>> +             offset += count + 1;
>> +
>> +             if (offset >= (int)len)
>
> If you make offset size_t then this cast is not needed.
> Also such casting should have space '(int) foo'.
>
>> +                     return NULL;
>> +
>> +             ptr = memchr(str + offset, '\r', len - offset);
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>> +static void hf_process_input(struct hfp_hf *hfp)
>> +{
>> +     char *str, *ptr;
>> +     size_t len, count, offset;
>> +
>> +     str = ringbuf_peek(hfp->read_buf, 0, &len);
>> +     if (!str)
>> +             return;
>> +
>> +     offset = 0;
>> +
>> +     ptr = find_cr_lf(str, len);
>> +     while (ptr) {
>> +             count = ptr - (str + offset);
>
> If you would adjust str pointer instead of using str + offset everywhere
> then this code would be a bit simpler to follow.
>
see below

> Also this would not handle wrapped string correctly. Check how this is handled
> in process_input().

Missed that. Will fix, also will fix that code as asprintf should not
be use. str is not a string in case buffer is wrapped.
Also will need to keep offset so I can concatenate str and str2 which
will come from the begging of ringbuf
>
>> +             if (count == 0) {
>> +                     /* 2 is for <cr><lf> */
>> +                     offset += 2;
>> +             } else {
>> +                     *ptr = '\0';
>> +                     hf_call_prefix_handler(hfp, str + offset);
>> +                     offset += count + 2;
>> +             }
>> +
>> +             if (offset >= len)
>> +                     break;
>> +
>> +             ptr = find_cr_lf(str + offset, len - offset);
>> +     }
>> +
>> +     ringbuf_drain(hfp->read_buf, offset < len ? offset : len);
>> +}
>> +
>> +static bool hf_can_read_data(struct io *io, void *user_data)
>> +{
>> +     struct hfp_hf *hfp = user_data;
>> +     ssize_t bytes_read;
>> +
>> +     bytes_read = ringbuf_read(hfp->read_buf, hfp->fd);
>> +     if (bytes_read < 0)
>> +             return false;
>> +
>> +     hf_process_input(hfp);
>> +
>> +     return true;
>> +}
>> +
>>  struct hfp_hf *hfp_hf_new(int fd)
>>  {
>>       struct hfp_hf *hfp;
>> @@ -912,6 +1032,15 @@ struct hfp_hf *hfp_hf_new(int fd)
>>               return NULL;
>>       }
>>
>> +     if (!io_set_read_handler(hfp->io, hf_can_read_data, hfp,
>> +                                                     read_watch_destroy)) {
>> +             queue_destroy(hfp->event_handlers,
>> +                                             destroy_event_handler);
>> +             io_destroy(hfp->io);
>> +             ringbuf_free(hfp->write_buf);
>> +             ringbuf_free(hfp->read_buf);
>
> You are missing free(hfp); return NULL; here.

ah, some rebase issue. thanks

>
>> +     }
>> +
>>       return hfp_hf_ref(hfp);
>>  }
>>
>>
>
> --
> Best regards,
> Szymon Janc

\Łukasz
