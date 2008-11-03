Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Nov 2008 21:56:10 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <1033346798.461081225729570756.JavaMail.root@mbv7.indiatimes.com>
In-Reply-To: <AE3DCD05-5DD3-46E0-8F1A-99233F557ABB@holtmann.org>
Subject: Re: Creation of AF_BLUETOOTH socket with HCI_DEV__REG
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have an application that does a hci_open_dev, and what I am trying to understand from the stack code is why can't [and further on how can..] my application do the hci_open_dev [basically the socket(AF_BLUETOOTH)], without the hcid service being On.

note: I have to do hciattach because I need to use UART.


----- Original Message -----
From: Marcel Holtmann <marcel@holtmann.org>
To: pavan savoy <pavan_savoy@indiatimes.com>
Cc: linux-bluetooth@vger.kernel.org
Sent: Fri, 31 Oct 2008 04:52:26 +0530 (IST)
Subject: Re: Creation of AF_BLUETOOTH socket with HCI_DEV__REG

Hi Pavan,

> Can there be a scenario where an application can do a hci_open_dev  
> and use the Bluetooth Socket, without actually the HCID recieving  
> the HCI_DEV_REG ?
>
> Say a scenario where in only hciattach has been done [UART device]  
> and HCID isn't run at all. Then would any other application make use  
> of the hci_open_dev calls ?

I have really no idea what you are trying to achieve here. hciattach  
and hcid are not tight together at all.

Regards

Marcel




--
Hyundai to launch the i20 in India. Catch the exclusive preview on ZigWheels.com
http://www.zigwheels.com/b2cam/newsDetails.action?name=Emb11_20080731&path=/INDT/News/Emb11_20080731&page=1&pagecount=2&utm_source=indmail&utm_medium=footer&utm_content=tracking&utm_campaign=Nletter_07oct2008_ZW
