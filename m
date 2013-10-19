Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 16:30:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Select the own address type during
 initial setup phase
Message-ID: <20131019133035.GE11607@x220.p-661hnu-f1>
References: <1382139490-306-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382139490-306-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 18, 2013, Marcel Holtmann wrote:
> The own address type is based on the fact if the controller has
> a public address or not. This means that this detail can be just
> configured once during setup phase.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_conn.c         |  7 +------
>  net/bluetooth/hci_core.c         | 13 ++++++++++++-
>  net/bluetooth/mgmt.c             | 10 ++--------
>  4 files changed, 16 insertions(+), 15 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
