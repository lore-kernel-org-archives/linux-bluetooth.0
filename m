Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jun 2014 12:20:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Provide L2CAP ops callback for
 memcpy_fromiovec
Message-ID: <20140617092046.GB30044@t440s.lan>
References: <1402937148-11662-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402937148-11662-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 16, 2014, Marcel Holtmann wrote:
> The highly optimized TX path for L2CAP channels and its fragmentation
> within the HCI ACL packets requires to copy data from user provided
> IO vectors and also kernel provided memory buffers.
> 
> This patch allows channel clients to provide a memcpy_fromiovec callback
> to keep this optimized behavior, but adapt it to kernel vs user memory
> for the TX path. For all kernel internal L2CAP channels, a default
> implementation is provided that can be referenced.
> 
> In case of A2MP, this fixes a long-standing issue with wrongly accessing
> kernel memory as user memory.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Tested-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
>  include/net/bluetooth/l2cap.h | 22 ++++++++++++++++++++++
>  net/bluetooth/a2mp.c          |  1 +
>  net/bluetooth/l2cap_core.c    |  6 ++++--
>  net/bluetooth/l2cap_sock.c    | 34 +++++++++++++++++++++-------------
>  4 files changed, 48 insertions(+), 15 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
