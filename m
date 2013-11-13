Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Nov 2013 15:16:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 4/9] android/hal-sock: Initial listen handle
Message-ID: <20131113131629.GA15373@x220.p-661hnu-f1>
References: <1384178627-25991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1384178627-25991-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20131113121537.GA11291@x220.p-661hnu-f1>
 <20131113125213.GG21468@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131113125213.GG21468@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Nov 13, 2013, Andrei Emeltchenko wrote:
> > A table would probably make more sense here. What about the SDP records
> > that need to be registered? Also, I'd stick to the assigned numbers from
> > our doc/assigned-numbers.txt.
> 
> If I use table then we need a loop here.

Correct.

> So shall we change default Android assigned number to ours? Some devices
> assume that numbers and we would have worse interoperability.

A device which hard-codes a remote RFCOMM channel and never does an SDP
lookup wouldn't be able to pass qualification or interoperate with any
device that doesn't have the same hard-coded channel. So I really doubt
such devices exist on the market, unless you can provide some proof.

Johan
