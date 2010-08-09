Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201008091102.28980.siarhei.siamashka@gmail.com>
References: <AANLkTimiBsL60-8w4MPoP=g8Fo_+U-SrSBTa9--aqEK4@mail.gmail.com>
	<AANLkTimLW5SUmx4OvzY4M51HjV3mf3=pbBtAgHoeiReZ@mail.gmail.com>
	<AANLkTi=fSfwijpK-OR-6yTr30USFQbcgknrd1FaU99oH@mail.gmail.com>
	<201008091102.28980.siarhei.siamashka@gmail.com>
Date: Mon, 9 Aug 2010 14:58:24 +0530
Message-ID: <AANLkTimPOt5Lh3MaN6zR02H91u9kHbgja50dmTDVUTHs@mail.gmail.com>
Subject: Re: Question about BlueZ licenses (LGPL and Apache)
From: Madhavi Manchala <madhavi.linux@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: Alan Carvalho de Assis <acassis@gmail.com>, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 9, 2010 at 4:32 PM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> On Monday 09 August 2010 07:38:17 Madhavi Manchala wrote:
>> By the way, please let me clarify one thing. I think, the input for
>> the SBC module is the RAW stream. Am I correct?
>
> As I understand it, you are not happy about something in bluez so that you are
> considering to hook in your own SBC implementation. Could you please share your
> concerns? Do you have problems with sound quality? Performance in general?
> Performance on some particular hardware? Anything else? Are you interested in
> SBC encoder or decoder?

Actually, I am not trying to hook a new SBC implementation. I am
trying to work on a new custom codec, and in case the SINK devices do
not support my custom codec, I want the src to reroute the stream
through the SBC encoder, so that all the SINK devices will work
without any problem. Since SBC is mandatory in the A2DP
implementation, I thought about using SBC as the alternate codec.
Please let me know if I am missing something.

Thanks and Regards,
Madhavi M.
