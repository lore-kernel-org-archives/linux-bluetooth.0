Return-Path: <cyrus@holtmann.org>
Message-ID: <4ABB952F.6020208@pardus.org.tr>
Date: Thu, 24 Sep 2009 18:50:07 +0300
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
MIME-Version: 1.0
To: Kartikey Parmar <kartikey2781@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: hci_cmd_task:hci0 command tx timeout
References: <6887eb5d0909240501o3f7e959ewf797e18dd09e2fd4@mail.gmail.com>
In-Reply-To: <6887eb5d0909240501o3f7e959ewf797e18dd09e2fd4@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Kartikey Parmar wrote:
> Hi,
>
> I m getting "hci_cmd_task:hci0 command tx timeout" during connect()
> socket call for SCO connection.
>
> Exactly why this timeout is occured. I m using Bluez-4.52 with kernel
> 2.6.30 on AT91SAM9263.
>
>
>   


Not me but a user on our bugzilla reported that on 2.6.30(.5), he's
having those timeouts when he tries to scan using hcitool. I've searched
on the internet, found a lot of bug reports which seems to be
resolved/fixed post 2.6.28. The user says that the dongle is working OK
on other operating systems.

Do we have some means for debugging further the cause of this problem?

Thanks,
