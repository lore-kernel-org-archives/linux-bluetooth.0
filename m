Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Dec 2010 19:16:35 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/4] Bluetooth: clean up sco code
Message-ID: <20101201211635.GD16125@vigoh>
References: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1290784965-4508-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <AANLkTi=_a1omXZdLXg_eEqDD7c0h=f0FgnTnxn1DvGDQ@mail.gmail.com>
 <AANLkTikfeMqq-4fTRHwmL81TDnF2=sQsMhL9o7GoEcX2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikfeMqq-4fTRHwmL81TDnF2=sQsMhL9o7GoEcX2@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei, 

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2010-12-01 15:44:50 +0200]:

> Hi,
> 
> On Fri, Nov 26, 2010 at 6:14 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > Hi Andrei,
> >
> > On Fri, Nov 26, 2010 at 11:22 AM, Emeltchenko Andrei
> > <Andrei.Emeltchenko.news@gmail.com> wrote:
> >> @@ -828,13 +831,14 @@ static void sco_chan_del(struct sock *sk, int err)
> >>
> >>  static void sco_conn_ready(struct sco_conn *conn)
> >>  {
> >> -       struct sock *parent, *sk;
> >> +       struct sock *parent;
> >> +       struct sock *sk = conn->sk;
> >
> > I wonder if there is a problem with accessing conn->sk here outside
> > the lock protection?
> 
> I believe here is a safe access. We just acquire pointer and possible
> protected operations
> are executed inside lock.

Agreed.

-- 
Gustavo F. Padovan
http://profusion.mobi
