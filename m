Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Add hci_h4p driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <201310180739.47841@pali>
Date: Fri, 18 Oct 2013 10:56:42 +0200
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <FA673359-08E1-4642-98D8-F66F457542C8@holtmann.org>
References: <1379703710-5757-1-git-send-email-pali.rohar@gmail.com> <201310172225.33343@pali> <3B0F039C-4680-46FF-A654-48D6A28B9B5E@holtmann.org> <201310180739.47841@pali>
To: =?iso-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pali,

>>>> This driver adding support for Nokia N900 bluetooth
>>>> hardware
>>>> 
>>>> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
>>>> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
>>>> ---
>>>> drivers/bluetooth/Kconfig             |   10 +
>>>> drivers/bluetooth/Makefile            |    2 +
>>>> drivers/bluetooth/hci_h4p/Makefile    |    7 +
>>>> drivers/bluetooth/hci_h4p/core.c      | 1085
>>>> +++++++++++++++++++++++++++++++++
>>>> drivers/bluetooth/hci_h4p/fw-bcm.c    |  149 +++++
>>>> drivers/bluetooth/hci_h4p/fw-csr.c    |  152 +++++
>>>> drivers/bluetooth/hci_h4p/fw-ti1273.c |  113 ++++
>>>> drivers/bluetooth/hci_h4p/fw.c        |  166 +++++
>>>> drivers/bluetooth/hci_h4p/hci_h4p.h   |  238 ++++++++
>>>> drivers/bluetooth/hci_h4p/uart.c      |  203 ++++++
>>>> include/linux/bluetooth/hci_h4p.h     |   41 ++
>>>> 11 files changed, 2166 insertions(+)
>>>> create mode 100644 drivers/bluetooth/hci_h4p/Makefile
>>>> create mode 100644 drivers/bluetooth/hci_h4p/core.c
>>>> create mode 100644 drivers/bluetooth/hci_h4p/fw-bcm.c
>>>> create mode 100644 drivers/bluetooth/hci_h4p/fw-csr.c
>>>> create mode 100644 drivers/bluetooth/hci_h4p/fw-ti1273.c
>>>> create mode 100644 drivers/bluetooth/hci_h4p/fw.c
>>>> create mode 100644 drivers/bluetooth/hci_h4p/hci_h4p.h
>>>> create mode 100644 drivers/bluetooth/hci_h4p/uart.c
>>>> create mode 100644 include/linux/bluetooth/hci_h4p.h
>>> 
>>> Can somebody look & comment this patch? What is needed to be
>>> part of upstream kernel?
>> 
>> you need to rebase against bluetooth-next at least.
> 
> Can you specify full url to that repo?

you can find that tree on git.kernel.org.

Regards

Marcel

