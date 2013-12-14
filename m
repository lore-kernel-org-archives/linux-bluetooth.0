Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Dec 2013 15:36:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Shouldn't bluez serialize connection/authorization attempts?
Message-ID: <20131214133625.GA27187@x220.p-661hnu-f1>
References: <52AC4425.7080109@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52AC4425.7080109@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

On Sat, Dec 14, 2013, Alexander Holler wrote:
> So besides the first connection attempt, all others do die somewhere
> where userspace has no control over.
> 
> What happens is likely that connection attempts are refused by the
> remote side, because an ongoing connection or authorization attempt
> isn't finished while a new one arrives.

>From the HCI logs you showed on IRC it was quite clear that the (remote
side) authorization phase for each connect attempt was finished before
the next connect attempt started, i.e. there was an L2CAP Connect
Response with an error status before the next L2CAP Connect Request. So
from this perspective there didn't seem to be any lack of serialization.

Johan
