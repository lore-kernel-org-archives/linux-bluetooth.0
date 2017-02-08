Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Bose Quiet Comfort 35 Remaining Battery Reporting
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKQGsQD_Zzy0AVpyS+Ufy29ovm-2GooSFvy1e=BGAFKJQ@mail.gmail.com>
Date: Wed, 8 Feb 2017 14:19:39 +0100
Cc: Hugues <morisset.hugues@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <2D4036B9-473E-45B2-A9DE-DEC13EAD2F94@holtmann.org>
References: <58989E88.4000005@gmail.com> <5899CA52.8020607@gmail.com>
 <CABBYNZ+Msa3ObRKT-fe70YitPB+OA15hoPcwT2_XSSN8jgAN3g@mail.gmail.com>
 <589B0EB7.10903@gmail.com>
 <CABBYNZKQGsQD_Zzy0AVpyS+Ufy29ovm-2GooSFvy1e=BGAFKJQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> Thanks for the reply, I know the bose android application do report the
>> battery power of the headset, but I don't know if it is done in a
>> propitiatory manner. How could I check that ?
> 
> It is probably the 00000000-deca-fade-deca-deafdecacaff service, Ive
> also seem some bose devices that are dual-mode so they have a GATT
> service over LE that might expose these details.

or it uses the Apple HFP extensions they defined to get battery status. Also 00000000-deca-fade-deca-deafdecacaff should be the wireless version of Apple’ iAP (iPod Accessory Protocol).

Regards

Marcel

