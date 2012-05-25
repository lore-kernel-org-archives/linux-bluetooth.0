Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 16:08:02 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 05/18] Bluetooth: A2MP: Add chan callbacks
Message-ID: <20120525130801.GI3089@aemeltch-MOBL1>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337859508-32274-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337859508-32274-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120525122037.GB31623@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120525122037.GB31623@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, May 25, 2012 at 09:20:37AM -0300, Gustavo Padovan wrote:
> >  static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
> > @@ -110,6 +148,8 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
> >  	chan->remote_mps = chan->omtu;
> >  	chan->mps = chan->omtu;
> >  
> > +	chan->state = BT_CONNECTED;
> > +
> 
> This change seems to be unrelated to this patch.

OK, I move it to the first patch.

Best regards 
Andrei Emeltchenko 
