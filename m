Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE9F221FBD
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763225049; cv=none; b=JItSvobDogNILF75XOdWcb5/u/JucjbCkPz0mV1yL8C/O50e++X03kvF3rl+wxQ45sliN1Dgr0zmZjxjrujf2a3zi6ZhyBb/rLU6b/DYlw6fpBiIfMH/CBdVXPByd+gE68G3RDM3UMJWiDGlW47EpiGU2+zkwSK+15y2mhScI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763225049; c=relaxed/simple;
	bh=CEV794vB3LZp8FhSf3hHJEO6v1xSz0ODdvW9SJ8MoZU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=k/ujVRrM1I1/bBPbP4ItjF2gefT9MvKKEOD5+dgLmHMajmskFBo6yPejJi6XesPbrTlSMAS9kd8cRvxr3seuBQMsqCAk9pLCNIXVQ/onQCDkcRvuwiVo6PyckZuw5ZXPiNAN6TmPV0OdZ534g3K21M8fH/pMMFzuCQQdwMV550g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433770ba913so33577845ab.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 08:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763225047; x=1763829847;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kpKf66g34n1+B9LRtH6CQoInuXcuB1fxKwdfqVFp4w=;
        b=sTt2l2kLgsfkRWbvOR5SIU+qARAuqFz6bkVVVIYkW1znNpwjivqIFrvUiSmkH2zacT
         MR0txv7974l4hQxcCE0kqquny7vnAMV0cEaxI53vPn7AFuq1EWGbjauy1aQJLUHZlDVk
         WHnYvT+wYsLayEAPqTMHzRLcYway4vv2phCf+XnjfNDjbxmTdecnIVRC7WLJZ9TUQavY
         S6yNecCjALC1ntxlzbU7wqQloyZkr+Exlw7kpFeOhQBM5SQlMJteV+/2ErSmHYT5lAL+
         sD0JmxKN+2YoWQP2gFPJQbMe0ShMs+z8xX6kncMyxNqBVJ2/d/qTtsEnzExTgAP4UAX0
         AKsg==
X-Gm-Message-State: AOJu0YxPT2FEt9M/kcas63MopyY2MrHL555Jlgm6ziBllusQ+rp+vY8p
	N+2e9X1r1W9/k/hY/yYynZInyRiYkg4umZb3ls4ec+R+PDzRNZK6u8kTQ+wPKHuxLCQVlV2L33X
	J+taVCxwNAzLGeHeaaTkli5LPECv0uolSgs2ugH9jBoGv4PIx7eHmHBKFCs8=
X-Google-Smtp-Source: AGHT+IENxnlbi0pUnraGHuxtWxCsRGYy5xck4C6gydzdCoLlbZZkyjFRivmZ7o7idtyhacytNyVRzdLCmyF2Gq211H2foWylvloq
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214e:b0:434:767d:8a41 with SMTP id
 e9e14a558f8ab-4348c942b73mr103742255ab.17.1763225047004; Sat, 15 Nov 2025
 08:44:07 -0800 (PST)
Date: Sat, 15 Nov 2025 08:44:06 -0800
In-Reply-To: <183db933c90086f465918ac41188d730ac2bab4f.1763224083.git.pav@iki.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6918add6.050a0220.1c914e.0043.GAE@google.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core: lookup hci_conn on RX path on
 protocol side
From: syzbot <syzbot+d32d77220b92eddd89ad@syzkaller.appspotmail.com>
To: pav@iki.fi
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi, 
	syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> The hdev lock/lookup/unlock/use pattern in the packet RX path doesn't
