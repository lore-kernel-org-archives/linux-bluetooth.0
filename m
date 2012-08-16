Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 10:23:06 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 14/21] Bluetooth: Handle physical link completion
Message-ID: <20120816072259.GB24160@aemeltch-MOBL1>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
 <1343260274-11953-15-git-send-email-mathewm@codeaurora.org>
 <20120815135105.GA3555@aemeltch-MOBL1>
 <alpine.DEB.2.02.1208150951470.30981@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1208150951470.30981@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, Aug 15, 2012 at 09:56:04AM -0700, Mat Martineau wrote:
...
> >
> >I feel that this function is too big. Maybe we could split channel move
> >and channel create operations?
> 
> Sure, the "if (chan->state != BT_CONNECTED)" clause would be clearer
> in a channel create function, and the other clauses can go in a
> channel move function.

Maybe we could define new state BT_MOVING ?

Best regards 
Andrei Emeltchenko 

