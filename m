Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120214132117.GB3145@aemeltch-MOBL1>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328882113-19810-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikZ7Ph3D_fBMLFQ_rh2JDJY2LXPzKWkLcQEsXutcj1idxA@mail.gmail.com>
	<20120213085841.GB21179@aemeltch-MOBL1>
	<20120213144911.GC19288@aemeltch-MOBL1>
	<CAA37ikZPa2bNyw+zcUkr3VFAaA8nz_o+5dhxFHYwOvqg1R8TEw@mail.gmail.com>
	<20120214132117.GB3145@aemeltch-MOBL1>
Date: Tue, 14 Feb 2012 15:23:54 -0200
Message-ID: <CAA37ikY1=K0E+zXtsHO+FRWRK=VEfR99btVBENw_cJEhonfJvw@mail.gmail.com>
Subject: Re: [RFCv4 02/16] Bluetooth: Revert to mutexes from RCU list
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 14, 2012 at 11:21 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Mon, Feb 13, 2012 at 10:06:10PM -0300, Ulisses Furquim wrote:
> ...
>> Yes, I do think they belong together. And please, check l2cap_sock.c
>> where l2cap_chan_close() seems to be called without locking
>> conn->chan_lock in l2cap_sock_shutdown().
>
> In that context we do not always have l2cap_conn so maybe we return
> chan list lock to chan_del or invent unlocked chan_del / chan_close?

We don't have l2cap_conn? So are we already on conn->chan_l list or
not? Maybe it's better to check that instead of changing everything
now.

> So far the easiest way would be first solution.
>
>> And please remove the bogus
>> comment below from l2cap_conn_start, ok?
>
> I believe this is removed in later patches.

If so, then ok, thanks.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
