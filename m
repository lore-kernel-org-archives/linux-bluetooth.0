Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 21:34:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for entering limited discoverable
 mode
Message-ID: <20131015183417.GA31747@x220.p-661hnu-f1>
References: <1381853619-42234-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381853619-42234-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 15, 2013, Marcel Holtmann wrote:
> The limited discoverable mode should be used when a device is only
> discoverable for a certain amount of time and after that it returns
> back into being non-discoverable.
> 
> This adds another option to the set discoverable management command
> to clearly distinguish limited discoverable from general discoverable
> mode.
> 
> While the general discoverable mode can be set with a specific
> timeout or as permanent setting, the limited discoverable mode
> requires a timeout. The timeout is flexible and the kernel will
> not enforce any specific limitations. That GAP part of this is
> required by userspace to enforce according to the Bluetooth core
> specification.
> 
> Devices in limited discoverable mode can still be found by the
> general discovery procedure. It is mandatory that a device sets
> both GIAC and LIAC when entering limited discoverable mode.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c |  8 ++++++
>  net/bluetooth/mgmt.c     | 67 ++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 65 insertions(+), 10 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
