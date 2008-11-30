Return-Path: <cyrus@holtmann.org>
Subject: Re: Creation of AF_BLUETOOTH socket with HCI_DEV__REG
From: Marcel Holtmann <marcel@holtmann.org>
To: pavan_savoy@indiatimes.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1033346798.461081225729570756.JavaMail.root@mbv7.indiatimes.com>
References: <1033346798.461081225729570756.JavaMail.root@mbv7.indiatimes.com>
Content-Type: text/plain
Date: Sun, 30 Nov 2008 11:35:38 +0100
Message-Id: <1228041338.9176.11.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I have an application that does a hci_open_dev, and what I am trying to understand from the stack code is why can't [and further on how can..] my application do the hci_open_dev [basically the socket(AF_BLUETOOTH)], without the hcid service being On.
> 
> note: I have to do hciattach because I need to use UART.

it still makes no sense. And you don't need hcid to make Bluetooth work.
However you will be fairly limited to what you can do when it you run a
system without hcid or bluetoothd for that matter.

Regards

Marcel


