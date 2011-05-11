Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 May 2011 17:52:19 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: fix shutdown on SCO sockets
Message-ID: <20110511205219.GI22065@joana>
References: <1302271841-12127-1-git-send-email-luiz.dentz@gmail.com>
 <20110415185845.GB2359@joana>
 <BANLkTin2kuhT9vyANhLHTqw8G8maTEbQWg@mail.gmail.com>
 <20110418175619.GB2472@joana>
 <BANLkTikgZBh5SyXJvFE6z+F2V-JxC5Y9YQ@mail.gmail.com>
 <20110511170951.GB22065@joana>
 <BANLkTimatFYD2Jn1o0DqxKpv+RRC6+3uSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTimatFYD2Jn1o0DqxKpv+RRC6+3uSg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-05-11 23:49:51 +0300]:

> Hi Gustavo,
> 
> On Wed, May 11, 2011 at 8:09 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > Hi Luiz,
> >
> > * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-05-05 17:50:53 +0300]:
> >
> >> Hi Gustavo,
> >>
> >> On Mon, Apr 18, 2011 at 8:56 PM, Gustavo F. Padovan
> >> <padovan@profusion.mobi> wrote:
> >> > * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-04-17 20:26:53 +0300]:
> >> >
> >> >> Hi Gustavo,
> >> >>
> >> >> On Fri, Apr 15, 2011 at 9:58 PM, Gustavo F. Padovan
> >> >> <padovan@profusion.mobi> wrote:
> >> >> > Hi Luiz,
> >> >> >
> >> >> > * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-04-08 17:10:41 +0300]:
> >> >> >
> >> >> >> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> >> >> >>
> >> >> >> shutdown should wait for SCO link to be properly disconnected before
> >> >> >> detroying the socket, otherwise an application using the socket may
> >> >> >> assume link is properly disconnected before it really happens which
> >> >> >> can be a problem when e.g synchronizing profile switch.
> >> >> >>
> >> >> >> Signed-off-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> >> >> >
> >> >> > I applied it, but in bluetooth-next. Let's see its behaviour there and if no
> >> >> > problems show up we can move it to bluetooth-2.6
> >> >>
> >> >> I tested this against Nokia BH-504 and Sony Ericsson W600, both have
> >> >> problem when switching from hfp to a2dp where the avdtp start is sent
> >> >> before SCO is fully disconnected, this patch fixes with those
> >> >> headsets.
> >> >
> >> > Ok, I also pushed it to bluetooth-2.6.
> >>
> >>
> >> Apparently this cause a regression, since we set conn to NULL but an
> >> application may not wait for shutdown to complete and call
> >> close/release which will cause sco_chan_del to be called which destroy
> >> the socket without resetting conn->sk to NULL so on disconn_cfm it
> >> will access invalid memory.
> >>
> >> To fix this what about the following:
> >>
> >> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> >> index 94954c7..cb4fb78 100644
> >> --- a/net/bluetooth/sco.c
> >> +++ b/net/bluetooth/sco.c
> >> @@ -373,7 +373,7 @@ static void __sco_sock_close(struct sock *sk)
> >>                         sk->sk_state = BT_DISCONN;
> >>                         sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
> >>                         hci_conn_put(sco_pi(sk)->conn->hcon);
> >> -                       sco_pi(sk)->conn = NULL;
> >> +                       sco_pi(sk)->conn->hcon = NULL;
> >>                 } else
> >>                         sco_chan_del(sk, ECONNRESET);
> >>                 break;
> >> @@ -828,7 +828,9 @@ static void sco_chan_del(struct sock *sk, int err)
> >>                 conn->sk = NULL;
> >>                 sco_pi(sk)->conn = NULL;
> >>                 sco_conn_unlock(conn);
> >> -               hci_conn_put(conn->hcon);
> >> +
> >> +               if (conn->hcon)
> >> +                       hci_conn_put(conn->hcon);
> >
> > I think first we need to revert the patch on linus' tree. There isn't time to
> > a proper fix and test. It may have introduced other bugs too. I don't wanna
> > take this risk.
> 
> Ville and I tested the suggested changes and see no regression
> anymore, so I can either create a new patch or update the other in
> case we revert it.

So update the patch and resend, I already asked Linus to revert it.

-- 
Gustavo F. Padovan
http://profusion.mobi
