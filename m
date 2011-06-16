Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikOJC7QSWkJ2HbJTQg-e2n36mc-zw@mail.gmail.com>
References: <BANLkTi=LXBzm+9g-VdonozngKhQfOZoz2w@mail.gmail.com>
	<1307957658-11330-1-git-send-email-lkslawek@gmail.com>
	<1307957658-11330-2-git-send-email-lkslawek@gmail.com>
	<BANLkTinFrYNNSj0SL3TT=kCnB3PLS7yeAw@mail.gmail.com>
	<20110615133932.GA14904@dell.ger.corp.intel.com>
	<BANLkTi=U2mgumWCTHBMvtROWn5iAA_fiJw@mail.gmail.com>
	<BANLkTikOJC7QSWkJ2HbJTQg-e2n36mc-zw@mail.gmail.com>
Date: Thu, 16 Jun 2011 10:58:02 +0200
Message-ID: <BANLkTi=L7F3AR6bukK-GqBxprCPpy6X9TA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Modify obex_write_stream logic
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 16, 2011 at 10:27 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Wed, Jun 15, 2011 at 5:59 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>>
>> The loop is only used before we start streaming. That is because if
>> there was no streaming started, request will be finished after
>> returning from OpenOBEX callback. To still allow plugins to use the
>> original approach, the loop guarantees that there will be another
>> read() if the service plugin did not explicitly returned -EAGAIN, so
>> read() still decides explicitly when it wants the suspending to
>> happen, therefore it is perfectly aware of when to call
>> obex_object_set_io_flags().
>>
>> This is just how OpenOBEX works - unless we are streaming body
>> headers, we should add headers when getting event and suspend if we
>> want to postpone finishing the request. I would not call this loop
>> "dangerous".
>
> I would say this is not a limitation of OpenOBEX, just the way we
> implement async io in obexd.

We base asynchronous I/O on the fact the we are receiving
OBEX_EV_STREAMEMPTY. We get this only when we added body header with
OBEX_FL_STREAM_START. And this is "limitation" (I would not choose
this particular word) of OpenOBEX. Once again - if we return from a
callback, that means we finished replying to request, unless we
suspend it first (or like I've done it here, to send immediately what
is available to send - add appropriate header to make OpenOBEX suspend
it for us later).

>> Well, we have also another possible header types and generally in some
>> near future a profile may need to use more than just application
>> parameters header and/or body headers (e.g. user defined headers).
>> This might also allow sending Length header asynchronously (which by
>> quick looking at code is not possible now).
>>
>> With approach I presented the cost of changes is very low and
>> additionally makes it extremely easy to return all possible headers.
>> Also everything just works, together with support for asynchronous
>> I/O.
>>
>> Adding additional callback will unnecessarily complicate the code.
>
> Sorry I have to disagree here, adding another callback probably
> simplify the code a bit since we can have something like this:
>
> if (!streaming && driver->get_apparams)
>    driver->get_apparams...
>
> So just drivers that support get_apparams will be called and that
> should be enough to guarantee the apparams are added in the beginning
> packet.
>
> Custom headers are a different matter, right now we don't have any
> plugin/driver who need them.

So to make it work this would essentially require putting this into
obex_write_stream() (possibly doubling the code there), because we
would need to do the same checks (errors, -EAGAIN) and also it has to
be somehow supported by handle_async_io(). And yet removing
flexibility the approach presented gives, just because "right *now* no
plugin needs them".

Response is made up of headers of different kinds. This is no longer
only ftp and we are beyond following system read(). Thus we can really
use read() to read any kinds of response headers plugin wishes to
send. What's *really* wrong with that?

-- 
Slawomir Bochenski
