Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 16:48:13 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -v3] Bluetooth: Add MSG_MORE support to L2CAP sockets
In-Reply-To: <20120525222509.GF31623@joana>
Message-ID: <alpine.DEB.2.02.1205251616520.2070@mathewm-linux>
References: <1337384778-25135-1-git-send-email-gustavo@padovan.org> <1337385587.2058.31.camel@aeonflux> <20120525222509.GF31623@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Fri, 25 May 2012, Gustavo Padovan wrote:

> * Marcel Holtmann <marcel@holtmann.org> [2012-05-18 16:59:47 -0700]:
>
>> Hi Gustavo,
>>
>>> MSG_MORE enables us to save buffer space in userspace, the packet is
>>> built directly in the kernel and sent only when a msg with the MSG_MORE
>>> flag not set arrives. If a send() tries to add more chan->omtu bytes
>>> -EMSGSIZE is returned.
>>>
>>> Only MSG_MORE for Basic Mode is supported right now. chan->skb_more keeps
>>> a pointer to the L2CAP packet that is being build through many calls to
>>> send().
>>
>> so this is really not acceptable. We need to start supporting all modes
>> with MSG_MORE at the same time. Otherwise we can not merge this.
>
> The ERTM/Streaming sending code is bit different from the Basic mode sending
> so implementing a MSG_MORE code that fits in both cases is not that trivial.
> I have a different proposal for this that would make the code a lot simpler,
> however we will need more memory.
>
> We could add a extra buffer to keep the data coming from userspace until a
> send with the MSG_MORE is not sent arrives, at that point we pass a to sending
> side that will treat the buffer according to the L2CAP mode. This is simpler
> but as said has extra buffer copy. On the other side, when one is using
> MSG_MORE it saves a data copy in userspace, as we don't need to build the
> packet there anymore.
>
> comments?

If an extra buffer is added, I think that gets rid of any benefit 
to MSG_MORE - as you say, the data buffer has just moved from 
userspace to kernel space.

There are several things to consider for MSG_MORE and ERTM/streaming:

* You can't send any PDUs until the final write is done (without the 
MSG_MORE flag).  The SDU length must be correct in the first PDU of a 
segmented SDU.  If the application overruns the MTU, you also need to 
flush out the partially assembled data and return an error to the 
application.

* You might not know whether the SDU length field is needed in the 
first PDU, which may be a start frame or an unsegmented frame.  Since 
the control headers are now populated just before sending, it's not 
too hard to overallocate the first frame to allow room for the SDU 
length, and prepend that header if needed.


Overall, it's not very different from HCI fragmentation (and we don't 
support HCI fragmentation of ERTM PDUs).  You're just splitting things 
up in to L2CAP PDUs instead of HCI fragments.

If done right, the MSG_MORE code could also be used for efficient ERTM 
resegmentation (this happens when PDUs already in the tx_q need to be 
resized after an AMP channel move).  My existing code uses a temporary 
buffer when resegmenting, but with incremental segmentation that temp 
buffer could be eliminated.  Take a look at the 
l2cap_resegment_queue() function here:

https://www.codeaurora.org/gitweb/quic/la/?p=kernel/msm.git;a=blob;f=net/bluetooth/l2cap_core.c;hb=msm-3.0



--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
