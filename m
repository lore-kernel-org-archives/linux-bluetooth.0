Return-Path: <denkenz@gmail.com>
Subject: Re: [PATCH BlueZ] shared/io-ell: Add support for ELL based IO
 handling
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 "Stotland, Inga" <inga.stotland@intel.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20180514235614.25231-1-inga.stotland@intel.com>
 <C65C87C6-375D-46B1-8CB1-3C96EF9939E4@holtmann.org>
 <5b6349ba-e0dd-8b56-5654-c1e0e20be4a8@gmail.com>
 <CABBYNZ+dmaLOTOJgYMoLS2jzWNZCqHYjVvcJsKYiFTgv1en-wg@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
Message-ID: <7edd28a2-c446-2323-169a-b8630fdb1557@gmail.com>
Date: Thu, 17 May 2018 10:01:31 -0500
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+dmaLOTOJgYMoLS2jzWNZCqHYjVvcJsKYiFTgv1en-wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 05/17/2018 03:01 AM, Luiz Augusto von Dentz wrote:
> Hi,
> On Wed, May 16, 2018 at 5:42 PM Denis Kenzior <denkenz@gmail.com> wrote:
> 
>> Hi,
> 
>>>> +
>>>> +    do {
>>>> +            ret = writev(fd, iov, iovcnt);
>>>> +    } while (ret < 0 && errno == EINTR);
>>>
>>> explain this one to me. Or maybe Luiz should explain it since he
> introduced this.
>>>
> 
>> I'm curious why not use TEMP_FAILURE_RETRY macro?  ell already uses that
>> for clarity.
> 
> Szymon was actually suggesting that we should have something similar in
> ell, e.g. l_io_send, it would be nice if that would handle iovec similarly
> to how is done here but perhaps using the TEMP_FAILURE_RETRY as suggested
> by Denis.
> 

I would rather not do that actually.  It is already weird that you guys 
have io_send but not io_recv.  And since io is not only used with 
streams / files, but with datagram sockets as well, we would have to add 
a bunch of methods for symmetry.  Not to mention that somehow 'send' 
uses iovecs and the convention inside ell for this is to suffix the 
method with a 'v'.

Also, just a nitpick, but io_send should really be io_writev.   You're 
just confusing every hardcore UNIX user here since a vectorized send is 
'sendmsg'.

By the way, correct me if I'm wrong, but I think there is zero need for 
TEMP_FAILURE_RETRY inside BlueZ since it uses signalfd and non-blocking 
IO anyway.  The only reason ell uses this macro is because we can't 
assume how signals are used in the enclosing application.

Regards,
-Denis
