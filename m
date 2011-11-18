Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC6B8F0.2040904@codeaurora.org>
Date: Fri, 18 Nov 2011 11:58:40 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] LE: Low Latency GATT Write-Sign-Cmd
References: <4EC6A13B.5030805@codeaurora.org> <1321643339.15441.622.camel@aeonflux>
In-Reply-To: <1321643339.15441.622.camel@aeonflux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 11/18/2011 11:08 AM, Marcel Holtmann wrote:
> the kernel crypto can be easily used from userspace. See PF_ALG.
>
> So the real question is what's the price of a context switch for us?
>

The timing to hit the earliest slot possible is what most concerns me. 
Although as Master we control the initial connection parameters, we 
really want the ACL packet ready to go as soon as we know the connection 
is up.

There is also the question about depending on positive verification from 
the Baseband that the packet has been sent (Num Cmplt Pkts Evt) before 
issuing the Disconnect HCI command.  An early problem that I had with 
gatttool (before the interactive enhancement) was that even if the ACL 
pkt had been properly sent over the HCI link, the Disconnect cmd was 
preempting it, and the remote device would never receive the ACL pkt.

[....]
>> I think this would be way cleaner than trying to wedge this use case
>> into our current GATT usage model.
>
> I think one of the most important questions that we have to ask
> ourselves at some point is if we wanna put ATT into the kernel.
>
> The potential candidate that forces us to think about this is HID over
> Low Energy. However I like to see numbers on how the context switches
> with keeping ATT in userspace will effect our latency.


I would support migrating ATT to the kernel.  In fact another issue I 
have dealt with is ensuring during Pairing, that we are able to at least 
respond with minimal Error responses if someone tries to read our name, 
and there is no GATT client socket to user space to respond.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
