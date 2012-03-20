Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 10:03:43 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 01/30] Bluetooth: Make ertm_init available
Message-ID: <20120320080336.GB27063@aemeltch-MOBL1>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331814621-13905-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120320030449.GB9142@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120320030449.GB9142@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Mar 20, 2012 at 12:04:49AM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> > -static inline void l2cap_ertm_init(struct l2cap_chan *chan)
> > +void l2cap_ertm_init(struct l2cap_chan *chan)
> 
> I prefer to see this kind of change with the actual code that uses it.

I will merge it.

Best regards 
Andrei Emeltchenko 
