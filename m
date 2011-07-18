Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Jul 2011 15:18:11 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: padovan@profusion.mobi, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3] Zero-copy L2CAP ERTM & streaming reassembly
In-Reply-To: <1311021225.21109.165.camel@aeonflux>
Message-ID: <alpine.DEB.2.02.1107181458360.8933@mathewm-linux>
References: <1310579919-24546-1-git-send-email-mathewm@codeaurora.org>  <alpine.DEB.2.02.1107181300360.7338@mathewm-linux> <1311021225.21109.165.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel -

On Mon, 18 Jul 2011, Marcel Holtmann wrote:

> Hi Mat,
>
>>> This patch series changes SDU reassembly to link together PDU skbs
>>> using a frag list instead of copying all data bytes to a single,
>>> linear skb.  The reduction in overhead is especially helpful with high
>>> speed AMP links.
>
> I have not looked at these at all, but one thing that came up in a
> discussion between Johan and myself with OBEX zero-copy was that we like
> to also see MSG_MORE support for L2CAP and RFCOMM sockets. Something to
> keep in mind ;)

Noted!  It would be nice to build up OBEX packets in the kernel, 
rather than having to assemble entire packets in an application 
buffer.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
