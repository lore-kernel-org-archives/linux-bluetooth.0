Return-Path: <cyrus@holtmann.org>
Message-ID: <1346146381.9800.56.camel@pohly-mobl1.fritz.box>
Subject: Re: [PATCH obexd 7/7] client-doc: Update documentation of
 PhonebookAccess interface
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 28 Aug 2012 11:33:01 +0200
In-Reply-To: <CABBYNZKi47Nigic1w=bZonOMf8FM5A=bz+aQoBaM9PnGsALxkg@mail.gmail.com>
References: <1345816795-14092-1-git-send-email-luiz.dentz@gmail.com>
	 <1345816795-14092-7-git-send-email-luiz.dentz@gmail.com>
	 <1346137014.9800.19.camel@pohly-mobl1.fritz.box>
	 <CABBYNZKi47Nigic1w=bZonOMf8FM5A=bz+aQoBaM9PnGsALxkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2012-08-28 at 10:52 +0300, Luiz Augusto von Dentz wrote:
> On Tue, Aug 28, 2012 at 9:56 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> > What about selecting the bits which don't have a named property
> > associated with them? They are reported by ListFilterFields() and thus
> > seem to be supported.
> 
> ListFilterFields is removed in this case,

I find it useful, please don't remove it.

>  anyway setting bits is still
> supported but Im not so sure I would keep it since apparently there is
> no way to discover what they mean which could be different from stack
> to stack.

The user of a specific device would have to know that.

SyncEvolution's "exclude fields" logic is based on the assumption that
requesting everything, including the custom bits, will result in
everything the device supports, just like not specifying any filter at
all.

> > Should the API spec really specify the full list? IMHO the documentation
> > should make it clear that the list is not exhaustive - more fields might
> > be added in future releases of the PBAP standard and obexd, without
> > changing the obexd API.
> 
> If we can discover what the bits mean then yes, but unfortunately this
> is hardcoded in the PBAP spec (see page 30), so we are only defining
> the one we know the meaning.

It's okay to only document those, but it should still allow the use of
the other things. Otherwise a user of the API would have to patch obexd
to use the extensions.

> > In SyncEvolution, I use ListFilterFields() to a) do sanity checks on
> > user input and to b) build a list of all fields from which the user can
> > exclude specific fields. Because the field list is not hard-coded, that
> > will work for fields which are not defined yet.
> 
> As you can see from the spec this is pretty static so adding a round
> trip to discover the list sounds wrong to me,

Hard-coding it in SyncEvolution seems equally wrong to me. If the list
changes, then only obexd needs to be updated, not "obexd +
SyncEvolution".

It's only one round-trip per session. As a tradeoff between performance
and being future-proof I think doing the call is worth it.

-- 
Best Regards

Patrick Ohly
Senior Software Engineer

Intel GmbH
Open Source Technology Center               
Pützstr. 5                              Phone: +49-228-2493652
53129 Bonn
Germany

