Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v12 1/2] Bluetooth: Add le_scan_restart work for LE scan restarting
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422860875-3966-1-git-send-email-jpawlowski@google.com>
Date: Sun, 1 Feb 2015 23:56:58 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <094ABCA5-3CD3-482F-9E76-8AD461959746@holtmann.org>
References: <1422860875-3966-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Currently there is no way to restart le scan, and it's needed in
> service scan method. The way it work: it disable, and then enable le
> scan on controller.
> 
> During the restart, we must remember when the scan was started, and
> it's duration, to later re-schedule the le_scan_disable work, that was
> stopped during the stop scan phase.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci_core.h |  5 +++
> net/bluetooth/hci_core.c         | 74 ++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/mgmt.c             | 18 +++++++++-
> 3 files changed, 96 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

However I did a few spelling fixes in the comments and enforced the line breaks a bit harder to make it more readable.

Regards

Marcel

