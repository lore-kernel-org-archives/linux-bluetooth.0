Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Feb 2011 11:44:38 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth-next 00/16] l2cap.c split
Message-ID: <20110204134438.GA2151@joana>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <AANLkTi=P8dnzL9O-SatX_-zddHKndOLxA1vm3V1K+oji@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=P8dnzL9O-SatX_-zddHKndOLxA1vm3V1K+oji@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-02-04 14:38:13 +0200]:

> Hi,
> 
> On Fri, Feb 4, 2011 at 8:01 AM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > Here is the first real split of l2cap.c file. That file was getting so big that
> > we really need to split it in two or more. By now we have two file:
> > l2cap_sock.c and l2cap_core.c. In l2cap_sock.c we have all functions that deals
> > with sockets, in l2cap_core.c the rest.
> >
> > Side efects are that I had to move the declaration of many functions to l2cap.h
> > along the l2cap socket list.
> >
> > There are more steps on this, but this is surely a big one.
> 
> What about creating a l2cap directory like rfcomm? Or that would cause
> too much hassle with building system?

We plan to merge l2cap.ko and sco.ko modules into bluetooth.ko. That is the
reason why I'm doing it the net/bluetooth/ directory. There isn't a good use
case where one won't want to use the l2cap.ko and sco.ko modules and it will
be always possible to disable L2CAP and SCO in the menuconfig.

Regards,

-- 
Gustavo F. Padovan
http://profusion.mobi
