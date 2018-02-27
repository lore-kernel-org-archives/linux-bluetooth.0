Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BlueZ 1/1 v2] Add initial doc describing Bluetooth Mesh
 API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4373E2AFF55@ORSMSX103.amr.corp.intel.com>
Date: Tue, 27 Feb 2018 13:40:32 +0100
Cc: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E09D28A8-317E-417F-A081-69C4A176AE83@holtmann.org>
References: <20180218064819.23459-1-inga.stotland@intel.com>
 <20180218064819.23459-2-inga.stotland@intel.com>
 <7EA4BC6E-29F5-440E-9D61-0EECE796AB6E@holtmann.org>
 <DEBB0CAA2616974FAE35E4B560B9A4373E2AFF55@ORSMSX103.amr.corp.intel.com>
To: Brian Gix <brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

<snip>

I am focusing first on the later part of the comments.

>> I dislike this. We should have a type 0x02 command that tells us what kind of
>> role we are operating in. And based on that scanning is enabled by binding
>> the socket and closing it. Or changing the role. The whole filter id exposure
>> seems a bit odd to me. I realize that this might look simple, but a few things
>> should be done by the kernel. And managing the scanning filters is one of
>> them. So we need to feed the kernel enough details that it can do that
>> efficiently. Swapping filters around from userspace is painful.
> 
> In my opinion, User space control of the filters is essential. Unless the kernel is
> handling Crypto, there is no way to know NIDs, Provisioning Session IDs etc. While
> the Kernel handles the discrete timing for individual packets, only User space knows
> enough about the current state of the Mesh to know what filters are required
> at any given time.

If we really think that userspace should control the filters, then I am really tempted to say that the HCI mesh commands is the API from userspace to the kernel to the controller. So the kernel just plays a little bit of path through and nothing else.

>> Otherwise we could just expose HCI_CHANNEL_MESH as HCI mesh
>> commands. They are all multiplexed via a single opcode anyway and have a
>> single event with and event prefix. So if you want this detailed control of the
>> HCI commands, then don’t try to put too much kernel in between. Just do
>> path through of them.
>> 
>> We could do just that and then leave the kernel portion for this alone.
>> Maybe it is worth while to debate pros and cons for this. It is actually not the
>> worst idea to give exclusive access to the mesh commands. It would be
>> similar to HCI_CHANNEL_USER, but only for the mesh commands and we
>> would strip the HCI command header and HCI event header + event prefix
>> off it so that you just have to deal with mesh opcode and mesh subevent
>> code.
> 
> Are current plan is to just pass packets we want sent with a requested timing,
> and filter incoming packets during designated Scan windows
> 
>> 
>> Hmmm .. it gets a bit tricky for the command complete portion of it. So it
>> might have to be the full HCI anyway, but restricted to one opcode and only
>> matching events being forwarded.
> 
> We are not doing *anything* like Command Complete, and I strongly argue against
> anything like it. In Mesh everything is *Best Effort* whether we like it or not.  Command
> Completes may guarantee that a Controller has done what we ask, but whether it has
> done what we ask is 100% immaterial, unless you have a use-case demonstrating how
> it can be useful in a Mesh environment.  The only thing we care about is whether a
> remote device has received our packets, or whether we receive theirs. All reliability
> is built into the User-Space Network and Access layers... unlike ACL based systems.
> 
> All feedback from Kernel --> User space can be handled with Status codes returned from
> socket writes, or set sock options.

Don’t read too much into command complete. That is just flow control handling so you know when the controller has accepted the command and is a way to return status or other return parameters.

Regards

Marcel

