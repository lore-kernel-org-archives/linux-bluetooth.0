Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: pull request: bluetooth 2018-03-16
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180316182319.GA4401@x1c>
Date: Tue, 20 Mar 2018 09:44:37 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
Message-Id: <2162D348-7B5F-4693-87AB-8835A1638CF3@holtmann.org>
References: <20180316182319.GA4401@x1c>
To: Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

> Here are a few more important Bluetooth driver fixes for the 4.16
> kernel.
> 
> Please let me know if there are any issues pulling. Thanks.
> 
> Johan
> 
> ---
> The following changes since commit 3d502067599f0db12e74e6646aee8728efe3e5be:
> 
>  net/smc: simplify wait when closing listen socket (2018-03-15 09:49:13 -0400)
> 
> are available in the Git repository at:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git for-upstream
> 
> for you to fetch changes up to e07c99b07ae85255d5c5bc2480fbd4c4e77f71bc:
> 
>  Bluetooth: hci_bcm: Set pulsed_host_wake flag in sleep parameters (2018-03-15 19:39:37 +0100)
> 
> ----------------------------------------------------------------
> Hans de Goede (2):
>      Revert "Bluetooth: hci_bcm: Streamline runtime PM code"
>      Bluetooth: hci_bcm: Set pulsed_host_wake flag in sleep parameters
> 
> Takashi Iwai (1):
>      Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174
> 
> drivers/bluetooth/btusb.c   |  2 +-
> drivers/bluetooth/hci_bcm.c | 13 +++++++++----
> 2 files changed, 10 insertions(+), 5 deletions(-)

any issue with this pull request? I ask since it seems to have disappeared from patchwork.

Regards

Marcel

