Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 15:21:20 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 02/16] Bluetooth: Revert to mutexes from RCU list
Message-ID: <20120214132117.GB3145@aemeltch-MOBL1>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328882113-19810-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikZ7Ph3D_fBMLFQ_rh2JDJY2LXPzKWkLcQEsXutcj1idxA@mail.gmail.com>
 <20120213085841.GB21179@aemeltch-MOBL1>
 <20120213144911.GC19288@aemeltch-MOBL1>
 <CAA37ikZPa2bNyw+zcUkr3VFAaA8nz_o+5dhxFHYwOvqg1R8TEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikZPa2bNyw+zcUkr3VFAaA8nz_o+5dhxFHYwOvqg1R8TEw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Mon, Feb 13, 2012 at 10:06:10PM -0300, Ulisses Furquim wrote:
...
> Yes, I do think they belong together. And please, check l2cap_sock.c
> where l2cap_chan_close() seems to be called without locking
> conn->chan_lock in l2cap_sock_shutdown(). 

In that context we do not always have l2cap_conn so maybe we return
chan list lock to chan_del or invent unlocked chan_del / chan_close?

So far the easiest way would be first solution.

> And please remove the bogus
> comment below from l2cap_conn_start, ok?

I believe this is removed in later patches.

Best regards 
Andrei Emeltchenko 

> 
>   /* l2cap_chan_close() calls list_del(chan)
>    *  so release the lock */
> 

