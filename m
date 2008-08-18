Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Aug 2008 14:52:59 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <1218723017.243101219051379693.JavaMail.root@mbv7.indiatimes.com>
In-Reply-To: <1219036440.7591.19.camel@violet.holtmann.net>
Subject: Re: Understanding UART bluetooth ..
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Thanks got it clarified. It was basically on the notify mechanism of the bluetooth, and user-space kernel-space interaction.

On hciattach, the HCIUARTSETPROTO ioctl causes "hci_uart_register_dev" to be called [in the line discipline driver], which causes "hci_register_dev" to be called which calls the "hci_notify", which notifies the in-kernel HCI socket layer, which then passes the same to the socket on the user-space.

I hope my understanding is correct.


Thanks.


----- Original Message -----
From: Marcel Holtmann <marcel@holtmann.org>
To: pavan savoy <pavan_savoy@indiatimes.com>
Cc: linux-bluetooth@vger.kernel.org
Sent: Mon, 18 Aug 2008 10:44:00 +0530 (IST)
Subject: Re: Understanding UART bluetooth ..

Hi,

> I had a question on hciattach / hcid & related to hci-core.c, If I know I have a bluetooth device on ttyS0.. and I do a 
> #hciattach ttyS0 <with_relevant_parameters>
> 
> will the whole system know [using dbus & hcid, that a new device  has been added, if so who exactly does this ? ]
> 
> I mean I could only find hci_open_dev, but no other dbus or hcid functions to notify...
> 
> does hci_notify does the same ? which is being called on hci_open_dev?

what is your actual question here? I don't have the slightest idea.

Regards

Marcel
