Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Mar 2014 22:02:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Make LTK and CSRK only persisent when
 bonding
Message-ID: <20140310200214.GA24424@localhost.P-661HNU-F1>
References: <1394433522-8561-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394433522-8561-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Mar 09, 2014, Marcel Holtmann wrote:
> In case the pairable option has been disabled, the pairing procedure
> does not create keys for bonding. This means that these generated keys
> should not be stored persistently.
> 
> For LTK and CSRK this is important to tell userspace to not store these
> new keys. They will be available for the lifetime of the device, but
> after the next power cycle they should not be used anymore.
> 
> Make sure that the SMP pairing procedures rememberes the authentication
> request information for bonding and if both sides request bonding, then
> inform userspace to actually store the keys persistently.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  5 +++--
>  net/bluetooth/mgmt.c             |  9 +++++----
>  net/bluetooth/smp.c              | 13 +++++++++----
>  net/bluetooth/smp.h              |  1 +
>  4 files changed, 18 insertions(+), 10 deletions(-)

Thanks for the patch. I've applied a slightly modified version which
relies on the existing smp->preq/prsp variables as discussed on IRC.

Johan
