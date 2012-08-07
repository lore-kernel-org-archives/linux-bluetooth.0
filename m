Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Aug 2012 11:31:01 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 06/21] Bluetooth: Channel move request handling
Message-ID: <20120807083054.GA3372@aemeltch-MOBL1>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
 <1343260274-11953-7-git-send-email-mathewm@codeaurora.org>
 <20120726135924.GC2686@aemeltch-MOBL1>
 <alpine.DEB.2.02.1207270758080.6052@mathewm-linux>
 <20120806084435.GA2819@aemeltch-MOBL1>
 <alpine.DEB.2.02.1208060904500.25736@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1208060904500.25736@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Mon, Aug 06, 2012 at 09:33:50AM -0700, Mat Martineau wrote:
> >>>>+	chan->move_cmd_ident = cmd->ident;
> >>>
> >>>BTW: Why do we handle ident in a special way for channel move?
> >>
> >>At the time I wrote the code, I thought that chan->ident was only
> >>used to store idents of sent requests, not received requests.  But
> >>it does look like it is also used for storing received idents for
> >>use in sending responses.  chan->ident could be used as long as move
> >>collisions are handled correctly (where a move request is received
> >>when a move response is expected).
> >
> >So can we use chan->ident instead of chan->move_cmd_ident? Is the channel
> >move somehow different from other L2CAP request / response sequence?
> 
> Yes, chan->ident can be used.  It doesn't seem necessary to assign
> chan->ident when sending a move request, just when receiving one.
> 
> Connect and create requests also assign chan->ident when they are
> sent, but I'm not sure why.

My understanding is that ident only used to match responses with requests.
So channel move is not a special case.

Reference: BLUETOOTH SPECIFICATION Version 4.0 [Vol 3] page 56 of 656

Best regards 
Andrei Emeltchenko 
 
