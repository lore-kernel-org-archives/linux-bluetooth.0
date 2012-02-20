Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMXE1-oiPJEF7WAc14ekR99Y6=FNPs0iSqwWA_miLit=AesP=g@mail.gmail.com>
References: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329486252-25252-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikbgxQxySgBUxKOjakxCrG1rAKk=aPfEW+JYL7g8PJLueA@mail.gmail.com>
	<CAMXE1-oiPJEF7WAc14ekR99Y6=FNPs0iSqwWA_miLit=AesP=g@mail.gmail.com>
Date: Mon, 20 Feb 2012 09:55:35 -0200
Message-ID: <CAA37ikb_7PfxQwTCBHn0GHWUh-PVg9aJ1tj3S7cCZJsNb8DMZQ@mail.gmail.com>
Subject: Re: [RFCv5 02/16] Bluetooth: Revert to mutexes from RCU list
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Sun, Feb 19, 2012 at 5:49 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Fri, Feb 17, 2012 at 11:22 PM, Ulisses Furquim
> <ulisses@profusion.mobi> wrote:
>> Why don't you squash together patches 2, 3 and 4? Is there a reason?
>
> The price of squashing is zero and if there are no other comments I
> can do it right away.
>
>> Only with patch 2 the change becomes incomplete and prone to errors.
>
> However I do not think that this makes much difference to the existing code.

We're trying to improve things, right? If the current code is broken
somehow is not an excuse for us to merge patches which we know are
incomplete and will possibly break if someone is doing a bisect, for
instance.

>> With patch 3 you add some needed changes but then adds an imbalance of
>> lock/release sock locks which is only solved in patch 4. Why?
>
> How does patch 4 solves locking? If I did not miss something it shall
> not change anything.

For instance, in patch 3 you replace l2cap_get_chan_by_scid() with __
l2cap_get_chan_by_scid() in l2cap_connect_rsp(). However,  __
l2cap_get_chan_by_scid() doesn't lock_sock() as the other one did and
only in patch 4 you add an explicit lock_sock() to
l2cap_connect_rsp(). Got it? A commit should be self contained as much
as possible so we keep the code bisectable.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
