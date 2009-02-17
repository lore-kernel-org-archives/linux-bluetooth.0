Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2ced936d0902131746r5750ac92q81a1316016f6b492@mail.gmail.com>
References: <2ced936d0902131746r5750ac92q81a1316016f6b492@mail.gmail.com>
Date: Mon, 16 Feb 2009 21:58:49 -0300
Message-ID: <2ced936d0902161658s66ca8b9dn89d768b78d8106cc@mail.gmail.com>
Subject: Re: Sending frames other than IP type 0x800 via BNEP
From: Breno Jacinto <breno@freeunix.com.br>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

     I'm not sure if this was the right list to post this question -
I'm sorry if it is not. I'm wondering if there's a proper mailing list
for covering details of BlueZ implementation.

thanks in advance,

-- 
-- 
:: Breno Jacinto ::
:: breno - at - gprt.ufpe.br ::
:: FingerPrint ::
   2F15 8A61 F566 E442 8581
   E3C0 EFF4 E202 74B7 7484
:: Persistir no difícil é a única maneira de torná-lo fácil algum dia.  ::


2009/2/13 Breno Jacinto <breno@freeunix.com.br>:
> Hello,
>
>   I'm currently trying to exchange messages in a Bluetooth BNEP
> network, _without_using the IP protocol, but sending raw ethernet
> frames directly. According to the BNEP specification[1], there's a
> Network Protocol Type which is set for Ethernet frames coming from the
> IP layer, whose value is 0x800. I have tried to send IP packets,
> including broadcasts, and they go normally over a BNEP network.
>
>   On the other hand, sending a customized frame seems impossible. The
> node keeps sending the frame, but no destination receives it. So, back
> to the specification,  on page 22 there's a section about BNEP filter
> protocol type, specifying which protocol types should be filtered and
> not transmitted over BNEP. But then they go on and mention that by
> default everything should be allowed, so, even if I'm transmitting a
> frame type 0x8765, in theory it should be sent and no filter should
> block it.
>
>    Well, that's the only hypothesis I can elaborate up to now. Since
> I'm not familiar with the implementation of BNEP in the BlueZ stack,
> I'd kindly ask you guys if you have any other idea of what may be
> happening and if there's a fix for this in the current implementation.
>
> [1] http://grouper.ieee.org/groups/802/15/Bluetooth/BNEP.pdf
>
> best regards,
> --
> --
> :: Breno Jacinto ::
> :: breno - at - gprt.ufpe.br ::
> :: FingerPrint ::
>   2F15 8A61 F566 E442 8581
>   E3C0 EFF4 E202 74B7 7484
> :: Persistir no difícil é a única maneira de torná-lo fácil algum dia.  ::
>
