Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 14:51:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add management command for setting static
 address
Message-ID: <20131002115145.GA10291@x220.p-661hnu-f1>
References: <1380714090-11609-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380714090-11609-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 02, 2013, Marcel Holtmann wrote:
> On dual-mode BR/EDR/LE and LE only controllers it is possible
> to configure a random address. There are two types or random
> addresses, one is static and the other private. Since the
> random private addresses require special privacy feature to
> be supported, the configuration of these two are kept separate.
> 
> This command allows for setting the static random address. It is
> only supported on controllers with LE support. The static random
> address is suppose to be valid for the lifetime of the controller
> or at least until the next power cycle. To ensure such behavior,
> setting of the address is limited to when the controller is
> powered off.
> 
> The special BDADDR_ANY address (00:00:00:00:00:00) can be used to
> disable the static address. This is also the default value.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |  2 ++
>  include/net/bluetooth/hci_core.h |  1 +
>  include/net/bluetooth/mgmt.h     |  6 +++++
>  net/bluetooth/mgmt.c             | 49 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
