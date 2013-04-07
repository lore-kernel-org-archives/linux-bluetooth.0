Return-Path: <cyrus@holtmann.org>
Message-ID: <5161F474.5030405@gmail.com>
Date: Mon, 08 Apr 2013 00:34:28 +0200
From: Sergio Callegari <sergio.callegari@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Kernel panic on kernel 3.8.x when closing bluetooth dun connection
References: <51498CFE.9060804@gmail.com> <20130320161712.GA27840@kroah.com>
In-Reply-To: <20130320161712.GA27840@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm following up with a previous email where I was reporting a 
systematic kernel panic when closing a bluetooth DUN connection.

I have made a few more tests:

- Bug happens with all the 3.8.x kernel series, up to the latest 3.8.6
- Bug is not present up to 3.7.x, including the latest 3.7.10
- Bug happens on the DELL E6500 laptop that has a Dell Computer Corp. 
Wireless 370 Bluetooth Mini-card
- Bug also happens on a desktop that has a Cambridge Silicon Radio, Ltd 
Bluetooth Dongle (HCI mode)

Let me recall that the bug is triggered by connecting to the internet 
via a mobile phone, using bluetooth DUN and then disconnecting. Kernel 
panics on disconnection (the phone I am using is a Samsung Galaxy S Plus)

- Bug does not happen on the same machines when connecting to the 
internet via ppp using a usb-umts dongle

Hope this can helps haunting the regression.

Thanks for the attention,

Sergio
