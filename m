Return-Path: <cyrus@holtmann.org>
Message-ID: <52AC7237.10306@ahsoftware.de>
Date: Sat, 14 Dec 2013 15:59:03 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Shouldn't bluez serialize connection/authorization attempts?
References: <52AC4425.7080109@ahsoftware.de> <20131214133625.GA27187@x220.p-661hnu-f1>
In-Reply-To: <20131214133625.GA27187@x220.p-661hnu-f1>
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 14.12.2013 14:36, schrieb Johan Hedberg:
> Hi Alexander,
> 
> On Sat, Dec 14, 2013, Alexander Holler wrote:
>> So besides the first connection attempt, all others do die somewhere
>> where userspace has no control over.
>>
>> What happens is likely that connection attempts are refused by the
>> remote side, because an ongoing connection or authorization attempt
>> isn't finished while a new one arrives.
> 
> From the HCI logs you showed on IRC it was quite clear that the (remote
> side) authorization phase for each connect attempt was finished before
> the next connect attempt started, i.e. there was an L2CAP Connect
> Response with an error status before the next L2CAP Connect Request. So
> from this perspective there didn't seem to be any lack of serialization.

That wasn't so clear for me as I've seen different responses from the
remote device, but still nothing ended up at the local agent afer the
first connection attempt failed (regardless how many retries).

So there is no solution to this problem and one local user can easily
DOS all local bluetooth communicaton?

Regards,

Alexander Holler
