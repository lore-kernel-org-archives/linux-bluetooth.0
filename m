Return-Path: <cyrus@holtmann.org>
Message-ID: <1345652387.29868.357.camel@pohly-mobl1.fritz.box>
Subject: Re: [PATCH obexd v0] client-doc: Guarantee prefix in transfer paths
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Wed, 22 Aug 2012 18:19:47 +0200
In-Reply-To: <CABBYNZLmM4DNUr031d_2MrDczN+K6-przkUFzWNkR7UTrxWf9w@mail.gmail.com>
References: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1345537878.29868.185.camel@pohly-mobl1.fritz.box>
	 <CABBYNZLUS-BrZ=FN28gLgrA=1vS1JA-exECd3xgjj2EfPrAuyw@mail.gmail.com>
	 <1345637062.29868.313.camel@pohly-mobl1.fritz.box>
	 <CABBYNZLmM4DNUr031d_2MrDczN+K6-przkUFzWNkR7UTrxWf9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2012-08-22 at 15:52 +0300, Luiz Augusto von Dentz wrote:
> Hi Patrick,
> 
> On Wed, Aug 22, 2012 at 3:04 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> > On Wed, 2012-08-22 at 14:39 +0300, Luiz Augusto von Dentz wrote:
> >> Hi Patrick,
> >>
> >> On Tue, Aug 21, 2012 at 11:31 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> >> > It would be even better to explicitly mention that the "[variable
> >> > prefix]" here is the same as the "[variable prefix]" in the Session.
> >> >
> >> > Or perhaps change it like this?
> >> >
> >> > -Object path    [variable prefix]/{transfer0,transfer1,...}
> >> > +Object path    [session prefix]/{transfer0,...}
> >>
> >> Hmm, I prefer the original proposal since that imo looks more clear
> >> how the path is formatted, anyway the point here is that the transfers
> >> are tied to sessions.
> >
> > But as Marcel said, "variable prefix" means "no guarantee made about its
> > content, none whatsoever". Without knowing Bluez conventions, that was
> > also my understand when reading the API description. Assigning some
> > other meaning to "variable prefix" would break with developer
> > expectations.
> 
> But we are not changing that, that why we return the object path to
> you, you will never have to guess it.

Knowing the path in advance is relevant for the client so that it can
set up an efficient signal watch before starting the transfer. That in
turn is needed to avoid race conditions. At the time that the client is
told the final path, it may already be too late to do anything with the
path.

> > Unless the meaning of "variable prefix" gets redefined, "[variable
> > prefix]/{session0,session1,...}" still doesn't allow the developer to do
> > path_namespace filtering.
> 
> Im not sure why this is important? Prefix or variable prefix it does
> not matter, you will not be able to hardcode nor you should be
> constructing a path based on the session prefix, so if you are
> planning to do prefix matching I would strongly advise not to.

The prefix would not be hard-coded. The steps would be:
- create a session
- register for Transfer signals with a path prefix filter for the
  session path as returned by obexd
- start a transfer
- process the signals

Currently this is not correct behavior, because the API makes no
guarantee about the "[variable prefix]" of Transfer objects. Therefore
clients have to receive and process *all* Transfer signals to avoid the
race condition described in the "obexd client API" mail.

I thought the purpose of the patch was to add that guarantee to the API
description.

> > I can imagine three ways to address race conditions:
> > 1. Clients subscribe to signals in advance, before any are sent.
> 
> Can be done already, but it means you have to listen to every transfer
> which can cause you application to wakeup a little too much.

Exactly.

> > 2. Clients subscribe to signals later *and* check the current state.
> > 3. Clients provide a callback object with methods which get invoked by
> >    obexd.
> >
> > The second option increases traffic and depends on being able to check
> > the current state. Currently this approach is not possible for Transfer
> > objects because they can get removed before the client checked their
> > state.
> 
> I don't thing this is true, we do return the properties of the
> transfer so you don't need to check the current state just listen for
> changes,

Listen for changes *in advance* (given the current API). The returned
properties might already be out-dated. The path information is useful,
the completion state not so much. If it says "not complete yet", the
client needs a way to check for completion or failure reliably.

> btw if you mean a method call for checking the current state
> it does happen to have the same race conditions.

Right. To make it work, the life cycle of Transfer objects would have to
be changed.

> > The third option has the drawback that there's no standard way of
> > letting the client declare which of these methods it wants to have
> > called (in contrast to D-Bus signals). The advantage is that it becomes
> > possible to clean up temp files after completion of the transfer: add an
> > explicit "here's your result" callback method and when that fails,
> > delete the temporary file.
> 
> We normally used the term agent for this type of object that is
> registered to act as callback mechanism, in fact this was used before
> and was just replaced with the current design recently as it was
> considered more complicated to the client application to implement and
> did not allow any other application like a download manager to listen
> for transfer progress.

Valid points. I included the option primarily for the sake of
completeness.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


