Return-Path: <cyrus@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
Message-Id: <AE3DCD05-5DD3-46E0-8F1A-99233F557ABB@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: pavan_savoy@indiatimes.com
In-Reply-To: <1307132544.125351225396822791.JavaMail.root@mbv7.indiatimes.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Creation of AF_BLUETOOTH socket with HCI_DEV__REG
Date: Fri, 31 Oct 2008 00:22:26 +0100
References: <1307132544.125351225396822791.JavaMail.root@mbv7.indiatimes.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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

