Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Improve data packing in SAR mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407938501-25659-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 13 Aug 2014 10:27:21 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C6D223AE-A16B-41A2-8AE2-ECC6741485AE@holtmann.org>
References: <1407938501-25659-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> There is no need to decrease pdu size with L2CAP SDU lenght in Start
> L2CAP SDU frame. Start packtet is just 2 bytes longer as specified and
> we can keep payload as long as possible.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> When testing SAR L2CAP against PTS, L2CAP channel is usually
> configured in that way, that SDU = MPS * 3. PTS expets then 3
> I-Frames from IUT: Start, Continuation and End frame.
> 
> Without this fix, we sent 4 I-Frames. We could pass a test
> by using -b option in l2test and send just two bytes less than
> SDU length but it was hakish :) With this patch no need to use -b
> option.
> 
> net/bluetooth/l2cap_core.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

