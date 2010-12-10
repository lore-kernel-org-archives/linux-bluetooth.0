Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Dec 2010 09:17:16 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: Yuri Ershov <ext-yuri.ershov@nokia.com>
Cc: "ext Gustavo F. Padovan" <padovan@profusion.mobi>,
	andrei.emeltchenko@nokia.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] bluetooth: Fix NULL pointer dereference issue
Message-ID: <20101210071716.GK874@null>
References: <e98b2c6fd02b11300d82577cb54cfdb63e8400d2.1290678703.git.ext-yuri.ershov@nokia.com>
 <20101206211516.GH883@vigoh>
 <4CFE32A0.6090601@nokia.com>
 <20101207155037.GA2944@vigoh>
 <4CFF6359.7000305@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CFF6359.7000305@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yuri,

On Wed, Dec 08, 2010 at 01:52:09PM +0300, Yuri Ershov wrote:


> >>>So in which situations (n == p), or (p == p->next)? That should happen only
> >>>when p is the only element in the list, then p == head, right?
> >>The (n == p) is in situation, when sk is unlinked by task
> >>responsible for handling connect/disconnect requests while the
> >>"bt_accept_dequeue". This condition is indirect checking of sk
> >>validity.
> >
> >Why not using a list lock here instead? Fits a way better.
> >
> Yes, it's better. I tried to use the locks in this function, but it
> slows down the task handling connect/disconnect/etc. events and the
> task skips some events from fast clients.
> 

What kind of problems you exactly got with locks? Maybe they should be fixed
also.

-- 
Ville
