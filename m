Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: BlueZ with HCI over SPI
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOT_U5Z0QanW-jMa6T4+b0aN+PjSwntBE8V1ZZ=_Qfb9X1p0HA@mail.gmail.com>
Date: Fri, 3 Nov 2017 09:59:40 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A54DC2AB-C202-4EB9-A6FA-4C20272D0C63@holtmann.org>
References: <CAOT_U5Z0QanW-jMa6T4+b0aN+PjSwntBE8V1ZZ=_Qfb9X1p0HA@mail.gmail.com>
To: Alan Martinovic <alan.martinovic@senic.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

> anyone knows the state of BlueZ and bluetooth for HCI over SPI?
> 
> Found a reference saying it isn't possible without doing kernel modifications:

HCI over SPI is not a standard. So it needs to be done with a vendor protocol. If that protocol is defined somewhere, it will require a driver in drivers/bluetooth/ to work. Normally these drivers are pretty simple, but a driver is needed.

Regards

Marcel

