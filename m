Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <346b1f21-e4f8-fd90-ed08-8cd5614fde7d@lnihealth.com>
References: <346b1f21-e4f8-fd90-ed08-8cd5614fde7d@lnihealth.com>
From: Juha Kuikka <juha.kuikka@gmail.com>
Date: Thu, 22 Dec 2016 18:39:19 -0800
Message-ID: <CAKvrXUpKs2MP9fP3X3hUUt2FniM_WXcK5+vX=OE6EZuYbh1v8A@mail.gmail.com>
Subject: Re: Changing authentication requirements in older kernel
To: Tom Harada <tomharada@lnihealth.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

I cannot be sure without a full log but I had a very similar problem
with the Microsoft Folding Keyboard and kernel v3.8.

This kernel patch was a fix for my case.
https://patchwork.kernel.org/patch/5165761/

It sets the pending security level to high, which means encryption +
MITM if the Security Request indicated a need for MITM. This in turn
forces the MITM bit to be sent in the Pairing Request.

Hope it helps!

Cheers,
 - Juha

On Thu, Dec 22, 2016 at 1:47 PM, Tom Harada <tomharada@lnihealth.com> wrote:
> Hi all,
>
> I have a BLE device that is unusually picky about the pairing requests it
> receives. As far as I can tell, it will not pair if the MITM bit in the
> authentication requirements is not set, or if the initiator key distribution
> field is not set. It will not pair with BlueZ running under kernel 3.10.17,
> where the pairing request looks like this:
>
> < ACL Data TX: Handle 64 flags 0x00 dlen 11
>       SMP: Pairing Request (0x01) len 6
>         IO capability: KeyboardOnly (0x02)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, No MITM, Legacy, No Keypresses
> (0x01)
>         Max encryption key size: 16
>         Initiator key distribution: <none> (0x00)
>         Responder key distribution: EncKey (0x01)
>
> It will pair under kernel 4.4.11, where the pairing request looks like this:
>
> < ACL Data TX: Handle 64 flags 0x00 dlen 11
>       SMP: Pairing Request (0x01) len 6
>         IO capability: KeyboardOnly (0x02)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding - MITM (0x05)
>         Max encryption key size: 16
>         Initiator key distribution: EncKey IdKey Sign (0x07)
>         Responder key distribution: EncKey IdKey Sign (0x07)
>
> I would like to make the older kernel's handling of pairing requests match
> the newer one's. I'm having some success using newer Bluetooth kernel
> modules from backports (3.15.9-1 appears to give the desired behavior), but
> I don't know if this is a good long-term solution since the target system is
> not using a mainline kernel. Is it possible to change the authentication
> requirements and/or initiator key distribution in user space?
>
> Thanks,
> Tom Harada
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
