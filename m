Return-Path: <cyrus@holtmann.org>
Message-id: <D2AC6A3B6F5245CE9F4AFAF703A7900F@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <4963980.578001331189664043.JavaMail.weblogic@epml07>
 <CABBYNZJut6tNv6Eq66sM1xToD=tT63Q6qT+Bcg1aFcwmc=Dc0Q@mail.gmail.com>
In-reply-to: <CABBYNZJut6tNv6Eq66sM1xToD=tT63Q6qT+Bcg1aFcwmc=Dc0Q@mail.gmail.com>
Subject: Re: [PATCH obexd] gobex: call g_obex_unref() before io channel unref
Date: Thu, 08 Mar 2012 18:13:49 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Thursday, March 08, 2012 5:58 PM
To: <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd] gobex: call g_obex_unref() before io channel 
unref

> Hi Jaganath,
>
> On Thu, Mar 8, 2012 at 8:54 AM, JAGANATH KANAKKASSERY
> <jaganath.k@samsung.com> wrote:
>>
>> Hi
>>
>> ------- Original Message -------
>> Sender : JAGANATH KANAKKASSERY<jaganath.k@samsung.com>  Lead 
>> Engineer/SISO-Linux Platform Lab/Samsung Electronics
>> Date   : Mar 08, 2012 15:48 (GMT+09:00)
>> Title  : [PATCH obexd] gobex: call g_obex_unref() before io channel unref
>>
>> In g_obex_unref, tx_queue will be flushed which results in SIGPIPE
>> in g_io_channel_write_chars() since socket is already closed in
>> io channel unref.
>>
>> Please ignore this patch
>
> I guess if the io is closed you don't need to flush anything, in the
> other hand it would be good to add a test that does what PTS expect
> with abort being sent.
>
I have raised the the same patch with subject  [PATCH obexd 2/2]. This
patch is required to pass unit test after applying my first patch
[PATCH obexd 1/2] gobex: flush tx_queue before disconnection
Otherwise while trying to access io in g_io_channel_write_chars()
SIGPIPE is coming which kills the process.
>
> -- 
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

