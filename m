Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120131075928.GA15048@aemeltch-MOBL1>
References: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1327936146-13897-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikb0CdLrhsDun70kf7WFFZ46qsOHtFX20HooH-sMWdiuoQ@mail.gmail.com>
	<20120131075928.GA15048@aemeltch-MOBL1>
Date: Tue, 31 Jan 2012 10:37:38 -0200
Message-ID: <CAA37ikZ2zio7D6_r1==b7YKr3Rv9RXw1BBuKTgOqDcW3iSOxiQ@mail.gmail.com>
Subject: Re: [RFCv0 1/5] Bluetooth: Use locks in RCU updater code
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Jan 31, 2012 at 5:59 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> On Mon, Jan 30, 2012 at 03:17:15PM -0200, Ulisses Furquim wrote:

<snip>

>> I was under the impression you'd remove RCU for conn->chan_l
>> completely. You're adding a lock only in the updaters? If so, please
>> take a look at commit 3d57dc680 which shows all changes from mutex to
>> RCU. I don't think just adding a lock/unlock in l2cap_conn_start and
>> l2cap_conn_del will be enough. l2cap_chan_add seems to be called from
>> other contexts and it does a list_add_rcu(). Have you thought of that?
>
> I am adding lock to updaters and to the places we need to sleep and
> rcu_read_lock cannot be used. This patch adds locks to updaters and
> following patches cover other places. Maybe I need to split them better.

It needs to be split better, yes. And if you're adding a mutex also in
some readers of the list instead of using RCU I believe it'd be better
to just use a mutex and remove RCU usage altogether. That will be
possibly just a revert of 3d57dc6806, but you need to check that.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
