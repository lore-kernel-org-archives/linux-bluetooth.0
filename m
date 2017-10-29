Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH] bluetooth: increase timeout for le auto connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1508248429-19415-1-git-send-email-konrad.zapalowicz@canonical.com>
Date: Sun, 29 Oct 2017 14:11:06 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Message-Id: <6C8F5FB6-C23C-42BB-A64F-097384BDE8C0@holtmann.org>
References: <1508248429-19415-1-git-send-email-konrad.zapalowicz@canonical.com>
To: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Konrad,

> This patch increases the connection timeout for LE connections that are
> triggered by the advertising report to 4 seconds.
> 
> It has been observed that devices equipped with wifi+bt combo SoC fail
> to create a connection with BLE devices due to their coexistence issues.
> Increasing this timeout gives them enough time to complete the
> connection with success.
> 
> Signed-off-by: Konrad Zapałowicz <konrad.zapalowicz@canonical.com>
> ---
> include/net/bluetooth/hci.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

