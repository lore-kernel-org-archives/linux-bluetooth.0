Return-Path: <Steven.Singer@csr.com>
Message-ID: <40323EC2.8080203@csr.com>
Date: Tue, 17 Feb 2004 16:18:10 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: grpmind+bluez.users@boromir.vpop.net,
   BlueZ Mailing List
    <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
References: <200402171142.i1HBgRV5023132@mail.holtmann.net>
    <1077018777.2841.5.camel@pegasus>
In-Reply-To: <1077018777.2841.5.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
> Matt wrote:
>> # hcitool rssi 00:04:3E:81:90:E0
>> RSSI return value: 0
>> # hcitool lq 00:04:3E:81:90:E0
>> Link quality: 255
>> # hcitool tpl 00:04:3E:81:90:E0
>> Current transmit power level: -8
>> 
>> 
>> Does all this mean that my ipaq has a slow UART?
> 
> No, because the link quality and the RSSI has nothing to do with the
> choosen packet type.

Marcel, I don't think this is what Matt meant. I think he was asking
that given that the link quality and power levels are good and given
that he can't get more that 265 kbps regardless of packet type, is it
likely that he's being limited by some component of the system other
than the Bluetooth link - such as the UART baud rate on the Ipaq.

Is there an easy way to find out what baud rate the Ipaq is using?
That would answer the question straight away. 265 kbps over the air
is equivalent to roughly 350 kbps over the UART (assuming one start bit,
one stop bit, no parity and large HCI packets).

Also, although you're right that the RSSI has nothing to do with the
chosen packet type, the link quality has a big effect. As the link
quality falls, devices will tend to switch automatically from DH
packets to the more robust DM packets.

	- Steven
-- 



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
