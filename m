Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-2?Q?RISK=D3?= Gergely <gergely@risko.hu>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,  linux-bluetooth@vger.kernel.org,  Context Devel mailing list <context-devel@projects.maemo.org>
Subject: Re: [PATCH] Add introspection interface to the output of introspection calls.
References: <87k50hoee1.fsf@bubble.risko.hu>
	<2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com>
	<87pra9nspo.fsf@bubble.risko.hu> <20090914141816.GA17774@jh-x301>
	<871vm9fuis.fsf@bubble.risko.hu> <20090914211145.GA16947@jh-x301>
	<2d5a2c100909150350r2e453cb6h5c4fe95c8638f9e9@mail.gmail.com>
	<87ws40e6iz.fsf@bubble.risko.hu> <20090915152240.GA4378@jh-x301>
	<1253035625.28416.2.camel@localhost.localdomain>
	<20090915175523.GA8393@jh-x301>
Date: Tue, 15 Sep 2009 22:25:28 +0300
In-Reply-To: <20090915175523.GA8393@jh-x301> (Johan Hedberg's message of "Tue,
	15 Sep 2009 20:55:23 +0300")
Message-ID: <877hw057tj.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, 15 Sep 2009 20:55:23 +0300, Johan Hedberg <johan.hedberg@gmail.com> writes:

> Hi Marcel,
>
> On Tue, Sep 15, 2009, Marcel Holtmann wrote:
>> what are we gaining from doing it like this? I really don't see the
>> benefit of doing it. Someone please explain it to me. It does add more
>> code than it deletes.
>
> It's about avoiding special-casing the Introspect method and using the
> framework that gdbus already has for method callbacks. This feels like a
> cleaner approach to me and with the two refactoring tasks I suggested I
> suspect we'd also be reducing the total line count (the current patch adds
> 15 lines to the total but there's something like 15-20 new lines in it
> that unnecessarily duplicate exsiting code).

Yes, and actually I totally agree about all of your comments, so it was
just my too big hurry, why even code with C++ comment could enter the
mailing list.

I will fix the issues and send a new patch tomorrow, thanks for the
comments.

Gergely
