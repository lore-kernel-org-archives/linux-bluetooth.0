Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Feb 2012 10:16:53 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 02/16] Bluetooth: Revert to mutexes from RCU list
Message-ID: <20120215081650.GA920@aemeltch-MOBL1>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328882113-19810-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikZ7Ph3D_fBMLFQ_rh2JDJY2LXPzKWkLcQEsXutcj1idxA@mail.gmail.com>
 <20120213085841.GB21179@aemeltch-MOBL1>
 <20120213144911.GC19288@aemeltch-MOBL1>
 <CAA37ikZPa2bNyw+zcUkr3VFAaA8nz_o+5dhxFHYwOvqg1R8TEw@mail.gmail.com>
 <20120214132117.GB3145@aemeltch-MOBL1>
 <CAA37ikY1=K0E+zXtsHO+FRWRK=VEfR99btVBENw_cJEhonfJvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAA37ikY1=K0E+zXtsHO+FRWRK=VEfR99btVBENw_cJEhonfJvw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Feb 14, 2012 at 03:23:54PM -0200, Ulisses Furquim wrote:
> On Tue, Feb 14, 2012 at 11:21 AM, Emeltchenko Andrei
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > Hi Ulisses,
> >
> > On Mon, Feb 13, 2012 at 10:06:10PM -0300, Ulisses Furquim wrote:
> > ...
> >> Yes, I do think they belong together. And please, check l2cap_sock.c
> >> where l2cap_chan_close() seems to be called without locking
> >> conn->chan_lock in l2cap_sock_shutdown().
> >
> > In that context we do not always have l2cap_conn so maybe we return
> > chan list lock to chan_del or invent unlocked chan_del / chan_close?
> 
> We don't have l2cap_conn? So are we already on conn->chan_l list or
> not? Maybe it's better to check that instead of changing everything
> now.

I am afraid that the logic in l2cap_chan_close is a bit complicated, for
listening socket is recursively invokes itself for every sk in accept
queue. conn is created when connection is established, before that chan is
added only to global chan list. So if there is no connection we cannot get
lock in conn->chan_lock.

I believe that it is better to keep locking inside of chan_del.

Best regards 
Andrei Emeltchenko 

