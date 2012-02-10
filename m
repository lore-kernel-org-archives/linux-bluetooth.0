Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 10 Feb 2012 10:54:44 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Peter Krystad <pkrystad@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Getting L2CAP ERTM support into better upstream state
Message-ID: <20120210125444.GB5022@joana>
References: <1328678855.28848.6.camel@aeonflux>
 <20120208090945.GB5917@aemeltch-MOBL1>
 <CABBYNZ+v5fjUXML7Yq=Xxs_37yOcdPhgr2eLWgPKOyY=LqEQwA@mail.gmail.com>
 <CAA37ikYNVFdWf_ZAGCfY6rrYeO7054n3y_uwn5f04Xzz9g0Mpw@mail.gmail.com>
 <alpine.DEB.2.02.1202081221280.25089@mathewm-linux>
 <CAA37ikb5n0PmR7FAZ2-HDRRoKaMEL=_nniuN9Yzm1pCjUk1kPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikb5n0PmR7FAZ2-HDRRoKaMEL=_nniuN9Yzm1pCjUk1kPw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat, Ulisses,

* Ulisses Furquim <ulisses@profusion.mobi> [2012-02-08 23:01:16 -0200]:

> Hi Mat,
>=20
> On Wed, Feb 8, 2012 at 8:33 PM, Mat Martineau <mathewm@codeaurora.org> wr=
ote:
> >
> > On Wed, 8 Feb 2012, Ulisses Furquim wrote:
> >
> >> Hi everybody,
> >>
> >> On Wed, Feb 8, 2012 at 7:32 AM, Luiz Augusto von Dentz
> >> <luiz.dentz@gmail.com> wrote:
> >>>
> >>> Hi Andrei,
> >>>
> >>> On Wed, Feb 8, 2012 at 11:09 AM, Andrei Emeltchenko
> >>> <andrei.emeltchenko.news@gmail.com> wrote:
> >>>>
> >>>>
> >>>> I think this would be good to send as patch series so that people can
> >>>> comment. What comes to my mind is that the patch might be reduced if=
 it
> >>>> does not change order of functions and defines like:
> >>>>
> >
> > ... <snip> ...
> >
> >
> >>>> those magic number does not look nice IMO and the code is not looking
> >>>> any
> >>>> better.
> >>>
> >>>
> >>> In this aspect perhaps, but we don't need to take the code as it is,
> >>> but the point here is following the states defined by the spec and
> >>> that is IMO much better.
> >
> >
> > Right - the code as it stands now was ported quickly, and does not take=
 in
> > to account many of Andrei's upstream improvements. =A0I don't want to m=
ove
> > backwards in terms of magic numbers, and there is some extra noise in t=
here
> > due to symbol names. =A0I need to address these issues before merging.
>=20
> Great.
>=20
> > I'm also looking for ideas on how to do this as a patch series. =A0Sinc=
e it
> > takes a very different approach from the original code, it's hard to ma=
ke
> > meaningful, small patches that don't break functionality. =A0At some po=
int
> > there has to be a major switchover but there is a lot of room to split =
this
> > up.
>=20
> I agree here. You maybe can have some patches introducing new code
> that's going to be used in the commit that really switches the state
> machine handling.


The first step is to do a huge clean up on your patch, people already repor=
ted
many issues here. Then you can send all the macro definitions changes to
l2cap.h. Finally we look to your patch and check how bit it is and decide w=
hat
to do. It's much better waste time looking for bugs in your code than trying
to find a way to split in many patches.
The most important thing is do it fast, we are now in -rc3, we have 4 or 5
weeks until 3.4 merge windows opens.

>=20
> > One approach is to add inactive code until everything is there, then ha=
ve
> > one commit that calls in to the new code instead of the old code. Then =
the
> > old code can be removed. =A0I talked to Gustavo about that a while ago,=
 and he
> > preferred finding a different way. =A0Maybe an intermediate step is to =
put the
> > state machine code in there, but call the existing frame handling funct=
ions
> > in every state.
>=20
> IMO the former approach is better. We could even have a module option
> to activate the new code for testing (have it experimental) and do the
> switch when we're confident it's ready.
>=20
> <snip>
>=20
> >> Marcel mentioned the separation of L2CAP channel and socket. That is a
> >> work in progress by Andrei and judging by what you said, Marcel, you
> >> want that merged before we change ERTM, is that it?
> >
> > Andrei and Marcel, let's figure out this order now. =A0It doesn't make =
sense
> > for one of us to have a bunch of changes staged, only to have major
> > merge/rebase conflicts when another far-reaching patch set gets merged.
>=20
> I'd say we add your changes and then Andrei's when he's ready with
> them. Right now I have the feeling your changes are more mature and
> can be easily merged.
>=20
> >> Mat, thanks a lot for doing this. I have just a few questions. Have
> >> you tested the stack with this patch? How was it? Quickly looking
> >> through the code I feel it's almost there. I agree with Andrei
> >> regarding constants and control field handling but apart from that it
> >> looks good, in general.
> >
> > It's only lightly tested right now. =A0I can do incoming and outgoing
> > connections, and send/receive. =A0It is unstable when disconnecting. =
=A0I have
> > not tested with dropped frames yet.
>=20
> Ok.
>=20
> >> Regarding delayed work handling, are you sure about usage of
> >> __cancel_delayed_work()? I do think it's safer to use
> >> cancel_delayed_work() instead as it'll just spin on a lock if the
> >> timer to queue the work is running on another CPU.
> >
> > This code is coming from a kernel that still had code running in tasklet
> > context that couldn't block, and the delayed work handlers were written=
 such
> > that it was ok if the functions were called after cancel. =A0I will upd=
ate to
> > the safer cancel_delayed_work().
>=20
> I see. I haven't really checked the handlers but it's less error prone
> to guarantee that if we cancel a delayed work as soon as the function
> returns the handler won't be queued on our back. And I say that
> thinking of keeping it simpler to maintain. Also cancel_delayed_work()
> never sleeps, it can only spin on a spinlock waiting for the timer
> handler to return to guarantee the work won't be queued again.
>=20
> >> I saw a comment about channel ref counting and kind of audit that
> >> would be great. It'd be good to see a patch for that after transition
> >> to new state handling.
> >
> > The "do channel ref counting" comment is there because I saw that the
> > existing ack/monitor/retrans timers do that. =A0I will fix this up befo=
re
> > submitting.
>=20
> Ok.
>=20
> > Thanks for the feedback, everyone. =A0Please let me know if you have
> > preferences for how to structure this patch set. =A0I'll work on the is=
sues
> > mentioned in this thread and start splitting up the changes.
>=20
> We need to hear from Marcel and Padovan if they agree with us. I do
> think you can introduce new stuff with small commits and then have one
> commit to add the bulk of it with the module option to enable it. Then
> we test that and make it default later.

If the concern here is that the current ERTM implementation does not work I=
'd
rather completely remove it and add the new one, no module options to choos=
e.

	Gustavo
