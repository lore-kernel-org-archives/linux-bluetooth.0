Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1341472848.1963.34.camel@aeonflux>
References: <CADX0rsZBM+2Sz564FrkVxe318dCFue_pea_OLpxvrk5bd9cHWQ@mail.gmail.com>
	<1341472848.1963.34.camel@aeonflux>
Date: Thu, 5 Jul 2012 15:42:45 +0800
Message-ID: <CADX0rsYksswwWK-4-UYXt_k7squWeCFhwK18=mDAZ=P6L1-zVw@mail.gmail.com>
Subject: Re: BT LMP
From: victor yeo <victoryeo1974@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

When LMP_not_accepted is received by Bluetooth Chip's firmware, it
will send a HCI event to the linux kernel bluetooth portion. Do i
understand correctly? What is the HCI event name?

Thanks,
Victor

On Thu, Jul 5, 2012 at 3:20 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Victor,
>
>> Anyone know which part of linux kernel processes the LMP au_rand and
>> LMP not_accepted event?
>>
>> I want to modify the Bluetooth kernel code so that when it receives
>> LMP not_accepted event, it will do re-pairing.
>
> LMP is implemented in the Bluetooth chip's firmware and not the kernel.
>
> Regards
>
> Marcel
>
>
