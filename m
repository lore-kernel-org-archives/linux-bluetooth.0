Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128173191A7
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412581; cv=pass; b=q9i9FY4Ed28dtZxektyp024DxzXwEJyAaKeavC/m+i+xHY5nIdbe89EW2Sn7uUiwAPI6BAaqhIJLp7xismq8A5O2GwIX08mHlW2zigqxaWnj01z9J5xxrnMTUYJV3/DX/YSZ6KhTdTQywXk74gPY1ApaoZq9joKB2UDUchE5rGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412581; c=relaxed/simple;
	bh=Sw7/W4mRlcO1AhotMP22gehYKrxKx8XGo3ayri0irh0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pVJHn/VGb+sO8qe39FFQncZomvhMseOlMbCxB35jagQyS/8t5+LympANy0ucsPql+Vm1sVYgHH+PqKp6uSqT0EiuAL1pTLqlgo0wJg9mt3GDFBGhjw83W58JgQuLJXBdoa19pau04KemBvfvVBgS5RNZZPYYRcP9GzgIrC9LYKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=SWDUr97C; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="SWDUr97C"
Received: from ehlo.thunderbird.net (unknown [193.138.7.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d9Kc84B23zyQR;
	Mon, 17 Nov 2025 22:49:28 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763412569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9bvhxLtsWTCoE1rns0LVHik5fZivNfp7HujCPaa4v4=;
	b=SWDUr97CmLdbcm6J2NNGyrDaMsShH7K0an/Lp3pi3vTzJnKQ90N3/B12vYGC3V37Bty2/z
	wjKshLNv784lURS96NknNEwizq05s1ezzYD+KGf0wAyiH/xUX5T2fMHw3VQSwrZp7NSxuG
	ML6bizpIXrpCa7ibKadnhxwLR9SXQ6g=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763412569;
	b=Lj/W5qB4VEsr46qcyWlaVVP99UtPO/2L6ru4yRJXUc1MjfukQL7ZTIdhyvXoP/ZIj+Ukvb
	leJgpLOlvRsbvszoq7d2tyXYupXbGShvz/mFY1x8g2FP6uhFdaRDtpaFc+4fOmDJ2hXPjl
	IQaqiH9J3UikfIc41NT9HgIqX7NHxM0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763412569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9bvhxLtsWTCoE1rns0LVHik5fZivNfp7HujCPaa4v4=;
	b=ul2+fzF6DtpRa2znvPpEJBCN5NBbOGCOWySbZ7CGfVGq1oAMAcqPuVBz0E+NpR/T6B4pv6
	PRiHVVP3njlfD8ose0bEkg08UKMO5dA8SG/sMh1zIJhjfM/X9G1ps9Bq4BFlHNhZAdpgfV
	BPcfYVAeTmNvL5yfBddQFq87fwM9AAE=
Date: Mon, 17 Nov 2025 20:49:27 +0000
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 syzbot+25e9c406cbd26c66c417@syzkaller.appspotmail.com
CC: linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1=5D_fixup!_Bluetooth=3A_hci=5Fcore?=
 =?US-ASCII?Q?=3A_Fix_triggering_cmd=5Ftimer_for_HCI=5FOP=5FNOP?=
In-Reply-To: <20251117201255.3969812-1-luiz.dentz@gmail.com>
References: <20251117201255.3969812-1-luiz.dentz@gmail.com>
Message-ID: <1A6F9809-8B5B-4703-92A2-4DB1007143A6@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

17=2E marraskuuta 2025 20=2E12=2E55 UTC Luiz Augusto von Dentz <luiz=2Eden=
tz@gmail=2Ecom> kirjoitti:
>From: Luiz Augusto von Dentz <luiz=2Evon=2Edentz@intel=2Ecom>
>
>Fixes: 486a25d25a4b3 ("Bluetooth: hci_core: Fix triggering cmd_timer for =
HCI_OP_NOP")
>Reported-by: syzbot+25e9c406cbd26c66c417@syzkaller=2Eappspotmail=2Ecom
>Closes: https://syzkaller=2Eappspot=2Ecom/bug?extid=3D25e9c406cbd26c66c41=
7
>Signed-off-by: Pauli Virtanen <pav@iki=2Efi>
>Signed-off-by: Luiz Augusto von Dentz <luiz=2Evon=2Edentz@intel=2Ecom>
>---
> net/bluetooth/hci_core=2Ec | 19 ++++++++++---------
> 1 file changed, 10 insertions(+), 9 deletions(-)
>
>diff --git a/net/bluetooth/hci_core=2Ec b/net/bluetooth/hci_core=2Ec
>index 9f686e5903a1=2E=2Edc318aa79c59 100644
>--- a/net/bluetooth/hci_core=2Ec
>+++ b/net/bluetooth/hci_core=2Ec
>@@ -4121,7 +4121,7 @@ static void hci_rx_work(struct work_struct *work)
> 	}
> }
>=20
>-static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
>+static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
> {
> 	int err;
>=20
>@@ -4133,16 +4133,18 @@ static void hci_send_cmd_sync(struct hci_dev *hde=
v, struct sk_buff *skb)
> 	if (!hdev->sent_cmd) {
> 		skb_queue_head(&hdev->cmd_q, skb);
> 		queue_work(hdev->workqueue, &hdev->cmd_work);
>-		return;
>+		return -EINVAL;
> 	}
>=20
> 	if (hci_skb_opcode(skb) !=3D HCI_OP_NOP) {
> 		err =3D hci_send_frame(hdev, skb);
> 		if (err < 0) {
> 			hci_cmd_sync_cancel_sync(hdev, -err);
>-			return;
>+			return err;
> 		}
> 		atomic_dec(&hdev->cmd_cnt);
>+	} else {
>+		err =3D -ENODATA;

Change itself is probably OK, but I don't understand based on a quick look=
 what consumes the skb on error / nop (also in the previous code)

> 	}
>=20
> 	if (hdev->req_status =3D=3D HCI_REQ_PEND &&
>@@ -4150,12 +4152,15 @@ static void hci_send_cmd_sync(struct hci_dev *hde=
v, struct sk_buff *skb)
> 		kfree_skb(hdev->req_skb);
> 		hdev->req_skb =3D skb_clone(hdev->sent_cmd, GFP_KERNEL);
> 	}
>+
>+	return err;
> }
>=20
> static void hci_cmd_work(struct work_struct *work)
> {
> 	struct hci_dev *hdev =3D container_of(work, struct hci_dev, cmd_work);
> 	struct sk_buff *skb;
>+	int err;
>=20
> 	BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
> 	       atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
>@@ -4166,12 +4171,8 @@ static void hci_cmd_work(struct work_struct *work)
> 		if (!skb)
> 			return;
>=20
>-		hci_send_cmd_sync(hdev, skb);
>-
>-		/* Don't trigger cmd_timer in case of HCI_OP_NOP since there is
>-		 * no command pending=2E
>-		 */
>-		if (hci_skb_opcode(skb) =3D=3D HCI_OP_NOP)
>+		err =3D hci_send_cmd_sync(hdev, skb);
>+		if (err)
> 			return;
>=20
> 		rcu_read_lock();
