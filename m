Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKZqhqeN35tGfw3v=rmGY63+27s79K7t2DioRmBEjFCUAtVAXQ@mail.gmail.com>
References: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
	<1351384166-15586-4-git-send-email-dmp0x7c5@gmail.com>
	<CABBYNZJorono572HhGqRrxNT2uDvz2PV1n4rdHs0mWJ8CRKqSg@mail.gmail.com>
	<CAKZqhqeN35tGfw3v=rmGY63+27s79K7t2DioRmBEjFCUAtVAXQ@mail.gmail.com>
Date: Tue, 20 Nov 2012 18:52:42 +0100
Message-ID: <CAKZqhqdB9466=zQ-RQOiN9w8r-oYogscYFEX96xmG+jRaH107A@mail.gmail.com>
Subject: Re: [RFC v2 obexd 04/11] fuse: Add request helpers and setpath operation
From: =?UTF-8?Q?Micha=C5=82_Poczwardowski?= <dmp0x7c5@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Sorry for delay - I was a little overwhelmed by university stuff. I've
just replaced suspend/resume with g_main_context_iteration() but
unfortunately it doesn't work in this case.

Regarding requests queue - fuse handles it, also in single threaded mode :)


On 1 November 2012 22:59, Michał Poczwardowski <dmp0x7c5@gmail.com> wrote:
> Hi Luiz,
>
> On 30 October 2012 10:35, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> Hi Michal,
>>
>> On Sun, Oct 28, 2012 at 2:29 AM, Michał Poczwardowski
>> <dmp0x7c5@gmail.com> wrote:
>>> ---
>>>  fuse/helpers.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 files changed, 108 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/fuse/helpers.c b/fuse/helpers.c
>>> index 856e1d5..1b8082f 100644
>>> --- a/fuse/helpers.c
>>> +++ b/fuse/helpers.c
>>> @@ -273,3 +273,111 @@ void gobexhlp_disconnect(struct gobexhlp_session* session)
>>>
>>>         g_free(session);
>>>  }
>>> +
>>> +void request_new(struct gobexhlp_session *session,
>>> +                                       gchar *name)
>>> +{
>>> +       g_print("REQUEST %s\n", name);
>>> +
>>> +       if (session->request != NULL)
>>> +               g_error("Another request (%s) active!\n",
>>> +                                       session->request->name);
>>> +
>>> +       session->status = 0;
>>> +       session->request = g_malloc0(sizeof(struct gobexhlp_request));
>>> +       session->request->name = name;
>>> +
>>> +       /*
>>> +        * suspend/resume operations recreates g_io_add_watch(),
>>> +        * it fixes obex->io freeze during transfer
>>> +        */
>>> +       g_obex_suspend(session->obex);
>>> +       g_obex_resume(session->obex);
>>
>> It seems the issue here is that the mainloop is blocked then you have
>> to force the io checking by doing g_io_add_watch in a different
>> thread, we have dealt with this kind of problem before using
>> g_main_context_iteration. I would have been better if fuse supported
>> async io, but apparently all operations are blocking.
>>
>> --
>> Luiz Augusto von Dentz
>
> I'll try g_main_context_iteration way to avoid the io freeze.
> Unfortunately fuse with obex should use blocking operations.
>
> Thanks,
> Michal
