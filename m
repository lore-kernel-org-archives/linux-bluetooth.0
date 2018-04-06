Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: btqcomsmd: Fix rx/tx stats
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1523006625-17257-1-git-send-email-loic.poulain@linaro.org>
Date: Fri, 6 Apr 2018 11:39:26 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        bjorn.andersson@linaro.org
Message-Id: <6EB5487A-A076-451F-89B6-9421DD008AA0@holtmann.org>
References: <1523006625-17257-1-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> HCI RX/TX byte counters were only incremented when sending ACL packets.
> To reflect the real HCI traffic, we need to increment these counters on
> HCI events and HCI commands as well.
> 
> Increment error counter on rpmsg errors.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> drivers/bluetooth/btqcomsmd.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