> ensure hci_conn* is not concurrently modified/deleted. This locking
> appears to be leftover from before conn_hash started using RCU
> commit bf4c63252490b ("Bluetooth: convert conn hash to RCU")
> and not clear if it had purpose since then.
>
> Currently, there are code paths that delete hci_conn* from elsewhere
> than the ordered hdev->workqueue where the RX work runs in. E.g.
> commit 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
> introduced some of these, and there probably were a few others before
> it.  It's better to do the locking so that even if these run
> concurrently no UAF is possible.
>
> Move the lookup of hci_conn and associated socket-specific conn to
> protocol recv handlers, and do them within a single critical section
> to cover hci_conn* usage and lookup.
>
> syzkaller has reported a crash that appears to be this issue:
>
>     [Task hdev->workqueue]          [Task 2]
>                                     hci_disconnect_all_sync
>     l2cap_recv_acldata(hcon)
>                                       hci_conn_get(hcon)
>                                       hci_abort_conn_sync(hcon)
>                                         hci_dev_lock
>       hci_dev_lock
>                                         hci_conn_del(hcon)
>       v-------------------------------- hci_dev_unlock
>                                       hci_conn_put(hcon)
>       conn = hcon->l2cap_data (UAF)
>
> Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
> Reported-by: syzbot+d32d77220b92eddd89ad@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d32d77220b92eddd89ad
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     v2:
>     - uint16_t -> u16 in one case
>     - no other changes, resend
>     - add syzkaller issue to commit message
>     
> #syz test

This crash does not have a reproducer. I cannot test it.

