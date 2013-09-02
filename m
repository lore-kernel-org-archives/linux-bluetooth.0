Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130902124133.GP7440@joana>
References: <1378123071-16732-1-git-send-email-rakuco@FreeBSD.org>
	<20130902124133.GP7440@joana>
Date: Mon, 2 Sep 2013 15:26:10 +0200
Message-ID: <CAPs60XyE6FsdKFdvsui6JbEPWLhGGpSTHKUpPDMM3hp-vbhrRw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add support for BCM20702A0 [0b05, 17cb]
From: Tim Aerts <tim.koder@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Raphael Kubo da Costa <rakuco@freebsd.org>,
	linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Trust Bluetooth 4.0 USB module is also BCM20702A0. The id's are
0x21e8 and 0x0a5c.

Would you please add this one as well?

On Mon, Sep 2, 2013 at 2:41 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Raphael,
>
> 2013-09-02 Raphael Kubo da Costa <rakuco@FreeBSD.org>:
>
>> Yet another vendor specific ID for this chipset; this one for the ASUS
>> USB-BT400 Bluetooth 4.0 adapter.
>>
>> T:  Bus=03 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
>> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=0b05 ProdID=17cb Rev=01.12
>> S:  Manufacturer=Broadcom Corp
>> S:  Product=BCM20702A0
>> S:  SerialNumber=000272C64400
>> C:  #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
>> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
>> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
>> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Raphael Kubo da Costa <rakuco@FreeBSD.org>
>> ---
>>  drivers/bluetooth/btusb.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> Patch has been applied to bluetooth.git. Thanks.
>
>         Gustavo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
