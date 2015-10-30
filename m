Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Oct 2015 14:00:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pacho Ramos <pacho@gentoo.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Should btmgmt be installed?
Message-ID: <20151030120053.GA10576@t440s.lan>
References: <1446017598.18413.23.camel@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446017598.18413.23.camel@gentoo.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pacho,

On Wed, Oct 28, 2015, Pacho Ramos wrote:
> Some people downstream is asking us to install btmgmt utility but, for
> some reason, it looks like upstream makefile rules don't install it. Is
> that being missed on purpose? Should Makefiles be fixed to get it
> installed or that utility is not meant to be installed in users
> systems?

I think this is mostly because of historical reasons. The btmgmt tool
wasn't created for anything else except a developer testing tool
initially. It's still supposed to be just a developer tool, but if
people have good reasons to use it then I don't personally have anything
against making it installable through the makefile rules. Someone should
just send a patch for it. That said, Marcel might have a differing
opinion on the matter (though his silence so far is promising ;)

Johan
