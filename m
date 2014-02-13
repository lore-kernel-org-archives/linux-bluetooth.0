Return-Path: <cyrus@holtmann.org>
Message-ID: <52FD3BF7.9000009@ahsoftware.de>
Date: Thu, 13 Feb 2014 22:41:11 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>,
 Marcel Holtmann <marcel@holtmann.org>
CC: Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Gianluca Anzolin <gianluca@sottospazio.it>,
 Andrey Vihrov <andrey.vihrov@gmail.com>,
 Sander Eikelenboom <linux@eikelenboom.it>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/24] rfcomm fixes
References: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 10.02.2014 02:59, schrieb Peter Hurley:
> Marcel,
>
> This patch series addresses a number of previously unknown issues
> with the RFCOMM tty device implementation, in addition to
> addressing the locking regression recently reported [1].
>
> As Gianluca suggested and I agree, this series first reverts
> 3 of the 4 patches of 3.14-rc1 for bluetooth/rfcomm/tty.c.

Oh, looks like you've spend quiet some time to fix rfcomm.

Thanks a lot for that!

I've just tested this series on top of 3.13.2 where I already have 
Gianluca 4 patches applied. Test machines were one AMD (x86_64) (bluez 
4.x) and one ARM(v5) (bluez 5.x) box and I could not find any problems 
during my short tests (disconnecting/turning of both local and remote 
and reconnecting).

I haven't had any debug options turned on and haven't looked at the 
patches at all, but maybe this is already enough to add a

Tested-By: Alexander Holler <holler@ahsoftware.de>

So feel free to add that if someone thinks it makes sense based on my 
short test description above and it isn't already too late.

Thanks again,

Alexander Holler
