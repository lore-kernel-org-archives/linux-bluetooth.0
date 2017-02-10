Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Bose Quiet Comfort 35 Remaining Battery Reporting
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <589DCA8A.3060905@gmail.com>
Date: Fri, 10 Feb 2017 15:48:08 +0100
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <F332B3A2-F715-4526-A161-0B13CFBACEFE@holtmann.org>
References: <58989E88.4000005@gmail.com> <5899CA52.8020607@gmail.com>
 <CABBYNZ+Msa3ObRKT-fe70YitPB+OA15hoPcwT2_XSSN8jgAN3g@mail.gmail.com>
 <589B0EB7.10903@gmail.com>
 <CABBYNZKQGsQD_Zzy0AVpyS+Ufy29ovm-2GooSFvy1e=BGAFKJQ@mail.gmail.com>
 <2D4036B9-473E-45B2-A9DE-DEC13EAD2F94@holtmann.org>
 <589DCA8A.3060905@gmail.com>
To: Hugues <morisset.hugues@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hugues,

>>>> Thanks for the reply, I know the bose android application do report the
>>>> battery power of the headset, but I don't know if it is done in a
>>>> propitiatory manner. How could I check that ?
>>> 
>>> It is probably the 00000000-deca-fade-deca-deafdecacaff service, Ive
>>> also seem some bose devices that are dual-mode so they have a GATT
>>> service over LE that might expose these details.
>> 
>> or it uses the Apple HFP extensions they defined to get battery status. Also 00000000-deca-fade-deca-deafdecacaff should be the wireless version of Apple’ iAP (iPod Accessory Protocol).
> 
> This headset do have dual mode, I searched around using gatttool ant the
> gatt specification but I find nothing about Battery Level
> (org.bluetooth.characteristic.battery_level.xml) or Battery Service
> (org.bluetooth.service.battery_service.xml). How could I read what's in
> the APple HFP extensions ?

Start with this one. It describes the extra HFP AT commands that iOS uses:

https://developer.apple.com/hardwaredrivers/BluetoothDesignGuidelines.pdf

Regards

Marcel

