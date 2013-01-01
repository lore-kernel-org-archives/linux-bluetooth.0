Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PpJOVALj5xJvCRA4mC6WAMyP5RsqHVruz6xaRBDhXg5A@mail.gmail.com>
References: <1356862632-5938-1-git-send-email-g.gherdovich@gmail.com>
	<CAJdJm_PpJOVALj5xJvCRA4mC6WAMyP5RsqHVruz6xaRBDhXg5A@mail.gmail.com>
Date: Tue, 1 Jan 2013 11:19:44 +0100
Message-ID: <CAJN7YmNzo1ya34tdgyffcBf=SLt4RsJ=2QaSy3fD6meKx7wnsA@mail.gmail.com>
Subject: Re: [PATCH 1/1] adapter, AVCTP: Replaced calls to g_queue_free_full function
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

thank you for your review.
A few comments below.

2012/12/30 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> [...]
>> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
>> index 013c587..745ced8 100644
>> --- a/profiles/audio/avctp.c
>> +++ b/profiles/audio/avctp.c
>> @@ -395,7 +395,8 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
>>                 g_source_remove(chan->process_id);
>>
>>         g_free(chan->buffer);
>> -       g_queue_free_full(chan->queue, pending_destroy);
>> +       g_queue_foreach(chan->queue, (GFunc)pending_destroy, NULL);
>> +       g_queue_free(chan->queue);
>
> Where possible, try to avoid using casts for functions. In this case,
> try removing "(GFunc)" and see if code still compiles cleanly with
> "./bootstrap-configure && make".

You rise a very good point here.
In this case, just removing the cast doesn't work:
the function "g_queue_foreach" is expecting an object of type

void (*) (void *, void *)

as second argument, while "pending_destroy" has type

void (*) (void *)

"GFunc" is a typedef to "void (*) (void *, void *)", and the
cast is required to make the code compile and run.

This brings us to the central issue: the patch I submitted,
as well as the GLib code from which I cut-and-pasted the body
of the function g_queue_free_full, strictly speaking
relies on "undefined behaviour", since you cast a function pointer
to another of incompatible type.
In this stackoverflow thread somebody offers an extract of
the C standard where this issue is discussed:
http://stackoverflow.com/questions/559581/casting-a-function-pointer-to-another-type

I submitted a question to the GLib developers, asking them
why they do so and how they expect their code to work:
https://mail.gnome.org/archives/gtk-devel-list/2012-December/msg00061.html

I will quote here the answer I got, since it wasn't stored in their
mailing list archives, and the argument makes a lot of sense in my opinion:

"
In order to support varargs ('...', http://en.wikipedia.org/wiki/Stdarg.h)
C compilers put function call arguments backwards on the stack. This allows
functions that don't care about extra arguments to simply not offset
back far enough
on the stack to notice them. No modern C compiler excludes support
for varargs and glib relies on varargs anyway.
So its not really an issue."

Which is: you can cast a unary function to a binary function type;
the extra argument will just be ignored, even if the standard takes
a more safe approach and says "don't do that".

My understanding is that the real danger is if you do the opposite cast,
i.e. a binary function f casted to a unary function type:
you will then feed to f less arguments that it expects,
and it will then corrupt the stack looking for the missing input.

In order to solve this special issue in the BlueZ codebase in
a standard-compliant way, one would have to rewrite the function
"g_queue_foreach" so that it takes a unary function as second argument;
but as far as I understood, GLib code relies heavily on this kind
of "forbidden casts"; here another message from last week where a
developer was asking a question very similar to mine,
https://mail.gnome.org/archives/gtk-devel-list/2012-December/msg00032.html
and the answer is basically: "you found just one of the many instances
where we do that, and in practice it works just fine."

To summarize:
I am resubmitting my patch amended with all your requests apart from
the casting issue. If you still have strong objections against it,
I will re-submit again rewriting the function "g_queue_foreach"
with the right prototype, taking it out from GLib and putting it in
"Bluez space".

Regards,
Giovanni
