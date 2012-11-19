Return-Path: <cyrus@holtmann.org>
Message-ID: <50AA9F55.8030709@elbrys.com>
Date: Mon, 19 Nov 2012 16:06:29 -0500
From: Bart Westgeest <bart@elbrys.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] sdp: Limit side effects of sdp_get_data_type and
 sdp_get_data_size
References: <1353351872-10628-1-git-send-email-bart@elbrys.com> <1353351872-10628-3-git-send-email-bart@elbrys.com> <CAJdJm_MSAw2EWV=Tp-ycdfhUi1wJdcdXdH+4YAdfGx1LRpWs-g@mail.gmail.com>
In-Reply-To: <CAJdJm_MSAw2EWV=Tp-ycdfhUi1wJdcdXdH+4YAdfGx1LRpWs-g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>> -       sdp_get_data_type(buf, d->dtd);
>> -       sdp_get_data_size(buf, d);
>> +       buf->buf_size += sdp_get_data_type_size(d->dtd);
>> +       buf->buf_size += sdp_get_data_size(buf, d);
>
> No need to check for "if (!buf->data)" like in the original code?

I do not think there's a need for it, this modification is in 
sdp_gen_buffer. sdp_gen_buffer is called three times from the following 
functions: (1) sdp_attr_size, (2) sdp_append_to_pdu, and (3) 
gen_dataseq_pdu.

For (2) & (3), buf is memset to 0 prior to calling sdp_gen_buffer, thus 
buf->data is always NULL.

For (1), buf is also memset to 0 for the first call to sdp_attr_size, 
which is called repetitively in a foreach statement. Repetitive calls to 
sdp_gen_buffer on the same buffer will not (ever) result in an 
allocation of buf->data as far as I can tell.

>> -       pdu_size = sdp_get_data_type(buf, dtd);
>> +       pdu_size = sdp_get_data_type_size(dtd);
>
> Same here. Additionally, buf->buf_size is not being updated.

This modification is in sdp_gen_pdu. sdp_gen_pdu is never called with 
buf->data == NULL. If it would, then the initialization of seqp in 
sdp_gen_pdu is erroneous, since it uses buf->data without verifying it.

In addition, in the current code, sdp_gen_pdu is only called from three 
locations: (1) get_data_size, (2) sdp_append_to_pdu, (3) 
gen_dataseq_pdu. In all cases the buf->data is either allocated prior to 
calling (2 & 3), or (1) there's an if statement preventing sdp_gen_pdu 
from being called when buf->data == NULL.

Bart
