Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v3] Bluetooth: Fix advertising address type when toggling connectable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393350991-8327-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 25 Feb 2014 10:04:37 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <4127D13C-C6F9-4631-AACE-11CF69E6ADF2@holtmann.org>
References: <1393350991-8327-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When the connectable setting is toggled using mgmt_set_connectable the
> HCI_CONNECTABLE flag will only be set once the related HCI commands
> succeed. When determining what kind of advertising to do we need to
> therefore also check whether there is a pending Set Connectable command
> in addition to the current flag value.
> 
> The enable_advertising function was already taking care of this for the
> advertising type with the help of the get_adv_type function, but was
> failing to do the same for the address type selection. This patch
> converts the get_adv_type function to be more generic in that it returns
> the expected connectable state and updates the enable_advertising
> function to use the return value both for the advertising type as well
> as the advertising address type.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 21 +++++++++++----------
> 1 file changed, 11 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

