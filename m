Return-Path: <cyrus@holtmann.org>
Message-ID: <4EF30EE3.6050602@monom.org>
Date: Thu, 22 Dec 2011 12:05:07 +0100
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: bubba junk <junkbubba2@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth Headset Connection Issue Linux v3.0
References: <CAMk70DBANeAndgm-nV=9Cgt2tvz=dRmd8WdpnJkNTe=a2LDugA@mail.gmail.com>
In-Reply-To: <CAMk70DBANeAndgm-nV=9Cgt2tvz=dRmd8WdpnJkNTe=a2LDugA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi bubba,

On 21.12.2011 23:40, bubba junk wrote:
> I am new to posting to mailing lists, so forgive me in advance if I am not
> following protocol. I have an issue connecting to my bluetooth headset in
> Ubuntu 11.10 Linux Kernel 3.0.0-14-generic. I am able to pair and connect
> at first. But after disconnecting, I am no longer able to connect. I have to
> un-pair then re-pair the device to connect again. After re-paring the headset
> , it stays connected until I disconnect. Then again after disconnecting,
> I am not able to connect. I saw some regression bug documentation to something
> similar in Linux 2.6. Is this a known bug in 3.0?
> 
> Thanks in advance for your help. Sorry for such a newbie question.

I am experience the something very similar here. I though my setup is
broken but maybe it isn't only on my system.

I started to debug it but had to fix other pressing things first. My
current understanding is that in on my system for some reasons the PC
does after a fresh pairing a correct encryption of the connection. After
that it does not encrypt it anymore and the device rejects the connection.

Be aware that this is not really proven yet. Luckily I have a BT sniffer
on my table... just need more time...

cheers,
daniel

