Return-Path: <cyrus@holtmann.org>
Message-ID: <4BFD98F0.5090203@codeaurora.org>
Date: Wed, 26 May 2010 16:56:00 -0500
From: Ron Shaffer <rshaffer@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Synchronize SCO/eSCO connection requests
 to ACL state
References: <4BFAEB65.2060503@codeaurora.org>	 <1274864356.27220.155.camel@localhost.localdomain>	 <4BFD307B.6060805@codeaurora.org> <1274887917.27220.166.camel@localhost.localdomain>
In-Reply-To: <1274887917.27220.166.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

> Hi Ron,
> 
>> I'll split the patch into three. No problem. When I resubmit, I'll push
>> the hcidump log out as well. Because the failure occurs during eSCO 
>> negotiation and SCO request with the remote, most of the interesting 
>> stuff is in LMP, so I'll include the FTS sniffer trace as well.
> 
> don't bother with FTS traces. I don't care. I just need to see the
> output of hcidump -X -V so that I can figure out what the problem is
> here and what are possible solutions. Send the hcidump now before
> redoing the patches.
> 
> Regards
> 
> Marcel
> 
> 

Here's the hcidump for this scenario. I've also taken a look at the ACL retry
mechanism used in the case where the baseband is too busy and the connection
attempt fails. The same mechanism is already in place for SCO and eSCO. The
difference with this particular scenario is this:

1. The failure is caused be an issue on the remote
2. Once the failure has occurred it is generally unrecoverable i.e. the remote
side is hosed and needs to be reset, so repeated attempts continue to fail.
3. The only way to make a successful connection and keep from hosing the remote
is to prevent the scenario from occurring by not requesting eSCO or SCO during
the transition period.

As for hold and park, we can generalize it by making eSCO or SCO pend
until we also exit from hold. As for park, it's unclear as I didn't really
see any support for park. It doesn't look like we prevent commands or data
from being sent to a remote that is parked.

< HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Exit Sniff Mode (0x02|0x0004) status 0x00 ncmd 1
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0040
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 12 mode 0x00 interval 0
    Mode: Active
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x10 handle 14 bdaddr 00:1A:0E:50:28:A4 type SCO
    Error: Connection Accept Timeout Exceeded
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0040
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
< ACL data: handle 12 flags 0x00 dlen 22
    0000: 12 00 41 00 0b ef 1d 0d  0a 2b 43 49 45 56 3a 20  ..A..ï...+CIEV: 
    0010: 35 2c 34 0d 0a 9a                                 5,4...
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< ACL data: handle 12 flags 0x00 dlen 22
    0000: 12 00 41 00 0b ef 1d 0d  0a 2b 43 49 45 56 3a 20  ..A..ï...+CIEV: 
    0010: 35 2c 35 0d 0a 9a                                 5,5...
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x10 handle 14 bdaddr 00:1A:0E:50:28:A4 type SCO
    Error: Connection Accept Timeout Exceeded

-- 
Ron Shaffer
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
