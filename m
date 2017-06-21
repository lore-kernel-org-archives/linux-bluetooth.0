Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLfN-u0xOqut3f35jaX5xRwusY5SW0oL1M_XzOF283oLQ@mail.gmail.com>
References: <20170621061358.GA17661@makarhum-e6330> <20170621094148.GA27878@x1c>
 <CABBYNZLfN-u0xOqut3f35jaX5xRwusY5SW0oL1M_XzOF283oLQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Jun 2017 22:31:39 +0300
Message-ID: <CABBYNZJOO+v0FHh2F65iMk6kDZedwG2bOXRn5Ycr4uu=qx9NHw@mail.gmail.com>
Subject: Re: [PATCH] obexd: Fix null pointer dereference.
To: Matias Karhumaa <matias.karhumaa@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matias,

On Wed, Jun 21, 2017 at 8:36 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Johan,
>
> On Wed, Jun 21, 2017 at 12:41 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Matias,
>>
>> On Wed, Jun 21, 2017, Matias Karhumaa wrote:
>>> By sending OPP Put request before CONNECT we were able to cause
>>> SIGSEGV in obexd. Crash was caused by null pointer dereference.
>>>
>>> gdb output:
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> manager_request_authorization (transfer=transfer@entry=0x0, new_folder=new_folder@entry=0x7fffffffda18, new_name=new_name@entry=0x7fffffffda20) at obexd/src/manager.c:677
>>> 677           struct obex_session *os = transfer->session;
>>> (gdb) bt
>>> *#0  manager_request_authorization (transfer=transfer@entry=0x0, new_folder=new_folder@entry=0x7fffffffda18, new_name=new_name@entry=0x7fffffffda20) at obexd/src/manager.c:677
>>> *#1  0x000000000041b7a5 in opp_chkput (os=0x67de60, user_data=0x0) at obexd/plugins/opp.c:80
>>> *#2  0x0000000000426cc5 in check_put (obex=0x678a50, req=0x679250, user_data=0x67de60) at obexd/src/obex.c:831
>>> *#3  cmd_put (obex=0x678a50, req=0x679250, user_data=0x67de60) at obexd/src/obex.c:887
>>> *#4  0x00000000004145e7 in handle_request (req=0x679250, obex=0x678a50) at gobex/gobex.c:1199
>>> *#5  incoming_data (io=<optimized out>, cond=<optimized out>, user_data=0x678a50) at gobex/gobex.c:1375
>>> *#6  0x00007ffff749204a in g_main_dispatch (context=0x674810) at /build/glib2.0-prJhLS/glib2.0-2.48.2/./glib/gmain.c:3154
>>> *#7  g_main_context_dispatch (context=context@entry=0x674810) at /build/glib2.0-prJhLS/glib2.0-2.48.2/./glib/gmain.c:3769
>>> *#8  0x00007ffff74923f0 in g_main_context_iterate (context=0x674810, block=block@entry=1, dispatch=dispatch@entry=1, self=<optimized out>)
>>>     at /build/glib2.0-prJhLS/glib2.0-2.48.2/./glib/gmain.c:3840
>>> *#9  0x00007ffff7492712 in g_main_loop_run (loop=0x66fdf0) at /build/glib2.0-prJhLS/glib2.0-2.48.2/./glib/gmain.c:4034
>>> *#10 0x000000000040dd0f in main (argc=1, argv=0x7fffffffde08) at obexd/src/main.c:322
>>>
>>> Crash was found using Synopsys Defensics Obex Server test suite.
>>> ---
>>>  obexd/src/obex.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
>>> index 788bffc..91fa838 100644
>>> --- a/obexd/src/obex.c
>>> +++ b/obexd/src/obex.c
>>> @@ -825,7 +825,7 @@ static gboolean check_put(GObex *obex, GObexPacket *req, void *user_data)
>>>       struct obex_session *os = user_data;
>>>       int ret;
>>>
>>> -     if (os->service->chkput == NULL)
>>> +     if (os->service->chkput == NULL || os->service_data == NULL)
>>>               goto done;
>>
>> As far as I understand, os->service_data is the OBEX service-specific
>> context, which I think can in principle validly be NULL. Also, isn't it
>> so that OBEX Object Push permits PUT without a preceding CONNECT (at
>> least that's what I remember from the times I was working with OBEX)?
>
> Yep, OPP can start a transfer without a CONNECT so the service_data
> will need to be instantiated directly on PUT if that wasn't created
> yet.
>
>> It seems to me that the bug is with opp.c passing the service_data to
>> manager_request_authorization(), and service_data is expected to be the
>> obex_transfer object. However, currently the code creates this object
>> only upon CONNECT (in opp_connect).
>>
>> I think one possible way to solve this would be to trigger a call to
>> os->service->connect if CONNECT hasn't been explicitly issued, however
>> then the code needs to track this in some other way since service_data
>> seems too unreliable.

How about the following:

https://gist.github.com/Vudentz/1736d6af9608b9332b93858d92a3feff


-- 
Luiz Augusto von Dentz
