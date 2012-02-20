Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Feb 2012 14:17:29 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv5 02/16] Bluetooth: Revert to mutexes from RCU list
Message-ID: <20120220121725.GA27197@aemeltch-MOBL1>
References: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329486252-25252-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikbgxQxySgBUxKOjakxCrG1rAKk=aPfEW+JYL7g8PJLueA@mail.gmail.com>
 <CAMXE1-oiPJEF7WAc14ekR99Y6=FNPs0iSqwWA_miLit=AesP=g@mail.gmail.com>
 <CAA37ikb_7PfxQwTCBHn0GHWUh-PVg9aJ1tj3S7cCZJsNb8DMZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAA37ikb_7PfxQwTCBHn0GHWUh-PVg9aJ1tj3S7cCZJsNb8DMZQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Mon, Feb 20, 2012 at 09:55:35AM -0200, Ulisses Furquim wrote:
> 
> >> With patch 3 you add some needed changes but then adds an imbalance of
> >> lock/release sock locks which is only solved in patch 4. Why?
> >
> > How does patch 4 solves locking? If I did not miss something it shall
> > not change anything.
> 
> For instance, in patch 3 you replace l2cap_get_chan_by_scid() with __
> l2cap_get_chan_by_scid() in l2cap_connect_rsp(). However,  __
> l2cap_get_chan_by_scid() doesn't lock_sock() as the other one did and
> only in patch 4 you add an explicit lock_sock() to
> l2cap_connect_rsp(). Got it? A commit should be self contained as much
> as possible so we keep the code bisectable.

You are right here, I will squash those mentioned patches since this is
easy way.

Best regards 
Andrei Emeltchenko 

