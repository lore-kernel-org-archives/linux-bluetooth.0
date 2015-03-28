Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 3/3] Bluetooth: Update adv. parameters when conn. setting changes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427571540-29166-3-git-send-email-armansito@chromium.org>
Date: Sat, 28 Mar 2015 13:33:51 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <056CBB5D-6626-4BCD-960A-762754FAF1FD@holtmann.org>
References: <1427571540-29166-1-git-send-email-armansito@chromium.org> <1427571540-29166-3-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch fixes a bug where the advertising parameters weren't updated
> after a call to "Set Connectable" if the HCI_ADVERTISING_INSTANCE
> setting was set.
> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> net/bluetooth/mgmt.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

