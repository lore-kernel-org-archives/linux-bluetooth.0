Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jun 2014 14:59:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Bluetooth: Provide defaults for LE connection
 latency and timeout
Message-ID: <20140630115910.GA13557@t440s.lan>
References: <1404124480-60343-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404124480-60343-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 30, 2014, Marcel Holtmann wrote:
> Store the connection latency and supervision timeout default values
> with all the other controller defaults. And when needed use them
> for new connections.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 2 ++
>  net/bluetooth/hci_conn.c         | 4 ++--
>  net/bluetooth/hci_core.c         | 6 ++++--
>  3 files changed, 8 insertions(+), 4 deletions(-)

All five patches have been applied to bluetooth-next. Thanks.

Johan
