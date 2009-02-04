Return-Path: <cyrus@holtmann.org>
Subject: Re: BlueZ pairing failure and kernel 2.6.24 crash
From: Marcel Holtmann <marcel@holtmann.org>
To: Frederic Danis <frederic.danis@access-company.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49886819.2030401@access-company.com>
References: <49886819.2030401@access-company.com>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 19:34:26 +0100
Message-Id: <1233772466.12562.6.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

> I am working with BlueZ 3.22, kernel 2.6.24 on ARM and found 2 problems :
> 
> -  I am not able to pair with some phones (Nokia N70 and sony-ericsson 
> P800). After some investigations, I found that a "L2CAP information 
> request packet" is sent just after the ACL connection. Both phones reply 
> with "command rejected" error, then disconnect the ACL link before BlueZ 
> is able to finish the pairing (see attached traces).
> 
> - with some other phones (LG 990 Viewty and sony-ericsson T610), the 
> kernel crashes after pairing initiated by the phone is completed.
> 
> For the first problem I removed the send of the "L2CAP information 
> request packet" in the kernel (see attached patch). This fixes both 
> problems.
> 
> I did not found any usage of the remote L2CAP information in kernel.
> Is sending "L2CAP information request packet" mandatory for upper layer 
> and/or qualification ?
> Is my fix OK ?

sending the L2CAP info is just fine. It should not cause any problems. I
think it is the pairing code that does some weird things at the wrong
time. Can you test with bluetooth-testing.git against bluez-4.28 to
verify that this issue still exists.

Regards

Marcel


