Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 11:43:40 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH 07/10] Bluetooth: Fix code style issues and make
 checkpatch silent about hci_core.h
Message-ID: <20110217144340.GE10543@joana>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
 <1297948601-12723-8-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297948601-12723-8-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-02-17 14:16:38 +0100]:

> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  include/net/bluetooth/hci_core.h |   91 +++++++++++++++++++++-----------------
>  1 files changed, 51 insertions(+), 40 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e4f370f..a8a5ecb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -208,37 +208,37 @@ struct hci_dev {
>  struct hci_conn {
>  	struct list_head list;
>  
> -	atomic_t	 refcnt;
> -	spinlock_t	 lock;
> -
> -	bdaddr_t	 dst;
> -	__u16		 handle;
> -	__u16		 state;
> -	__u8             mode;
> -	__u8		 type;
> -	__u8		 out;
> -	__u8		 attempt;
> -	__u8		 dev_class[3];
> -	__u8             features[8];
> -	__u8             ssp_mode;
> -	__u16            interval;
> -	__u16            pkt_type;
> -	__u16            link_policy;
> -	__u32		 link_mode;
> -	__u8             auth_type;
> -	__u8             sec_level;
> -	__u8		 pending_sec_level;
> -	__u8		 pin_length;
> -	__u8		 io_capability;
> -	__u8             power_save;
> -	__u16            disc_timeout;
> -	unsigned long	 pend;
> +	atomic_t	refcnt;
> +	spinlock_t	lock;
> +
> +	bdaddr_t	dst;
> +	__u16		handle;
> +	__u16		state;
> +	__u8		mode;
> +	__u8		type;
> +	__u8		out;
> +	__u8		attempt;
> +	__u8		dev_class[3];
> +	__u8		features[8];
> +	__u8		ssp_mode;
> +	__u16		interval;
> +	__u16		pkt_type;
> +	__u16		link_policy;
> +	__u32		link_mode;
> +	__u8		auth_type;
> +	__u8		sec_level;
> +	__u8		pending_sec_level;
> +	__u8		pin_length;
> +	__u8		io_capability;
> +	__u8		power_save;
> +	__u16		disc_timeout;
> +	unsigned long	pend;
>  
>  	__u8		remote_cap;
>  	__u8		remote_oob;
>  	__u8		remote_auth;
>  
> -	unsigned int	 sent;
> +	unsigned int	sent;
>  
>  	struct sk_buff_head data_q;
>  
> @@ -298,7 +298,8 @@ static inline long inquiry_entry_age(struct inquiry_entry *e)
>  	return jiffies - e->timestamp;
>  }
>  
> -struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
> +struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
> +							bdaddr_t *bdaddr);

Leave the line over 80 fix out of this patches, I'm not sure if I want to fix
that now.

-- 
Gustavo F. Padovan
http://profusion.mobi
