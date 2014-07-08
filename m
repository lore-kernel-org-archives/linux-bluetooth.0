Return-Path: <cyrus@holtmann.org>
Message-ID: <53BB9E5F.9020101@ahsoftware.de>
Date: Tue, 08 Jul 2014 09:31:43 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Peng Chen <pengchen@qti.qualcomm.com>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 kumo@qca.qualcomm.com, taowang@qti.qualcomm.com
Subject: Re: [PATCH] Add a new PID/VID 0cf3/e005 for AR3012.
References: <1377853792-17589-1-git-send-email-pengchen@qca.qualcomm.com> <53A40687.80004@ahsoftware.de> <850D59CB-8032-4095-AB96-61920042DC55@holtmann.org>
In-Reply-To: <850D59CB-8032-4095-AB96-61920042DC55@holtmann.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 20.06.2014 12:50, schrieb Marcel Holtmann:

>> which is wrong and disables the ath3k driver.
>
> I reverted the broken patch in bluetooth.git now and marked it for 3.15 stable.

Must got missed, it's not in 3.15.4 nor in 3.15.5.

As my solution was a revert too, I can offer a Tested-By, if such is 
needed, at least in regard to the point that ath3k-dongles will work 
again after reverting ca58e5.

Regards,

Alexander Holler
