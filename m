Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Apr 2011 14:56:20 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: fix shutdown on SCO sockets
Message-ID: <20110418175619.GB2472@joana>
References: <1302271841-12127-1-git-send-email-luiz.dentz@gmail.com>
 <20110415185845.GB2359@joana>
 <BANLkTin2kuhT9vyANhLHTqw8G8maTEbQWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTin2kuhT9vyANhLHTqw8G8maTEbQWg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-04-17 20:26:53 +0300]:

> Hi Gustavo,
> 
> On Fri, Apr 15, 2011 at 9:58 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > Hi Luiz,
> >
> > * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-04-08 17:10:41 +0300]:
> >
> >> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> >>
> >> shutdown should wait for SCO link to be properly disconnected before
> >> detroying the socket, otherwise an application using the socket may
> >> assume link is properly disconnected before it really happens which
> >> can be a problem when e.g synchronizing profile switch.
> >>
> >> Signed-off-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> >
> > I applied it, but in bluetooth-next. Let's see its behaviour there and if no
> > problems show up we can move it to bluetooth-2.6
> 
> I tested this against Nokia BH-504 and Sony Ericsson W600, both have
> problem when switching from hfp to a2dp where the avdtp start is sent
> before SCO is fully disconnected, this patch fixes with those
> headsets.

Ok, I also pushed it to bluetooth-2.6.


-- 
Gustavo F. Padovan
http://profusion.mobi
