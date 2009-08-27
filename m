Return-Path: <cyrus@holtmann.org>
Subject: Re: shared hci transport
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <302064.78581.qm@web94908.mail.in2.yahoo.com>
References: <639511.66794.qm@web94914.mail.in2.yahoo.com>
	 <1251309784.2950.95.camel@localhost.localdomain>
	 <302064.78581.qm@web94908.mail.in2.yahoo.com>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 12:29:08 -0700
Message-Id: <1251401348.2950.121.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

please don't do top-posting on this mailing list. We want proper inline
quoting.

> sure.
> the bcm4325 has uart transport for BT [so I can make use of hci_h4, say by hciattach - like bcm2035].
> The FM core understands hci-vendor specific command.
> 
> for example, I send HCI_VS opcode=0x20 to set the power of Rx to On.[The power on sequence also involves download of a firmware which is nothing but a file with ~10/20 hci-vendor specific commands with different opcodes].
> opcode 0x0a (say) to set the frequency and similarly in opcode 0x1d [audio enable] I give an data arguement 0x01 or 0x02 to say to FM Rx to put out audio on either it's analog lines or digital [i2s] lines..
> 
> Currently my fm stack, application is making use of hci_open_dev, send_cmd kind of hci lib calls to send commands.
> 
> Now what should be my approach to send in same sort of commands from the kernel space ?

For the firmware loading part, we have to change this whole driver model
and add an init stage that allows configuration etc.

I am not sold on the whole in-kernel approach for FM yet. We need to
talk more about it. Especially since vendor commands and messing with
the flow control is tricky.

Regards

Marcel


