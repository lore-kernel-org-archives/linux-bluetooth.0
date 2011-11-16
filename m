Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ+vzT5Sp_pJyHWaO-=5N-wGgFmphSc4aphykaHchBXqQ@mail.gmail.com>
References: <1321368294-29379-1-git-send-email-bulislaw@linux.com>
	<CABBYNZLMKiRjuc9de0g_26PW=OAmAgJfOSRaCFMHBSPSHjbnig@mail.gmail.com>
	<CAPGrrxWX2VupSpvh+sz57mdagCXExtkM5r=dHVAz0xQLnqwz6Q@mail.gmail.com>
	<CABBYNZJ+vzT5Sp_pJyHWaO-=5N-wGgFmphSc4aphykaHchBXqQ@mail.gmail.com>
Date: Wed, 16 Nov 2011 12:49:09 +0100
Message-ID: <CA+i+Aw2UJMhfegpB3Odmzyhv9khYKtt-9tJzX1Y2kXDqsgCCgQ@mail.gmail.com>
Subject: Re: [PATCH] gobex: Fix setpath to match one from OBEX spec
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Szatkowski <bulislaw@linux.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 16, 2011 at 12:12 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Bartosz,
>
> On Wed, Nov 16, 2011 at 10:24 AM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
>>
>> Come on did You even read it?? This function is OBEX level (an it
>> works before in similar way - only one dir at a time) - we may don't
>> like specification, but seriously? Just read the patch, i exposed on
>> OBEX level stuff defined in the OBEX specification (as MAP needs
>> operation like "go one level up and than down" in one step) and as it
>> would be possible to just add some "if" for "../dir" in previous
>> version, but it is better to fix broken things than to propagate them
>> (it's obex level function not high level abstraction - deal with it).
>
> Yeah, lets create an API that we don't use, really? Your MAP API need
> it but that doesn't mean we agree on using it as it is, that table you
> use to explain how it works is already a sign that it is

I guess the table I've seen in Bartek's proposal is rather graphical
representation that serves an example. I think that simply saying that
"cdup" goes up one level before going to child directory would be also
understandable and not really confusing.

> over-engineered and will be easily misinterpreted by applications. We
> will not break MAP by not exposing this complexity since we can still
> do it transparently, even doing cdup and another SetPath although
> inefficient would still work.

The function itself is quite useful for MAP clients. There is this
fixed part of directories structure in MAP, which is:

telecom
 '- msg
     |- inbox
     |- outbox
     |- sent
     |- deleted
     '- draft

There are no messages in msg, thus going from e.g. outbox to sent
directly seems convenient.

I do not understand why you are so reluctant to have function for
setting path in gobex that actually offers what OBEX offers. As I
mentioned already in discussion about MAP API proposal, this also
gives additional restrictions on what characters one can use in folder
name.

You at least have one example of profile that could have make use of
it. So it won't be in effect anything that is not used.

>> Each profile may use it multiple times for paths delivered through
>> dbus (but it provokes some questions, that i don't like). Generally
>> there is REALLY many gui that works like that (one level down or up at
>> a time) just look around (eg all file explorers) and it's all you
>> need, because its basically same context!
>
> Same context? What context, the folder listing is per folder, besides
> nowadays the file explores have abandon the tree view in favor of more
> simple one level like nautilus. But even with gui that uses tree view
> we can only jump one level or to the root so it is not that it would
> save that much of time.

-- 
Slawomir Bochenski
