Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100202171612.GA7034@vigoh>
References: <912bb79a1002020858lda468aci6fef3e73fac07bd6@mail.gmail.com>
	 <20100202171612.GA7034@vigoh>
Date: Wed, 3 Feb 2010 10:21:13 +0530
Message-ID: <912bb79a1002022051o1faf229en95605084fa0e380b@mail.gmail.com>
Subject: Re: Kernel panic when SCO connection
From: nirav rabara <niravrabara@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

- Show quoted text -
On Tue, Feb 2, 2010 at 10:46 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Nirav,
>
> * nirav rabara <niravrabara@gmail.com> [2010-02-02 22:28:53 +0530]:
>
>> Hi,
>> When I try to connect SCO socket, Kernel getting crash.
>> Linux kernel - 2.6.22
>> Bluez - 4.58
>
> Please try a 2.6.33 kernel and tell us if the bug still happens.
>
>>
>> error message,
>> __tx_submit:hci0 tx submit failed urb c0552c14 type 3 err -19
>>
>> sometimes in connection is showing error while connection as below,
>> hci_acldata_packet:hci0 ACL packet data for unknown connection handler 2
>>
>> It would be really appreciable if  somebody put some on light on this
>> issue, OR suggest me any patch or documentation.
>>
>> --
>> With Regards,
>> Nirav Rabara
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Gustavo F. Padovan
> http://padovan.org
>
> ProFUSION embedded systems - http://profusion.mobi
>

Hi Gustavo,

Thanks for your suggestion, but I am using bluez 4.58 on ATMEL
AT91SAM9263, no patch available for the newer kernel 2.6.33 . Patches
related to my board only available up to 2.6.30.

It would be a great help if suggest me any alternet for this issue. OR
any patches for the same problem as i mentioned for 2.6.22.


--
With Regards,
Nirav Rabara
