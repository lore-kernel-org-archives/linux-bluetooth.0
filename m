Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 09:40:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Require CAP_NET_ADMIN for HCI User Channel
 operation
Message-ID: <20131002064052.GC28911@x220.p-661hnu-f1>
References: <1380638401-39890-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380638401-39890-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 01, 2013, Marcel Holtmann wrote:
> The HCI User Channel operation is an admin operation that puts the
> device into promiscuous mode for single use. It is more suitable
> to require CAP_NET_ADMIN than CAP_NET_RAW.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
