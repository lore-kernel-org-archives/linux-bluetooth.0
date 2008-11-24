Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F9029075-34B5-4DE1-98EA-E990C82C7495@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthieu CASTET <matthieu.castet@parrot.com>
In-Reply-To: <491868E6.6000406@parrot.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: btusb and HCI_RAW
Date: Mon, 24 Nov 2008 03:57:01 +0100
References: <491868E6.6000406@parrot.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthieu,

> with HCI_RAW, application can bypass the bluez stack and send raw  
> stuff
> to dongle.
>
> This seems not possible anymore with btusb because it uses
> "hdev->conn_hash" to check if ACLDATA/SCODATA should be send/received.
>
> These checks make the HCI_RAW mode a bit useless (ie not working for  
> acl
> and sco).
>
> Can we make the HCI_RAW work like before with acl and sco data ?
> For example we can ignore theses check in HCI_RAW mode and send a  
> notify
> event when we turn on/off HCI_RAW mode.

we could, but that will cost a lot of CPU power. The SCO data packets  
are just not an option here. Also without a full blown Bluetooth  
stack, you don't know with alternate setting to use. So this is a  
little bit pointless here and before just worked by pure luck. Why do  
you want this support in the first place?

Regards

Marcel

