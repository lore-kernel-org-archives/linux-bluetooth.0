Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101112165434.GA13238@jh-x301>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
	<20101111210705.GB24514@jh-x301>
	<000b01cb8200$02c24c90$0846e5b0$@org>
	<20101112165434.GA13238@jh-x301>
Date: Fri, 12 Nov 2010 21:00:55 -0400
Message-ID: <AANLkTi=J39omUnYYWLpB0ncd6Kd8LukdFopM4WDyWNJ1@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] Fix invalid memory access when EIR field length is zero
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Inga Stotland <ingas@codeaurora.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/12/10, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Inga,
>
> On Thu, Nov 11, 2010, Inga Stotland wrote:
>> Was there a bug to begin with? :)
>> The access to eir_data[1] was always valid due to the check (len <
>> EIR_DATA_LENGTH - 1)
>> and the fact that eir_data is a buffer of fixed length of EIR_DATA_LENGTH
>> (240 bytes).
>
> On closer inspection it seems you might be right, however it'd be nice
> to get some comments from the original patch author about this (were
> there e.g. crashes or some valgrind warnings observed or was this just
> speculation based on looking at the code).

There were valgrind "unintialized value" warnings related to this
after we started using it for parsing adv data (which is max 31 bytes
long but may be smaller because spec allows radio to strip non
significant bytes before sending, which explains why we added a length
parameter in a later patch). Actually I dont think the current code is
"safe" as it assumes the EIR data is aways 240 bytes long, which seems
true as per spec , but less data could be sent, causing reading beyond
buffer.

> Btw, it seems I may need to slow down on my response time to patches so
> there's better time for other people to review them too. E.g. both you
> and Luiz were a bit late to the game on a couple of recent patches.
> Maybe a 24 hour period before I push anything might be good enough?

I appreciate if you could send your comments ASAP, so we can fix them
quickly. Pushing upstream can be delayed for non trivial patches.

PS: I'm out of office until next Tuesday so I may not be able answer
quickly until then. thanks to Vinicius for pushing the patches fixed
versions :)

Regards
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
