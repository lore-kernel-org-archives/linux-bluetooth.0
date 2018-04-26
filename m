Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v3 1/2] Bluetooth: Add __hci_cmd_send function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1524741207-19753-1-git-send-email-loic.poulain@linaro.org>
Date: Thu, 26 Apr 2018 14:22:29 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, bgodavar@codeaurora.org
Message-Id: <B5F4518D-AA16-486F-BDAD-35C9394D2A89@holtmann.org>
References: <1524741207-19753-1-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> This function allows to send a HCI command without expecting any
> controller event/response in return. This is allowed for vendor-
> specific commands only.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> v2: Only allow vendor-specific command to be unresponded
>     Rename function to __hci_cmd_send
> v3: no change
> 
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
> 2 files changed, 33 insertions(+)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

