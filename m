Return-Path: <cyrus@holtmann.org>
Message-ID: <4BFD307B.6060805@codeaurora.org>
Date: Wed, 26 May 2010 09:30:19 -0500
From: Ron Shaffer <rshaffer@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Synchronize SCO/eSCO connection requests
 to ACL state
References: <4BFAEB65.2060503@codeaurora.org> <1274864356.27220.155.camel@localhost.localdomain>
In-Reply-To: <1274864356.27220.155.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel:

> Hi Ron,
> 
>> Certain headsets such as the Motorola H350 will reject SCO and eSCO
>> connection requests while the ACL is transitioning from sniff mode
>> to active mode. Add synchronization so that SCO and eSCO connection
>> requests will wait until the ACL has fully transitioned to active mode.
> 
> I am not completely happy with this patch. First please split it like
> Gustavo asked since otherwise it becomes pretty hard to review. I don't
> really bother to look into its technical nature before the split and the
> coding style is in place.
> 
> Second, please don't make a special case for sniff mode. If we do this
> then we also do it for park state and hold mode.
> 
> And third, I think this needs to be done a little bit more in the way we
> handle attempts for connecting ACL links when the baseband is busy. So
> can you send hcidump -X -V traces for the failure of SCO/eSCO setup when
> sniff is active. I like to see which error codes are returned. Hacking
> this directly into sniff exit handling makes the code pretty hard to
> understand in the future.
> 
> Regards
> 
> Marcel
> 
> 

Thanks for the review and comments. 

I'll split the patch into three. No problem. When I resubmit, I'll push
the hcidump log out as well. Because the failure occurs during eSCO 
negotiation and SCO request with the remote, most of the interesting 
stuff is in LMP, so I'll include the FTS sniffer trace as well.

-- 
Ron Shaffer
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
