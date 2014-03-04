Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Mar 2014 09:14:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michael Knudsen <m.knudsen@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth:  Stop BCSP/H5 timer before cleaning up
Message-ID: <20140304071456.GA30165@localhost.P-661HNU-F1>
References: <1392713288-12227-1-git-send-email-m.knudsen@samsung.com>
 <531563D2.1060301@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <531563D2.1060301@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Tue, Mar 04, 2014, Michael Knudsen wrote:
> On 02/18/2014 09:48 AM, Michael Knudsen wrote:
> >When stopping BCSP/H5, stop the retransmission timer before proceeding
> >to clean up packet queues.  The previous code had a race condition where
> >the timer could trigger after the packet lists and protocol structure
> >had been removed which lead to dereferencing NULL or use-after-free bugs.
> 
> No interest?

I was just discussing this yesterday with Marcel (that we seem to have
forgotten about this patch). The only concern is whether it's safe to
sleep in the *_close callbacks (since you use del_timer_sync). Have you
verified that this doesn't cause any issues?

Johan

