Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Nov 2011 17:36:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michael Schmitt <tcwardrobe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
Message-ID: <20111118153652.GA3647@fusion.localdomain>
References: <4EC679A0.7050309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC679A0.7050309@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Fri, Nov 18, 2011, Michael Schmitt wrote:
> adrastea:~# hcitool dev
> Devices:
>     hci0    11:11:11:11:11:11
> adrastea:~# hciconfig
> hci0:    Type: BR/EDR  Bus: USB
>     BD Address: 11:11:11:11:11:11  ACL MTU: 678:8  SCO MTU: 48:10
>     UP RUNNING PSCAN ISCAN
>     RX bytes:1461 acl:0 sco:0 events:44 errors:0
>     TX bytes:697 acl:0 sco:0 commands:44 errors:0
> 
> hci1:    Type: BR/EDR  Bus: USB
>     BD Address: 00:04:0E:8C:E2:93  ACL MTU: 120:20  SCO MTU: 24:5
>     DOWN
>     RX bytes:1086 acl:0 sco:0 events:39 errors:0
>     TX bytes:171 acl:0 sco:0 commands:39 errors:0
> 
> adrastea:~# hciconfig hci1 up
> Can't init device hci1: Connection timed out (110)
> adrastea:~#

I'm pretty sure we'll at least need to see the hcidump output for the
initialization sequence of this adapter (i.e. start hcidump before
calling hciconfig hci0 up) and show us the output. Which Bluetooth
version does this adapter support and how old is it?

Johan
