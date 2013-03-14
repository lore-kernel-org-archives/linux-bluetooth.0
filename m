Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130314200055.GE2649@samus>
References: <1363285326-20089-1-git-send-email-deymo@chromium.org>
 <1363285326-20089-4-git-send-email-deymo@chromium.org> <20130314200055.GE2649@samus>
From: Alex Deymo <deymo@chromium.org>
Date: Thu, 14 Mar 2013 13:32:27 -0700
Message-ID: <CAGd9gwjK_9pJ2ooRT2NLDRxwk4mToZ3cPxEjPj1mz8n0P_52Aw@mail.gmail.com>
Subject: Re: [PATCH 3/6] "agent" command capability argument and autocompletion
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org, marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the comments.
agent_capability_options[] was intended to be use in
parse_argument_agent(), but I finally reused agent_arguments[] since
the two extra cases (on, off) are handled before. I'll fix this (and
the indentation thing).

> > +     if (!arg || !strlen(arg)) {
> Even if it's not strictly enforced, in userspace code there's a tendency to
> use explicit checks for NULL and 0.
>
> This also applies for the strcmp()'s that are done just bellow.

I'm not sure if I properly understand this comment. If arg is NULL it
will fall in the first return FALSE, not calling any strcmp() because
of the lazy or operator, right?

Alex.
