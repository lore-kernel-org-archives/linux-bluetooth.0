Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] Bluetooth: Add ACL MTU, available buffers and total buffers to hci_conn_info.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402049880-7686-1-git-send-email-kiran.kumar@linaro.org>
Date: Fri, 6 Jun 2014 12:44:55 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
	Nick Pelly <npelly@google.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	netdev@vger.kernel.org,
	Android Kernel Team <kernel-team@android.com>,
	John Stultz <john.stultz@linaro.org>
Message-Id: <39777AAC-6DB7-444D-9137-BCDDE99DA781@holtmann.org>
References: <1402049880-7686-1-git-send-email-kiran.kumar@linaro.org>
To: Kiran Kumar Raparthy <kiran.kumar@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kiran,

> Add ACL MTU, available buffers and total buffers to hci_conn_info.
> 
> This provides userspace debugging tools access to ACL flow control state.
> 
> This is one of the number of patches from the Android AOSP common.git tree,
> which is used on almost all Android devices.  so I wanted to submit it for
> review to see if it should go upstream.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Android Kernel Team <kernel-team@android.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Nick Pelly <npelly@google.com>
> [kiran: Added context to commit message]
> Signed-off-by: Kiran Raparthy <kiran.kumar@linaro.org>
> ---
> include/net/bluetooth/hci.h |  3 +++
> net/bluetooth/hci_conn.c    | 18 ++++++++++++++++++
> 2 files changed, 21 insertions(+)

this would break existing API and can not be accepted. NAK.

Regards

Marcel