>
>  include/net/bluetooth/hci_core.h | 20 ++++++---
>  net/bluetooth/hci_core.c         | 73 +++++++++++---------------------
>  net/bluetooth/iso.c              | 30 ++++++++++---
>  net/bluetooth/l2cap_core.c       | 23 +++++++---
>  net/bluetooth/sco.c              | 35 +++++++++++----
>  5 files changed, 108 insertions(+), 73 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 9efdefed33c0..858b58206e80 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -857,11 +857,12 @@ extern struct mutex hci_cb_list_lock;
>  /* ----- HCI interface to upper protocols ----- */
>  int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  int l2cap_disconn_ind(struct hci_conn *hcon);
> -void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
> +int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
> +		       u16 flags);
>  
>  #if IS_ENABLED(CONFIG_BT_BREDR)
>  int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
> -void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
> +int sco_recv_scodata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb);
>  #else
>  static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  				  __u8 *flags)
> @@ -869,23 +870,30 @@ static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  	return 0;
>  }
>  
> -static inline void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
> +static inline int sco_recv_scodata(struct hci_dev *hdev, u16 handle,
> +				   struct sk_buff *skb)
>  {
> +	kfree_skb(skb);
> +	return -ENOENT;
>  }
>  #endif
>  
>  #if IS_ENABLED(CONFIG_BT_LE)
>  int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
> -void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
> +int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
> +	     u16 flags);
>  #else
>  static inline int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  				  __u8 *flags)
>  {
>  	return 0;
>  }
> -static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
> -			    u16 flags)
> +
> +static inline int iso_recv(struct hci_dev *hdev, u16 handle,
> +			   struct sk_buff *skb, u16 flags)
>  {
> +	kfree_skb(skb);
> +	return -ENOENT;
>  }
>  #endif
>  
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9f686e5903a1..8c9bd20e0aa7 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3832,13 +3832,14 @@ static void hci_tx_work(struct work_struct *work)
>  static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	struct hci_acl_hdr *hdr;
> -	struct hci_conn *conn;
>  	__u16 handle, flags;
> +	int err;
>  
>  	hdr = skb_pull_data(skb, sizeof(*hdr));
>  	if (!hdr) {
>  		bt_dev_err(hdev, "ACL packet too small");
> -		goto drop;
> +		kfree_skb(skb);
> +		return;
>  	}
>  
>  	handle = __le16_to_cpu(hdr->handle);
> @@ -3850,36 +3851,27 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  	hdev->stat.acl_rx++;
>  
> -	hci_dev_lock(hdev);
> -	conn = hci_conn_hash_lookup_handle(hdev, handle);
> -	hci_dev_unlock(hdev);
> -
> -	if (conn) {
> -		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
> -
> -		/* Send to upper protocol */
> -		l2cap_recv_acldata(conn, skb, flags);
> -		return;
> -	} else {
> +	err = l2cap_recv_acldata(hdev, handle, skb, flags);
> +	if (err == -ENOENT)
>  		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
>  			   handle);
> -	}
> -
> -drop:
> -	kfree_skb(skb);
> +	else if (err)
> +		bt_dev_dbg(hdev, "ACL packet recv for handle %d failed: %d",
> +			   handle, err);
>  }
>  
>  /* SCO data packet */
>  static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	struct hci_sco_hdr *hdr;
> -	struct hci_conn *conn;
>  	__u16 handle, flags;
> +	int err;
>  
>  	hdr = skb_pull_data(skb, sizeof(*hdr));
>  	if (!hdr) {
>  		bt_dev_err(hdev, "SCO packet too small");
> -		goto drop;
> +		kfree_skb(skb);
> +		return;
>  	}
>  
>  	handle = __le16_to_cpu(hdr->handle);
> @@ -3891,34 +3883,28 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  	hdev->stat.sco_rx++;
>  
> -	hci_dev_lock(hdev);
> -	conn = hci_conn_hash_lookup_handle(hdev, handle);
> -	hci_dev_unlock(hdev);
> +	hci_skb_pkt_status(skb) = flags & 0x03;
>  
> -	if (conn) {
> -		/* Send to upper protocol */
> -		hci_skb_pkt_status(skb) = flags & 0x03;
> -		sco_recv_scodata(conn, skb);
> -		return;
> -	} else {
> +	err = sco_recv_scodata(hdev, handle, skb);
> +	if (err == -ENOENT)
>  		bt_dev_err_ratelimited(hdev, "SCO packet for unknown connection handle %d",
>  				       handle);
> -	}
> -
> -drop:
> -	kfree_skb(skb);
> +	else if (err)
> +		bt_dev_dbg(hdev, "SCO packet recv for handle %d failed: %d",
> +			   handle, err);
>  }
>  
>  static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	struct hci_iso_hdr *hdr;
> -	struct hci_conn *conn;
>  	__u16 handle, flags;
> +	int err;
>  
>  	hdr = skb_pull_data(skb, sizeof(*hdr));
>  	if (!hdr) {
>  		bt_dev_err(hdev, "ISO packet too small");
> -		goto drop;
> +		kfree_skb(skb);
> +		return;
>  	}
>  
>  	handle = __le16_to_cpu(hdr->handle);
> @@ -3928,22 +3914,13 @@ static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
>  		   handle, flags);
>  
> -	hci_dev_lock(hdev);
> -	conn = hci_conn_hash_lookup_handle(hdev, handle);
> -	hci_dev_unlock(hdev);
> -
> -	if (!conn) {
> +	err = iso_recv(hdev, handle, skb, flags);
> +	if (err == -ENOENT)
>  		bt_dev_err(hdev, "ISO packet for unknown connection handle %d",
>  			   handle);
> -		goto drop;
> -	}
> -
> -	/* Send to upper protocol */
> -	iso_recv(conn, skb, flags);
> -	return;
> -
> -drop:
> -	kfree_skb(skb);
> +	else if (err)
> +		bt_dev_dbg(hdev, "ISO packet recv for handle %d failed: %d",
> +			   handle, err);
>  }
>  
>  static bool hci_req_is_complete(struct hci_dev *hdev)
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 14022e4937c2..c538e2ac48fc 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2452,14 +2452,31 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
>  	iso_conn_del(hcon, bt_to_errno(reason));
>  }
>  
> -void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> +int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
>  {
> -	struct iso_conn *conn = hcon->iso_data;
> +	struct hci_conn *hcon;
> +	struct iso_conn *conn;
>  	struct skb_shared_hwtstamps *hwts;
>  	__u16 pb, ts, len, sn;
>  
> -	if (!conn)
> -		goto drop;
> +	hci_dev_lock(hdev);
> +
> +	hcon = hci_conn_hash_lookup_handle(hdev, handle);
> +	if (!hcon) {
> +		hci_dev_unlock(hdev);
> +		kfree_skb(skb);
> +		return -ENOENT;
> +	}
> +
> +	conn = iso_conn_hold_unless_zero(hcon->iso_data);
> +	hcon = NULL;
> +
> +	hci_dev_unlock(hdev);
> +
> +	if (!conn) {
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
>  
>  	pb     = hci_iso_flags_pb(flags);
>  	ts     = hci_iso_flags_ts(flags);
> @@ -2515,7 +2532,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>  			hci_skb_pkt_status(skb) = flags & 0x03;
>  			hci_skb_pkt_seqnum(skb) = sn;
>  			iso_recv_frame(conn, skb);
> -			return;
> +			goto done;
>  		}
>  
>  		if (pb == ISO_SINGLE) {
> @@ -2593,6 +2610,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>  
>  drop:
>  	kfree_skb(skb);
> +done:
> +	iso_conn_put(conn);
> +	return 0;
>  }
>  
>  static struct hci_cb iso_cb = {
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 35c57657bcf4..07b493331fd7 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7510,13 +7510,24 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
>  	return c;
>  }
>  
> -void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> +int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
> +		       struct sk_buff *skb, u16 flags)
>  {
> +	struct hci_conn *hcon;
>  	struct l2cap_conn *conn;
>  	int len;
>  
> -	/* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del */
> -	hci_dev_lock(hcon->hdev);
> +	/* Lock hdev for hci_conn, and race on l2cap_data vs. l2cap_conn_del */
> +	hci_dev_lock(hdev);
> +
> +	hcon = hci_conn_hash_lookup_handle(hdev, handle);
> +	if (!hcon) {
> +		hci_dev_unlock(hdev);
> +		kfree_skb(skb);
> +		return -ENOENT;
> +	}
> +
> +	hci_conn_enter_active_mode(hcon, BT_POWER_FORCE_ACTIVE_OFF);
>  
>  	conn = hcon->l2cap_data;
>  
> @@ -7524,12 +7535,13 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>  		conn = l2cap_conn_add(hcon);
>  
>  	conn = l2cap_conn_hold_unless_zero(conn);
> +	hcon = NULL;
>  
> -	hci_dev_unlock(hcon->hdev);
> +	hci_dev_unlock(hdev);
>  
>  	if (!conn) {
>  		kfree_skb(skb);
> -		return;
> +		return -EINVAL;
>  	}
>  
>  	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
> @@ -7643,6 +7655,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>  unlock:
>  	mutex_unlock(&conn->lock);
>  	l2cap_conn_put(conn);
> +	return 0;
>  }
>  
>  static struct hci_cb l2cap_cb = {
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index e7273dc8a073..828ed56b9de7 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -1463,22 +1463,39 @@ static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
>  	sco_conn_del(hcon, bt_to_errno(reason));
>  }
>  
> -void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
> +int sco_recv_scodata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb)
>  {
> -	struct sco_conn *conn = hcon->sco_data;
> +	struct hci_conn *hcon;
> +	struct sco_conn *conn;
>  
> -	if (!conn)
> -		goto drop;
> +	hci_dev_lock(hdev);
> +
> +	hcon = hci_conn_hash_lookup_handle(hdev, handle);
> +	if (!hcon) {
> +		hci_dev_unlock(hdev);
> +		kfree_skb(skb);
> +		return -ENOENT;
> +	}
> +
> +	conn = sco_conn_hold_unless_zero(hcon->sco_data);
> +	hcon = NULL;
> +
> +	hci_dev_unlock(hdev);
> +
> +	if (!conn) {
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
>  
>  	BT_DBG("conn %p len %u", conn, skb->len);
>  
> -	if (skb->len) {
> +	if (skb->len)
>  		sco_recv_frame(conn, skb);
> -		return;
> -	}
> +	else
> +		kfree_skb(skb);
>  
> -drop:
> -	kfree_skb(skb);
> +	sco_conn_put(conn);
> +	return 0;
>  }
>  
>  static struct hci_cb sco_cb = {
> -- 
> 2.51.1
>
