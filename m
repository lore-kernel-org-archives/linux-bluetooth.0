Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Aug 2012 15:50:37 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 12/20] Bluetooth: Choose connection based on capabilities
Message-ID: <20120810125035.GE2683@aemeltch-MOBL1>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120724211038.GE20029@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120724211038.GE20029@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jul 24, 2012 at 06:10:38PM -0300, Gustavo Padovan wrote:
> > +void l2cap_discover_amp(struct l2cap_chan *chan)
> 
> prefix a function with l2cap_ outside of the l2cap code is not really a good
> idea, we need a better solution here..

I will rename this to a2mp_discover_amp

Best regards 
Andrei Emeltchenko 

