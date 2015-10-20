Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Oct 2015 10:28:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Add support setup stage internal
 notification event
Message-ID: <20151020072858.GA11043@t440s.lan>
References: <1445301048-46533-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445301048-46533-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 20, 2015, Marcel Holtmann wrote:
> Before the vendor specific setup stage is triggered call back into the
> core to trigger an internal notification event. That event is used to
> send an index update to the monitor interface. With that specific event
> it is possible to update userspace with manufacturer information before
> any HCI command has been executed. This is useful for early stage
> debugging of vendor specific initialization sequences.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  1 +
>  net/bluetooth/hci_core.c    |  2 ++
>  net/bluetooth/hci_sock.c    | 24 ++++++++++++++++--------
>  3 files changed, 19 insertions(+), 8 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
