Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 May 2011 14:08:19 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 07/11] Bluetooth: Add 'dst_type' field to struct
 hci_conn
Message-ID: <20110524110819.GF2480@null>
References: <1305936645-15007-1-git-send-email-andre.guedes@openbossa.org>
 <1305936645-15007-7-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305936645-15007-7-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, May 20, 2011 at 09:10:41PM -0300, ext Andre Guedes wrote:
> This patch adds a new field (dst_type) to the struct hci_conn which
> holds the type of the destination address (bdaddr_t dst).
> 
> This approach is needed in order to use the struct hci_conn as an
> abstraction of LE connections in HCI Layer.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index af4b0ed..539eb85 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -224,6 +224,7 @@ struct hci_conn {
>  	spinlock_t	lock;
>  
>  	bdaddr_t	dst;
> +	__u8            dst_type;

Again add this only when you are using it. IOW include it into your next patch.

-- 
Ville
