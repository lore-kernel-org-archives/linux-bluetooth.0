Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: Consistent enumeration of a btattached controller
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOT_U5bmJ5ibBV2uGQZpbYHMN2=JtTc7qHsJ7mWiK5qvWfRjyQ@mail.gmail.com>
Date: Tue, 12 Dec 2017 16:50:34 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <77C06461-9526-4497-8124-9BD7D3547975@holtmann.org>
References: <CAOT_U5aVg7PcOToHRPww3jg=KpOy-n=p3a5BgEXO8kXeAwLtvQ@mail.gmail.com>
 <CAOT_U5bmJ5ibBV2uGQZpbYHMN2=JtTc7qHsJ7mWiK5qvWfRjyQ@mail.gmail.com>
To: Alan Martinovic <alan.martinovic@senic.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

> I have a controller that is attached with btattach
> as a systemd service:
> 
> /usr/bin/btattach -B /dev/ttyACM0 -S 1000000
> 
> The same command seems to result in different
> enumerations. Sometimes its:
> 
> $ busctl tree org.bluez
> └─/org
>  └─/org/bluez
>    └─/org/bluez/hci1
> 
> other times:
> 
> $ busctl tree org.bluez
> └─/org
>  └─/org/bluez
>    └─/org/bluez/hci0
> 
> Is there a way to have fixed enumeration?

the hciX naming is assigned by the kernel and can not be guaranteed. For BR/EDR single mode or BR/EDR/LE dual-mode controller, you can read the property for the Bluetooth Device Address to find and match the controller.

Regards

Marcel

