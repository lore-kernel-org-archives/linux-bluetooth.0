Return-Path: <morisset.hugues@gmail.com>
Subject: Re: Bose Quiet Comfort 35 Remaining Battery Reporting
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <58989E88.4000005@gmail.com> <5899CA52.8020607@gmail.com>
 <CABBYNZ+Msa3ObRKT-fe70YitPB+OA15hoPcwT2_XSSN8jgAN3g@mail.gmail.com>
 <589B0EB7.10903@gmail.com>
 <CABBYNZKQGsQD_Zzy0AVpyS+Ufy29ovm-2GooSFvy1e=BGAFKJQ@mail.gmail.com>
 <2D4036B9-473E-45B2-A9DE-DEC13EAD2F94@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Hugues <morisset.hugues@gmail.com>
Message-ID: <589DCA8A.3060905@gmail.com>
Date: Fri, 10 Feb 2017 15:13:30 +0100
MIME-Version: 1.0
In-Reply-To: <2D4036B9-473E-45B2-A9DE-DEC13EAD2F94@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 02/08/2017 02:19 PM, Marcel Holtmann wrote:
> Hi Luiz,
> 
>>> Thanks for the reply, I know the bose android application do report the
>>> battery power of the headset, but I don't know if it is done in a
>>> propitiatory manner. How could I check that ?
>>
>> It is probably the 00000000-deca-fade-deca-deafdecacaff service, Ive
>> also seem some bose devices that are dual-mode so they have a GATT
>> service over LE that might expose these details.
> 
> or it uses the Apple HFP extensions they defined to get battery status. Also 00000000-deca-fade-deca-deafdecacaff should be the wireless version of Apple’ iAP (iPod Accessory Protocol).
> 
> Regards
> 
> Marcel
> 
> 

This headset do have dual mode, I searched around using gatttool ant the
gatt specification but I find nothing about Battery Level
(org.bluetooth.characteristic.battery_level.xml) or Battery Service
(org.bluetooth.service.battery_service.xml). How could I read what's in
the APple HFP extensions ?
