Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 2/3] Bluetooth: Use ADV_SCAN_IND for adv. instances
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427571540-29166-2-git-send-email-armansito@chromium.org>
Date: Sat, 28 Mar 2015 13:33:54 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <59C82006-EA4D-4BF3-ADB4-5A8594A70562@holtmann.org>
References: <1427571540-29166-1-git-send-email-armansito@chromium.org> <1427571540-29166-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> With this patch, ADV_SCAN_IND will be used for advertising instances
> that have non-zero scan response data while the global "connectable"
> setting is "off".
> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> net/bluetooth/mgmt.c | 21 ++++++++++++++++++++-
> 1 file changed, 20 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

