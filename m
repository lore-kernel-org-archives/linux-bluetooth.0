Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Apr 2012 14:04:28 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>, marcel@holtmann.org
cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
    andrei.emeltchenko.news@gmail.com
Subject: Re: [RFCv2 4/8] Bluetooth: Fix a redundant and problematic incoming
 MTU check
In-Reply-To: <20120428001819.GA2917@joana>
Message-ID: <alpine.DEB.2.02.1204300803350.2723@mathewm-linux>
References: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org> <1335570655-30878-5-git-send-email-mathewm@codeaurora.org> <20120428001819.GA2917@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Fri, 27 Apr 2012, Gustavo Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2012-04-27 16:50:51 -0700]:
>
>> The L2CAP MTU for incoming data is verified differently depending on
>> the L2CAP mode, so the check is best performed in a mode-specific
>> context.  Checking the incoming MTU before HCI fragment reassembly is
>> a layer violation and assumes all bytes after the standard L2CAP
>> header are L2CAP data.
>>
>> This approadch causes issues with unsegmented ERTM or streaming mode

Oops, I need to fix this "approadch" typo.

>> frames, where there are additional enhanced or extended headers before
>> the data payload and possible FCS bytes after the data payload.  A
>> valid frame could be as many as 10 bytes larger than the MTU.
>>
>> Removing this code is the best fix, because the MTU is checked later
>> on for all L2CAP data frames (connectionless, basic, ERTM, and
>> streaming).  This also gets rid of outdated locking (socket instead of
>> l2cap_chan) and an extra lookup of the channel ID.
>
> I don't think we can remove this code from here. This check is different
> from the ones you are talking, those are l2cap packets, here we are still
> dealing with ACL fragments. This check is there to avoid accept a first
> ACL packet that is too big. See 8979481328d.
>
> One possible solution is to add a slack value to the check, so we can
> fit those 10+ bytes packets in it.

If we just add slack, then we're depending on the real MTU checks to 
work correctly later.  Why bother with this early check at all?

I think there's a misunderstanding about the code that is being 
removed.  It *is* checking the L2CAP MTU for that channel against the 
value in the L2CAP length header before the whole frame is assembled, 
which is why it shouldn't be involved with ACL fragments to begin 
with.  It is the only place in l2cap_recv_acldata that uses 
channel-specific information.

This code tries to throw out the first ACL fragment if the L2CAP 
payload is longer than than the L2CAP MTU for that channel.  The ERTM 
and streaming mode MTU has different meaning - it applies to the 
reassembled SDU payload, not the size of an individual PDU segment 
with the extra headers and FCS bytes.  There is already a length check 
in the fragment reassembly code that makes sure no reassembled ACL 
frame exceeds 65535 bytes (look at how conn->rx_len is used).

The original discussion around this code is here:

http://thread.gmane.org/gmane.linux.bluez.kernel/7505

The purpose was to address a memory allocation failure in 
__get_free_pages - which suggests heap corruption.  Even if the start 
fragment is too large, that shouldn't lead to heap corruption, 
especially if the fragment is properly freed.  Throwing out this large 
packet is just hiding the real bug!

The MTU is checked everywhere that it needs to be for L2CAP data, 
after the ACL fragments are reassembled:

* In l2cap_reassemble_sdu for ERTM and Streaming Mode
* In l2cap_data_channel for Basic Mode
* In l2cap_connless_channel for connectionless channels

The code being removed doesn't address the signaling channel, because 
that channel is not in the channel list. The spec defines the MTU for 
the signaling channel to be "MTUsig", and only requires it to be at 
least 48 bytes (672 bytes if extended flowspec is supported).  It is 
valid for us not to enforce a limit on it other than the maximum L2CAP 
frame size.


We removed this code (because it broke AMP) from our Android kernel 
back in September 2011, and have been through several qualifications 
and rounds of testing since then without problems.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
