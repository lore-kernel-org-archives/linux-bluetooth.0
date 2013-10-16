Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 19:53:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Socket address parameter for CID is in little
 endian
Message-ID: <20131016165313.GA30104@x220.p-661hnu-f1>
References: <1381941077-6941-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381941077-6941-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 16, 2013, Marcel Holtmann wrote:
> The L2CAP socket parameter for CID are actually provided in little
> endian. So convert our constants into little endian before comparing
> them.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_sock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
