Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Aug 2012 17:46:02 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Dean Jenkins <djenkins@mvista.com>
Cc: Frederic Danis <frederic.danis@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: RFCOMM disconnection problem
Message-ID: <20120809144555.GB2683@aemeltch-MOBL1>
References: <501BC0D5.8080403@linux.intel.com>
 <501BC282.9070509@linux.intel.com>
 <CAJ2qBzaLyPiwEcd2n5Kdu_Y4KMpYjvjGo+Ddk3RC1Cf6_k=K9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJ2qBzaLyPiwEcd2n5Kdu_Y4KMpYjvjGo+Ddk3RC1Cf6_k=K9A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Thu, Aug 09, 2012 at 03:29:18PM +0100, Dean Jenkins wrote:
> One obvious failure of the rfcomm session refcnt is that the refcnt
> counter either starts with a value of 0 or 1 depending on which peer
> initiated the connection request, that is wrong. The initiator
> direction is not relevant for the session as connect and disconnect
> are independent events. The refcnt should start with a value of 1 in
> all cases.
> 
> I am using a 2-core ARM environment that is under high processor
> loading. The rfcomm session refcnt caused kernel crashes. I used a
> 2.6.34 kernel but the latest 3.5-RC1 still has the poor rfcomm code.
> My solution was to remove the rfcomm session refcnt and to ensure that
> the freeing of the rfcomm session pointer was propagated through-out
> the rfcomm core code. Some kernel crashes were due to reuse of the
> freed rfcomm session pointer.

Maybe it does make sense to fix refcounting instead of removing?

Best regards 
Andrei Emeltchenko 

> 
> I intend to release a patchset of rfcomm fixes.
> 
> Therefore, IMHO the fix "Bluetooth: Fix RFCOMM session reference
> counting issue" (commit cf33e7 in linux-stable.git) from Octavian
> Purdila in kernel 3.4.6 is in fact not fixing the root cause and
> introduces a misbehaviour of the refcnt. In our project, we rejected
> this commit because disconnections failed.
> 

