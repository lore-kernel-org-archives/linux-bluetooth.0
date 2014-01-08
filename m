Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Fix outgoing authentication requirement check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389192039-29493-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 8 Jan 2014 11:00:41 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <D661A382-BBED-4DDE-B245-48F194ECB427@holtmann.org>
References: <1389192039-29493-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The check for HIGH security level dates back to pre-mgmt times when a
> raw L2CAP socket with HIGH security level was used to trigger dedicated
> bonding. For legacy pairing checking for the security level was the only
> way to catch the need to authenticate in all scenarios. With mgmt
> however, the pair_device command does not use HIGH security but MEDIUM
> security. Therefore, the existing code would never trigger
> authentication for a non-SSP connection without an MITM requirement
> (e.g. if user space provided a NoInputNoOutput IO capability). In such a
> scenario the mgmt_pair_device command would return success without
> actually triggering any kind of pairing.
> 
> This patch updates the authentication requirement check to also consider
> MEDIUM security level, and thereby ensures that mgmt_pair_device will
> always trigger authentication.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> This one should probably get a Cc: stable flag. It's also a
> pre-requisite for the first mgmt-tester pairing test case that was
> recently added to user space git.
> 
> net/bluetooth/hci_event.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

I want to give this some time to get tested via bluetooth-next before we mark this as to be backported to stable.

Regards

Marcel

