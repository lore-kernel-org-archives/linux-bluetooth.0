Return-Path: <mjj29@matthew.ath.cx>
Date: Fri, 4 Nov 2005 15:56:14 +0000 (GMT)
From: Matthew Johnson <matt@matthew.ath.cx>
Reply-To: matt@matthew.ath.cx
To: Marcel Holtmann <marcel@holtmann.org>
cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Disconnecting after 54 seconds
In-Reply-To: <1131119129.11673.4.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0511041547530.27685@illythia.matthew.ath.cx>
References: <Pine.LNX.4.63.0511041142190.27685@illythia.matthew.ath.cx>
 <1131119129.11673.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: Matthew Johnson <mjj29@matthew.ath.cx>
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 4 Nov 2005, Marcel Holtmann wrote:

>> Is there some sort of timeout happening here? I thought it might need
>> activity to keep the link up, but l2ping should do that. Has anyone else
>> seen anything similar?
>
> these are L2CAP echo packets and so this doesn't have to be reliable.
>
Having packets dropped I would expect, but I wouldn't expect the HCI
connection to be dropped regularly like this. This happens consistently
using hcitool as well, after 54 seconds a link created with hcitool cc
is dropped.

I've read over the FAQ and howtos on bluez.org and none of them appear
to address this. Are there any low-level protocol docs which would
suggest some sort of keep-alive which might be necessary? or is this
likely to be a problem with my phone?

Thanks,
Matt

-- 
Matthew Johnson
http://www.matthew.ath.cx/
