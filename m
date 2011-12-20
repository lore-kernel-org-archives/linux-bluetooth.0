Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Dec 2011 17:10:08 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Nove l2cap_{set,clear}_timer to l2cap.h
Message-ID: <20111220191008.GC24612@joana>
References: <1324385848-19101-1-git-send-email-padovan@profusion.mobi>
 <CAJdJm_MEhpZduv8N8_tk5qxHuyto-0U6P-Sr_v_-SXC=hsXKWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_MEhpZduv8N8_tk5qxHuyto-0U6P-Sr_v_-SXC=hsXKWw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2011-12-20 09:09:23 -0400]:

> Hi Padovan,
> 
> On Tue, Dec 20, 2011 at 8:57 AM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> >
> > It is the only place where it is used.
> 
> I don't understand. If l2cap.h is the only place where it is used, how
> it used to work/compile before? I can only imagine that the macros
> using   l2cap_{set,clear}_timer  are in l2cap_core.c , in which case
> they should be moved to l2cap_core.c , not the other way around?

It worked because only macros were using them. Also l2cap.h keeps a lot of
helpers functions to be used only in l2cap_core.c. So to me this seems the
right move.

	Gustavo
