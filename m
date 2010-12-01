Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 2/4] Bluetooth: clean up rfcomm code
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTimDn_oVX2YMHhEAqyw=YpeYZuX5WL6mr_F463dC@mail.gmail.com>
References: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1290784965-4508-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <20101130010939.GB5919@vigoh>
	 <AANLkTimDn_oVX2YMHhEAqyw=YpeYZuX5WL6mr_F463dC@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Dec 2010 11:45:56 +0100
Message-ID: <1291200356.4795.93.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-11-26 17:22:43 +0200]:
> >
> >> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> >>
> >> Remove extra spaces, assignments in if statement, zeroing static
> >> variables.
> >>
> >> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> >> ---
> >>  include/net/bluetooth/rfcomm.h |   18 +++++++++---------
> >>  net/bluetooth/rfcomm/core.c    |    8 ++++----
> >>  net/bluetooth/rfcomm/sock.c    |    5 +++--
> >>  net/bluetooth/rfcomm/tty.c     |   28 ++++++++++++++++------------
> >>  4 files changed, 32 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
> >> index 71047bc..6eac4a7 100644
> >> --- a/include/net/bluetooth/rfcomm.h
> >> +++ b/include/net/bluetooth/rfcomm.h
> >> @@ -1,5 +1,5 @@
> >> -/*
> >> -   RFCOMM implementation for Linux Bluetooth stack (BlueZ).
> >> +/*
> >> +   RFCOMM implementation for Linux Bluetooth stack (BlueZ)
> >>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
> >>     Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
> >>
> >> @@ -11,13 +11,13 @@
> >>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> >>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
> >>     IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
> >> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
> >> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> >> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> >> +   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
> >> +   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> >> +   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> >>     OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> >>
> >> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> >> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> >> +   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> >> +   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> >>     SOFTWARE IS DISCLAIMED.
> >
> > Marcel refused a patch from me in the past because its was touching legal
> > stuff, so or you remove these changes for your patches or wait for
> > Marcel's comments here.
> 
> I fixed extra spaces at the end of the sentences, no legal stuff
> touched in legal terms :-)
> I believe that it is better to have legal text identical to other
> parts of the kernel otherwise
> the legal stuff looks different when comparing with diff tools.

make it a separate patch and not just fix it while at it.

Regards

Marcel


