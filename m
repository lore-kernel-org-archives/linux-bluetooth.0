Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Dec 2013 13:50:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix HCI User Channel permission check in
 hci_sock_sendmsg
Message-ID: <20131217115003.GA1350@x220.p-661hnu-f1>
References: <1387279285-60237-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387279285-60237-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Dec 17, 2013, Marcel Holtmann wrote:
> The HCI User Channel is an admin operation which enforces CAP_NET_ADMIN
> when binding the socket. Problem now is that it then requires also
> CAP_NET_RAW when calling into hci_sock_sendmsg. This is not intended
> and just an oversight since general HCI sockets (which do not require
> special permission to bind) and HCI User Channel share the same code
> path here.
> 
> Remove the extra CAP_NET_RAW check for HCI User Channel write operation
> since the permission check has already been enforced when binding the
> socket. This also makes it possible to open HCI User Channel from a
> privileged process and then hand the file descriptor to an unprivilged
> process.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)

Applied to bluetooth.git. Thanks.

Johan
