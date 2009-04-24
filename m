Return-Path: <cyrus@holtmann.org>
Message-ID: <49F15E1B.6060800@d-meeus.be>
Date: Fri, 24 Apr 2009 08:37:15 +0200
From: =?UTF-8?B?RG9taW5pcXVlIE1lZcO5cw==?= <dominique@d-meeus.be>
MIME-Version: 1.0
To: Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
CC: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Subject: Re: [PATCH] Bluetooth: add support for Integrated System Solution
 devices
References: <1240169747-15998-1-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1240169747-15998-1-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Gustavo F. Padovan a écrit ce qui suit, le 19/04/09 21:35 :
> Just add the device id to btusb...
>  
> +	/* Integrated System Solution devices */
> +	{ USB_DEVICE(0x1131, 0x1004), .driver_info = BTUSB_WRONG_SCO_MTU },
>   
I have hciconfig -a
hci0:    Type: USB
    ...
    UP RUNNING
    ...
Can't read local name on hci0: Connection timed out (110)

with the Broadcom based D-Link: lsusb
Bus 003 Device 002: ID 2001:f111 D-Link Corp. [hex] DBT-122 Bluetooth 
adapter

Is it the same problem? Could it be solved the same way?



