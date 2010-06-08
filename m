Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] Remove ifndef barrier from log.h and btio.h
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20100608061954.GA16335@jh-x301>
References: <1275712886-20127-1-git-send-email-gustavo@padovan.org>
	 <1275712886-20127-2-git-send-email-gustavo@padovan.org>
	 <20100608061954.GA16335@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Jun 2010 00:14:29 -0700
Message-ID: <1275981269.2182.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> >  src/btio.h |    3 ---
> >  src/log.h  |    4 +---
> >  2 files changed, 1 insertions(+), 6 deletions(-)
> > 
> > diff --git a/src/btio.h b/src/btio.h
> > index 00d743e..fa6ff69 100644
> > --- a/src/btio.h
> > +++ b/src/btio.h
> > @@ -21,8 +21,6 @@
> >   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >   *
> >   */
> > -#ifndef BT_IO_H
> > -#define BT_IO_H
> 
> I think it'd be good to leave this for BtIO since it might become a
> public library soon.
> 
> > -#ifndef __LOGGING_H
> > -#define __LOGGING_H
> > +extern int debug_enabled;
> 
> This doesn't match the commit message. To me it seems like the extern
> int addition should be part of the third patch and not this one. Also,
> Marcel might have had a reason for putting the safeguard for log.h so
> just leave these safeguards as they are (ofono and connman has them
> too).

that safeguard can be removed. That was some leftover from when it
looked like a good idea to make this more generic. It never worked out
so lets just remove this.

Regards

Marcel


