Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 30 Nov 2010 16:22:51 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [RFC 2/4] Bluetooth: clean up rfcomm code
Message-ID: <20101130182251.GA9135@vigoh>
References: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1290784965-4508-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20101130010939.GB5919@vigoh>
 <AANLkTimDn_oVX2YMHhEAqyw=YpeYZuX5WL6mr_F463dC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimDn_oVX2YMHhEAqyw=YpeYZuX5WL6mr_F463dC@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2010-11-30 10:41:=
56 +0200]:

> Gustavo,
>=20
> On Tue, Nov 30, 2010 at 3:09 AM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > Hi Andrei,
> >
> > * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-11-26 17=
:22:43 +0200]:
> >
> >> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> >>
> >> Remove extra spaces, assignments in if statement, zeroing static
> >> variables.
> >>
> >> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> >> ---
> >> =A0include/net/bluetooth/rfcomm.h | =A0 18 +++++++++---------
> >> =A0net/bluetooth/rfcomm/core.c =A0 =A0| =A0 =A08 ++++----
> >> =A0net/bluetooth/rfcomm/sock.c =A0 =A0| =A0 =A05 +++--
> >> =A0net/bluetooth/rfcomm/tty.c =A0 =A0 | =A0 28 ++++++++++++++++-------=
-----
> >> =A04 files changed, 32 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rf=
comm.h
> >> index 71047bc..6eac4a7 100644
> >> --- a/include/net/bluetooth/rfcomm.h
> >> +++ b/include/net/bluetooth/rfcomm.h
> >> @@ -1,5 +1,5 @@
> >> -/*
> >> - =A0 RFCOMM implementation for Linux Bluetooth stack (BlueZ).
> >> +/*
> >> + =A0 RFCOMM implementation for Linux Bluetooth stack (BlueZ)
> >> =A0 =A0 Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
> >> =A0 =A0 Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
> >>
> >> @@ -11,13 +11,13 @@
> >> =A0 =A0 OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MER=
CHANTABILITY,
> >> =A0 =A0 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD =
PARTY RIGHTS.
> >> =A0 =A0 IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIA=
BLE FOR ANY
> >> - =A0 CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY =
DAMAGES
> >> - =A0 WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER =
IN AN
> >> - =A0 ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING=
 OUT OF
> >> + =A0 CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY =
DAMAGES
> >> + =A0 WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER =
IN AN
> >> + =A0 ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING=
 OUT OF
> >> =A0 =A0 OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> >>
> >> - =A0 ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATEN=
TS,
> >> - =A0 COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> >> + =A0 ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATEN=
TS,
> >> + =A0 COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> >> =A0 =A0 SOFTWARE IS DISCLAIMED.
> >
> > Marcel refused a patch from me in the past because its was touching leg=
al
> > stuff, so or you remove these changes for your patches or wait for
> > Marcel's comments here.
>=20
> I fixed extra spaces at the end of the sentences, no legal stuff
> touched in legal terms :-)
> I believe that it is better to have legal text identical to other
> parts of the kernel otherwise
> the legal stuff looks different when comparing with diff tools.

I know, but I did the same in the past and got a NACK from Marcel. :)

--=20
Gustavo F. Padovan
http://profusion.mobi
