Return-Path: <cyrus@holtmann.org>
Subject: Re: duplicate L2CAP connection requests - before and after L2CAP
 information response
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960901262023gebe94c5w9a355d6886b32922@mail.gmail.com>
References: <35c90d960901261529i699411a7jddb81b8d9bef74f8@mail.gmail.com>
	 <B9402F9A-9F2F-4C2B-8F54-24DD213A167A@holtmann.org>
	 <35c90d960901261738t510f7db9v9067c4d70999159f@mail.gmail.com>
	 <AD39F28E-2948-4CD3-9608-4FA48F7F4516@holtmann.org>
	 <35c90d960901262023gebe94c5w9a355d6886b32922@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 09:12:43 +0100
Message-Id: <1233130363.18259.33.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> >>>> We've noticed In some situations Bluez will send duplicate L2CAP
> >>>> connection requests.
> >>>> - Both are due to the same userspace connect() call, and have the same
> >>>> PSM and SCID, but different identifier. So the remote stack cannot
> >>>> send duplicate response because of different identifiers.
> >>>> - The first occurs before receiving L2CAP info response, and the
> >>>> second after due to the l2cap_information_rsp() -> l2cap_conn_start()
> >>>> code path.
> >>>>
> >>>> We are able to reproduce this consistently with basically any A2DP PTS
> >>>> test case. It only happens when the test case is started when already
> >>>> paired. This causes the PTS test case to fail because the tester
> >>>> rejects the second L2CAP request (resource unavailable).
> >>>>
> >>>> We are using 2.6.27. I looked at l2cap.c in bluetooth-testing.git and
> >>>> believe it will have the same issue.
> >>>>
> >>>> Question: to fix, which connection request should be removed?
> >>>
> >>> can you write a small test case for this or use l2test to reproduce it.
> >>> If
> >>> so, then I might be able to fix this quickly. I have currently no clue
> >>> why
> >>> this happens and funny part of that is that we did pass all the BITE test
> >>> cases ;)
> >>
> >> I can reproduce this with
> >>
> >> l2test -n ADDRESS
> >>
> >> The two devices need to be paired first. Here was the hcidump I got
> >> from this repro. This time it was the remote features response that
> >> triggered the duplicate l2cap connection request. I assume it is the
> >> same l2cap_conn_start() path after the feature response that triggers
> >> the duplicate.
> >>
> >> I can also repro this connecting to many A2DP headsets, but most
> >> remote stacks seem to be tolerant of our mistake and let it go. I
> >> guess PTS comes in handy sometimes :)
> >
> > are you actually using a plain 2.6.27 kernel or do you have patched out the
> > L2CAP info stuff. I don't see us sending the requests for that and this
> > might screw up the state machine.
> 
> We have not patched the L2CAP info stuff. In fact we are very close to
> plain 2.6.27, the only significant BT patches we have are
> pause-rfcomm-on-encryption-dropped which is also on
> bluetooth-testing.git.
> 
> Also, you'll notice that in my second hcidump, the problem occurred
> after the remote features response, not the l2cap info response. So
> i'm not sure that the code paths that cause this are specific to the
> L2CAP info response. It seems to be any time that we hit
> l2cap_conn_start() after already sending the request once.

the problem is that even the L2CAP info request should not be sent
before the features response (in case of 2.1 extended features
response).

I think your kernel is wrongly patched. Don't cherry-pick patches that
you don't know the impact of.

> > And please just verify this against bluetooth-testing.git without any other
> > core Bluetooth patches. I really don't see how we end up in your code path
> > except your code is modified.
> 
> Were you able to repo using bluetooth-testing.git?

Just run it on my Quad G5 against my iPhone. It does work perfectly fine
and that is even what the code review showed me.

Regards

Marcel


