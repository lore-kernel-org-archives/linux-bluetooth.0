Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jun 2014 15:33:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Don't use non-resolvable private address for
 passive scanning
Message-ID: <20140629123351.GB7248@t440s.P-661HNU-F1>
References: <1404037215-42235-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404037215-42235-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 29, 2014, Marcel Holtmann wrote:
> The usage of non-resovlable private addresses for passive scanning is
> a bad idea. Passive scanning will not send any SCAN_REQ and thus using
> your identity address for passive scanning is not a privacy issue.
> 
> It is important to use the identity address during passive scanning
> since that is the only way devices using direct advertising will be
> reported correctly by the controller. This is overlooked detail in
> the Bluetooth specification that current controllers are not able
> to report direct advertising events for other than their current
> address.
> 
> When remote peers are using direct advertising and scanning is done
> with non-resolvable private address these devices will not be found.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
