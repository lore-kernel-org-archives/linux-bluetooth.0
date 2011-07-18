Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 0/3] Zero-copy L2CAP ERTM & streaming reassembly
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: padovan@profusion.mobi, linux-bluetooth@vger.kernel.org
Date: Tue, 19 Jul 2011 00:43:15 +0200
In-Reply-To: <alpine.DEB.2.02.1107181458360.8933@mathewm-linux>
References: <1310579919-24546-1-git-send-email-mathewm@codeaurora.org>
	  <alpine.DEB.2.02.1107181300360.7338@mathewm-linux>
	 <1311021225.21109.165.camel@aeonflux>
	 <alpine.DEB.2.02.1107181458360.8933@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1311028996.21109.168.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> >>> This patch series changes SDU reassembly to link together PDU skbs
> >>> using a frag list instead of copying all data bytes to a single,
> >>> linear skb.  The reduction in overhead is especially helpful with high
> >>> speed AMP links.
> >
> > I have not looked at these at all, but one thing that came up in a
> > discussion between Johan and myself with OBEX zero-copy was that we like
> > to also see MSG_MORE support for L2CAP and RFCOMM sockets. Something to
> > keep in mind ;)
> 
> Noted!  It would be nice to build up OBEX packets in the kernel, 
> rather than having to assemble entire packets in an application 
> buffer.

hence the request for MSG_MORE support. That would allow us to build
frames properly. Could also become a pretty nice enhancement for A2DP.

Regards

Marcel


