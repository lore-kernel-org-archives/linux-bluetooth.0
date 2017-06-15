Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOsEZogeJC0rfMEiyr18pFoR2-=ixcaMuFNb_n8+fuDu3eAbYQ@mail.gmail.com>
References: <CAOsEZogeJC0rfMEiyr18pFoR2-=ixcaMuFNb_n8+fuDu3eAbYQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 15 Jun 2017 15:57:08 +0300
Message-ID: <CABBYNZL+qu-naNRSUQu=cGby4w+OU6hAvVLZgSypOk+mY3538A@mail.gmail.com>
Subject: Re: RFCOMM socket receive timeout with Bluez 5, but not on Bluedroid
To: Jay Aurabind <jay.aurabind@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jay,

On Tue, Jun 13, 2017 at 8:27 PM, Jay Aurabind <jay.aurabind@gmail.com> wrote:
> Hi,
>
> I am connecting to a custom bluetooth device (uses RN-42 module). I am
> using SPP which I connect from Android (BlueTerm app). The device
> continuously sends data through the serial port, and I keep receiving
> it in the android app.
>
> I have  pybluez based application (on Arch Linux, Bluez 5) that
> connect to RFCOMM socket. This stops receiving data after few seconds,
> and I get a timeout error:
>
> Traceback (most recent call last):
>   File "Launch.py", line 434, in run
>     Data = self.sockRF.recv(1)
>   File "<string>", line 5, in recv
> bluetooth.btcommon.BluetoothError: (110, 'Connection timed out')
>
> What could possible be the reasons?

Please check with btmon that should tell the reason why it is disconnecting.

> Are there any other methods I can programmatically connect to the data
> stream though Bluez 5 ?

You could use L2CAP directly but Android probably don't support that.

>
> --
>
> Thanks and Regards,
> Aurabindo J
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
