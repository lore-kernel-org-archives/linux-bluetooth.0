Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Mar 2013 17:41:49 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org,
	marcel@holtmann.org
Subject: Re: [PATCH 3/6] "agent" command capability argument and
 autocompletion
Message-ID: <20130314204149.GF2649@samus>
References: <1363285326-20089-1-git-send-email-deymo@chromium.org>
 <1363285326-20089-4-git-send-email-deymo@chromium.org>
 <20130314200055.GE2649@samus>
 <CAGd9gwjK_9pJ2ooRT2NLDRxwk4mToZ3cPxEjPj1mz8n0P_52Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGd9gwjK_9pJ2ooRT2NLDRxwk4mToZ3cPxEjPj1mz8n0P_52Aw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On 13:32 Thu 14 Mar, Alex Deymo wrote:
> Thanks for the comments.
> agent_capability_options[] was intended to be use in
> parse_argument_agent(), but I finally reused agent_arguments[] since
> the two extra cases (on, off) are handled before. I'll fix this (and
> the indentation thing).
> 
> > > +     if (!arg || !strlen(arg)) {
> > Even if it's not strictly enforced, in userspace code there's a tendency to
> > use explicit checks for NULL and 0.
> >
> > This also applies for the strcmp()'s that are done just bellow.
> 
> I'm not sure if I properly understand this comment. If arg is NULL it
> will fall in the first return FALSE, not calling any strcmp() because
> of the lazy or operator, right?

I was referring to the fact that in BlueZ (userspace code) the idiom
"strcmp(x, y) == 0" is more common than "!strcmp(x, y)". But I agree that
I wasn't clear enough.

> 
> Alex.


Cheers,
-- 
Vinicius
