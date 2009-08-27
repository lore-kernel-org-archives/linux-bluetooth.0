Return-Path: <cyrus@holtmann.org>
Message-ID: <302064.78581.qm@web94908.mail.in2.yahoo.com>
References: <639511.66794.qm@web94914.mail.in2.yahoo.com> <1251309784.2950.95.camel@localhost.localdomain>
Date: Thu, 27 Aug 2009 11:25:28 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: Re: shared hci transport
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1251309784.2950.95.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sure.
the bcm4325 has uart transport for BT [so I can make use of hci_h4, say by hciattach - like bcm2035].
The FM core understands hci-vendor specific command.

for example, I send HCI_VS opcode=0x20 to set the power of Rx to On.[The power on sequence also involves download of a firmware which is nothing but a file with ~10/20 hci-vendor specific commands with different opcodes].
opcode 0x0a (say) to set the frequency and similarly in opcode 0x1d [audio enable] I give an data arguement 0x01 or 0x02 to say to FM Rx to put out audio on either it's analog lines or digital [i2s] lines..

Currently my fm stack, application is making use of hci_open_dev, send_cmd kind of hci lib calls to send commands.

Now what should be my approach to send in same sort of commands from the kernel space ?

regards,
Pavan



----- Original Message ----
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
Cc: linux-bluetooth@vger.kernel.org
Sent: Wednesday, 26 August, 2009 11:33:04 PM
Subject: Re: shared hci transport

Hi Pavan,

> A lot of recent BT chips intefaced by UART also tend to have another radio [mostly FM] on the same chip sharing the transport interface i.e the UART. [bcm4325 for example has bt, fm and wlan].
> 
> I just wanted to know, from the user-space the hci0 socket interface allows me to concurrently use the uart from several applications, but
> is there a way in kernel to do the same ?
> 
> [say hci_h4 is also used by the fm core to understand some vendor specific commands ?]
> or in an usb case - the fm has int endpoint for control data of fm [+ hci-event/cmd packets] and bulk for rds[+ acl] [assuming the audio data path - is isolated from all these ...]

this all depends on the actual transports. I would need the
specifications to tell you more on the right way to deal with it.

Regards

Marcel


--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



      Thinking of ordering food? Find restaurant numbers on Yahoo! India Local http://in.local.yahoo.com/

