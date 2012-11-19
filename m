Return-Path: <cyrus@holtmann.org>
Message-ID: <50AAA596.3030509@elbrys.com>
Date: Mon, 19 Nov 2012 16:33:10 -0500
From: Bart Westgeest <bart@elbrys.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] sdp: Upgrade datatype SEQ8 to SEQ16 when data size
 is greater than 256
References: <1353351872-10628-1-git-send-email-bart@elbrys.com> <1353351872-10628-4-git-send-email-bart@elbrys.com> <CAJdJm_N1hJkdEqvOrgD8ErAzDT56wzPEYAiA+7KDR0Pah4P6sA@mail.gmail.com>
In-Reply-To: <CAJdJm_N1hJkdEqvOrgD8ErAzDT56wzPEYAiA+7KDR0Pah4P6sA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>> +recalculate:
>> +       pdu_size = sdp_get_data_type_size(d->dtd);
>>          buf->data_size += pdu_size;
>>
>>          data_size = sdp_get_data_size(buf, d);
>> +       if (data_size > UCHAR_MAX && d->dtd == SDP_SEQ8) {
>> +               buf->data_size = orig_data_size;
>> +               d->dtd = SDP_SEQ16;
>> +               goto recalculate;
>
> IMHO, using "goto" here is too complicated for 3 lines of code that
> will just be run at most twice. So I would simply duplicate them
> inside the if(). But others may have different opinion on this regard.

I don't have strong feelings about this. I can change it.

One could argue that the way I did it shows that the *same* code needs 
to be executed again. (It the same code can also be moved into a 
do-while) - this, as well what I have currently, would allow for a data 
upgrade to SDP_SEQ16 -> SDP_SEQ32, and SDP_ALT8 -> SDP_ALT16-> SDP_ALT32 
as well, which theoretically are also needed as far as I can tell.

For the record, in any regard, I think the fix is rather ugly, goto 
statement or not. This problem is now 'fixed' in two places (the other 
one in sdp_append_to_buf, with the corresponding data length increase in 
sdp_gen_buffer). IMHO, the code requires a bigger cleanup. I actually 
made an attempt at it, but the fix got too big, and I opted for what I 
submitted instead.

To get back on topic, let me know if you or others want me to re-submit.

Bart
