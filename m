Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAA37ikbgxQxySgBUxKOjakxCrG1rAKk=aPfEW+JYL7g8PJLueA@mail.gmail.com>
References: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329486252-25252-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikbgxQxySgBUxKOjakxCrG1rAKk=aPfEW+JYL7g8PJLueA@mail.gmail.com>
Date: Sun, 19 Feb 2012 21:49:08 +0200
Message-ID: <CAMXE1-oiPJEF7WAc14ekR99Y6=FNPs0iSqwWA_miLit=AesP=g@mail.gmail.com>
Subject: Re: [RFCv5 02/16] Bluetooth: Revert to mutexes from RCU list
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Fri, Feb 17, 2012 at 11:22 PM, Ulisses Furquim
<ulisses@profusion.mobi> wrote:
> Why don't you squash together patches 2, 3 and 4? Is there a reason?

The price of squashing is zero and if there are no other comments I
can do it right away.

> Only with patch 2 the change becomes incomplete and prone to errors.

However I do not think that this makes much difference to the existing code.

> With patch 3 you add some needed changes but then adds an imbalance of
> lock/release sock locks which is only solved in patch 4. Why?

How does patch 4 solves locking? If I did not miss something it shall
not change anything.

Regards,
Andrei
