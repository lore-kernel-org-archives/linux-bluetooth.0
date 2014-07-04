Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2014 18:10:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Add quirk for invalid controller address
 setting
Message-ID: <20140704151040.GA13657@t440s.P-661HNU-F1>
References: <1404485680-1682-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404485680-1682-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 04, 2014, Marcel Holtmann wrote:
> When a Bluetooth controller does not have a valid public Bluetooth
> address, then allow the driver to indicate this. If the quirk is
> set, the Bluetooth core will switch to unconfigured state first
> and will allow userspace to configure the address before starting
> the full initialization of the controller.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 10 ++++++++++
>  net/bluetooth/hci_core.c    |  6 +++++-
>  net/bluetooth/mgmt.c        | 21 +++++++++++++++++----
>  3 files changed, 32 insertions(+), 5 deletions(-)

All four patches have been applied to bluetooth-next. Thanks.

Johan
