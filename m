Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Use shorter "rand" name for "randomizer"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416250340-23675-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 18 Nov 2014 10:12:36 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <291F117F-95B8-4E66-949C-DA48F15FA5FA@holtmann.org>
References: <1416250340-23675-1-git-send-email-johan.hedberg@gmail.com> <1416250340-23675-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The common short form of "randomizer" is "rand" in many places
> (including the Bluetooth specification). The shorter version also makes
> for easier to read code with less forced line breaks. This patch renames
> all occurences of "randomizer" to "rand" in the Bluetooth subsystem
> code.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h      | 12 ++++++------
> include/net/bluetooth/hci_core.h | 14 +++++++-------
> include/net/bluetooth/mgmt.h     | 12 ++++++------
> net/bluetooth/hci_core.c         | 14 +++++++-------
> net/bluetooth/hci_event.c        | 17 +++++++----------
> net/bluetooth/mgmt.c             | 23 +++++++++--------------
> 6 files changed, 42 insertions(+), 50 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

