Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Feb 2012 10:39:43 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 04/16] Bluetooth: Add l2cap_chan_lock
Message-ID: <20120210083941.GC28197@aemeltch-MOBL1>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797057-26331-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120209192430.GD3174@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120209192430.GD3174@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Feb 09, 2012 at 05:24:30PM -0200, Gustavo Padovan wrote:
> > +static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
> > +{
> > +	mutex_unlock(&chan->lock);
> > +}
> > +
> 
> I would call this just l2cap_lock(chan), the shorter the better. We will
> always use "chan" in the parameter, so it is easy to understand.

See other comment to patch 6 where Marcel suggests to add chan to function
name.

Best regards 
Andrei Emeltchenko 
