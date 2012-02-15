Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120215092411.GC920@aemeltch-MOBL1>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328882113-19810-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikZ7Ph3D_fBMLFQ_rh2JDJY2LXPzKWkLcQEsXutcj1idxA@mail.gmail.com>
	<20120213085841.GB21179@aemeltch-MOBL1>
	<20120213144911.GC19288@aemeltch-MOBL1>
	<CAA37ikZPa2bNyw+zcUkr3VFAaA8nz_o+5dhxFHYwOvqg1R8TEw@mail.gmail.com>
	<20120214132117.GB3145@aemeltch-MOBL1>
	<CAA37ikY1=K0E+zXtsHO+FRWRK=VEfR99btVBENw_cJEhonfJvw@mail.gmail.com>
	<20120215081650.GA920@aemeltch-MOBL1>
	<20120215092411.GC920@aemeltch-MOBL1>
Date: Wed, 15 Feb 2012 15:26:34 -0200
Message-ID: <CAA37ikZiOhSF2VvPGmtUg+xyQv=aUXyOkcaYNT3wAcdUSnGLNQ@mail.gmail.com>
Subject: Re: [RFCv4 02/16] Bluetooth: Revert to mutexes from RCU list
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Feb 15, 2012 at 7:24 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Wed, Feb 15, 2012 at 10:16:53AM +0200, Emeltchenko Andrei wrote:
>> On Tue, Feb 14, 2012 at 03:23:54PM -0200, Ulisses Furquim wrote:
>> > On Tue, Feb 14, 2012 at 11:21 AM, Emeltchenko Andrei
>> > <Andrei.Emeltchenko.news@gmail.com> wrote:
>> > > Hi Ulisses,
>> > >
>> > > On Mon, Feb 13, 2012 at 10:06:10PM -0300, Ulisses Furquim wrote:
>> > > ...
>> > >> Yes, I do think they belong together. And please, check l2cap_sock.c
>> > >> where l2cap_chan_close() seems to be called without locking
>> > >> conn->chan_lock in l2cap_sock_shutdown().
>> > >
>> > > In that context we do not always have l2cap_conn so maybe we return
>> > > chan list lock to chan_del or invent unlocked chan_del / chan_close?
>> >
>> > We don't have l2cap_conn? So are we already on conn->chan_l list or
>> > not? Maybe it's better to check that instead of changing everything
>> > now.
>
> Maybe this check?
>
>        if (!sk->sk_shutdown) {
> +               struct l2cap_conn *conn = chan->conn;
> +
>                if (chan->mode == L2CAP_MODE_ERTM)
>                        err = __l2cap_wait_ack(sk);
>
>                sk->sk_shutdown = SHUTDOWN_MASK;
>                release_sock(sk);
> +
> +               if (conn)
> +                       mutex_lock(&conn->chan_lock);
>                l2cap_chan_close(chan, 0);
> +               if (conn)
> +                       mutex_unlock(&conn->chan_lock);
> +
>                lock_sock(sk);
>
>                if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
>                        err = bt_sock_wait_state(sk, BT_CLOSED,
>                                                        sk->sk_lingertime);
>
> If it does not look too hackish...

l2cap_chan_del() is already doing the exact same test for conn to
remove it from conn->chan_l or not. Maybe add a comment to make it
more clear?

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
