Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Jan 2012 14:58:40 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv0 1/5] Bluetooth: Use locks in RCU updater code
Message-ID: <20120131125837.GA7660@aemeltch-MOBL1>
References: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1327936146-13897-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikb0CdLrhsDun70kf7WFFZ46qsOHtFX20HooH-sMWdiuoQ@mail.gmail.com>
 <20120131075928.GA15048@aemeltch-MOBL1>
 <CAA37ikZ2zio7D6_r1==b7YKr3Rv9RXw1BBuKTgOqDcW3iSOxiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAA37ikZ2zio7D6_r1==b7YKr3Rv9RXw1BBuKTgOqDcW3iSOxiQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Jan 31, 2012 at 10:37:38AM -0200, Ulisses Furquim wrote:
> On Tue, Jan 31, 2012 at 5:59 AM, Emeltchenko Andrei
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > On Mon, Jan 30, 2012 at 03:17:15PM -0200, Ulisses Furquim wrote:
> >> I was under the impression you'd remove RCU for conn->chan_l
> >> completely. You're adding a lock only in the updaters? If so, please
> >> take a look at commit 3d57dc680 which shows all changes from mutex to
> >> RCU. I don't think just adding a lock/unlock in l2cap_conn_start and
> >> l2cap_conn_del will be enough. l2cap_chan_add seems to be called from
> >> other contexts and it does a list_add_rcu(). Have you thought of that?
> >
> > I am adding lock to updaters and to the places we need to sleep and
> > rcu_read_lock cannot be used. This patch adds locks to updaters and
> > following patches cover other places. Maybe I need to split them better.
> 
> It needs to be split better, yes. And if you're adding a mutex also in
> some readers of the list instead of using RCU I believe it'd be better
> to just use a mutex and remove RCU usage altogether. That will be
> possibly just a revert of 3d57dc6806, but you need to check that.

I actually do think that this will be better, in next patches I will
revert the commit mentioned.

Best regards 
Andrei Emeltchenko 
