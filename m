Return-Path: <egrojorge@terra.es>
Date: Sun, 9 May 2004 13:35:53 +0200
From: =?ISO-8859-1?B?Sm9yZ2UgQS4gR29ueuFsZXo=?= <egrojorge@terra.es>
Reply-To: egroJorge <egroJorge@terra.es>
Message-ID: <155715390.20040509133553@terra.es>
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re[2]: [Bluez-devel] uclinux and bluez
In-Reply-To: <1084054174.4420.169.camel@pegasus>
References: <1083853467.28356.18.camel@pancho>
 <1083877519.4420.78.camel@pegasus>  <1083925117.1946.36.camel@pancho>
 <1083946524.4420.124.camel@pegasus>  <143918984.20040508155253@terra.es>
 <1084054174.4420.169.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel escribió:

M> Hi Jorge,
M> what kind of hciattach command do you use?

#hciattach -n /dev/tts/2 any 115200 flow

M> What kind of Bluetooth module
M> do you use?

It is made by Taiyo Yuden. I dont remember the exact reference, but I
can look for it (tomorrow at work)

M> What endian is your ucLinux platform?

Little endian

>> I know it is not an elegant method and maybe this will only work with
>> my hardware configuration. I have no idea of why "ioctl(fd,
>> HCIUARTSETPROTO, u->proto)" is not working but I suppossed it was
>> fault of the uclinux system (it has a 2.4.20 linux kernel).

M> This ioctl sets the H4 or BCSP mode of the hci_uart driver.


Thanks for your interest,

Jorge
