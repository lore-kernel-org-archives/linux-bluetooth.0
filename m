Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Mar 2012 13:08:04 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] gobex: flush tx_queue before disconnection
Message-ID: <20120309130804.GA31252@x220.spectrum.wifi>
References: <1331189303-6734-1-git-send-email-jaganath.k@samsung.com>
 <20120308234250.GB15265@x220.amr.corp.intel.com>
 <22D13068A6CE4724BFD60D3D46B5FD11@sisodomain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22D13068A6CE4724BFD60D3D46B5FD11@sisodomain.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Mar 09, 2012, Jaganath wrote:
> >On Thu, Mar 08, 2012, Jaganath Kanakkassery wrote:
> >>@@ -1335,6 +1335,12 @@ void g_obex_unref(GObex *obex)
> >>
> >> g_slist_free_full(obex->req_handlers, g_free);
> >>
> >>+ do {
> >>+ ret = write_data(obex->io, G_IO_OUT, obex);
> >>+ if (obex->pending_req && obex->pending_req->cancelled)
> >>+ break;
> >>+ } while(ret);
> >
> >This is not ok since we should only attempt writing to the transport if
> >G_IO_OUT is *really* set and not just fake it. Otherwise the call might
> >block which is not acceptable for the way gobex is designed (to be used
> >with a single async mainloop).
> 
> This actually fixes the issue abort req not sending if user cancels the
> transfer because in user cancel scenario, ABORT req will be queued
> but before G_IO_OUT happens the transport will be disconnected.
> This is actually required to pass a pts test case because pts requires
> ABORT before disconnection.

I fully understand that this needs to be fixed, it's just that the way
you're proposing is not a good way to do it.

> So I have two solutions after considering your and Luiz's opinion. '
> 
> 1. In g_obex_send_internal() if the packet is ABORT we should send it
> immediately using write_data(). Since ABORT packet size is small I think
> it is ok to block the write.

Nope, it's never ok to block on write.

> 2.  If user cancels transfer just send ABORT and disconnect transport only
> after getting the response. But waiting for ABORT response is not
> good I feel.

I think it *is* good to wait for the response. I've seen devices which
break if you disconnect the transport without waiting for OBEX
Disconnect command response and there could also be devices which
exhibit similar behavior for Abort.

I think this needs to be fixed on a higher layer than gobex as gobex
already provides a mechanism for waiting for the completion (or
cancellation) of a command.

Johan
