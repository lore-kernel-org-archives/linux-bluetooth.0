Return-Path: <cyrus@holtmann.org>
From: "Inga Stotland" <ingas@codeaurora.org>
To: "'Anderson Lizardo'" <anderson.lizardo@openbossa.org>,
	"'Vinicius Costa Gomes'" <vinicius.gomes@openbossa.org>,
	<linux-bluetooth@vger.kernel.org>,
	"'Bruna Moreira'" <bruna.moreira@openbossa.org>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>	<20101111210705.GB24514@jh-x301>	<000b01cb8200$02c24c90$0846e5b0$@org>	<20101112165434.GA13238@jh-x301> <AANLkTi=J39omUnYYWLpB0ncd6Kd8LukdFopM4WDyWNJ1@mail.gmail.com>
In-Reply-To: <AANLkTi=J39omUnYYWLpB0ncd6Kd8LukdFopM4WDyWNJ1@mail.gmail.com>
Subject: RE: [PATCH v2 1/7] Fix invalid memory access when EIR field length is zero
Date: Mon, 15 Nov 2010 16:41:07 -0800
Message-ID: <000001cb8526$f580edf0$e082c9d0$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org
[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Anderson Lizardo
Sent: Friday, November 12, 2010 5:01 PM
To: Inga Stotland; Vinicius Costa Gomes; linux-bluetooth@vger.kernel.org;
Bruna Moreira
Subject: Re: [PATCH v2 1/7] Fix invalid memory access when EIR field length
is zero

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

---------------
Just a note...
When Extended Inquiry Response HCI event comes to the upper layer parser
from 
HCI layer it is guaranteed to contain 240 bytes where of course the non 
significant part is zeroed out. This is ensured by internal implementation 
in BlueZ and is spec compliant.

The fix is fine since it takes care of warnings, but personally I am a big
fan of 
keeping meaningful variable names :)

Regards, 

Inga Stotland

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


