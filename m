Return-Path: <cyrus@holtmann.org>
Subject: Re: shared hci transport
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <639511.66794.qm@web94914.mail.in2.yahoo.com>
References: <639511.66794.qm@web94914.mail.in2.yahoo.com>
Content-Type: text/plain
Date: Wed, 26 Aug 2009 11:03:04 -0700
Message-Id: <1251309784.2950.95.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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


