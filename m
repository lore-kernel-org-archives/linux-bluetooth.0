Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620730;
	b=oqwzYsHLFf3zZeLmmY/aLlKa2CyBc32Sax9jik/XbJUfZLYtDk9KHBE8HVpilBVhmYYJ
	 zdfqrUBRMsOliC0uj+sLlgoZmVSm7KwcZcOWBu+HUZPdO6ohUvXK1uvLpPpgvxYoFejAA
	 p+3Q7XBT82SYAG2eTAYs2cBzXQ41eh8Oq0VpYUArIAJrSB7mUf6l8rBW+KSnhKzmB3lEK
	 1v0Cs1pSMddSiSSRsuExnhNw6M1WyI/xVPAsWQYmRa1EMU8U9bmizAOU7HHbMo7EV2cCg
	 chFzJIETPUxZTJkfNBChdxJk68z0Ax1OxoL8x1A67C9skk0J408PVoW4bgt6bEE8JRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620730;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=tNM8s4tA3JbEUqKP3iJkI/yrkRI/LEPVZjkPRj5efy8=;
	b=t399ENuTf5AJzRMFQc8hdFVhLMCZoUr7Y6JOIm7am60qZsJK3Vs7EmrHR8bDFihBCP+z
	 VncsJC0v3A9DE1t4rzc04Yjo36BxT1eik7R+Cyafeo7DPJxg/3ldkkaXtTE5r4kmjejS6
	 vJYGgdubLLrip+ZaGjRUhQBU35ZknIF3mO92Sex1ZOiogOwKP6UBVqykwSGOPvyYi0xNd
	 KhIpSWUwNurbyim+S/TVkITpgpZFi3+ALJGkq/oLNv/+DcaFvi99lbqt+EQNqRr6Hghqc
	 8uXZqwlzrVwwfIxFb7ix0kvzzM21Gufbj6WV8ytaRiKvWyYDTDdgw2NrdLii+/VyQeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=KfReY1lg;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBC60A262D;
	Mon,  2 Nov 2026 11:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45DBC60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=KfReY1lg
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b2349;
	Mon, 2 Nov 2026 19:58:40 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071770.29269.10014213666963594905@stu.pku.edu.cn>
Subject:
 [PATCH 2/2] Bluetooth: validate retained LE Set CIG Parameters command length
In-Reply-To: <179362071770.29269.15160948500453012976@stu.pku.edu.cn>
References: <179362071770.29269.15160948500453012976@stu.pku.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c203a1903a2kunmab045f0fe84d4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQxhDVhhNQh1PHhlITRlISVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=KfReY1lg8diWz8a3Mq0q9BwtEBy9vX9WK/w+rkS35dte5W9Cm1qQF8H6Vz1zFS0z6GgsVYnuCPVTk/uia5fFYGn4tzVCmUYmyxDj8Iakn3Im0j/OA4HwxT0CgAcGQUprxA0IwizoCtPe4KqrPvHCcI8ZYiTrUtFbsxuCbZsWmFo=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=tNM8s4tA3JbEUqKP3iJkI/yrkRI/LEPVZjkPRj5efy8=;
	h=date:mime-version:subject:message-id:from;

hci_cc_le_set_cig_params() validates the controller response but not the
parameters of the previously sent command.  A short command can claim a
large num_cis without containing the corresponding cis[] array.  A
complete successful response then makes the handler read beyond the
command skb while looking up each CIS ID.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in hci_cc_le_set_cig_params
  Read of size 1
  hci_cc_le_set_cig_params
  hci_cmd_complete_evt
  hci_event_packet

Obtain the retained parameter length and require both the fixed header and
the complete CIS array before using the command data.

The reproducer no longer triggers a KASAN report with this change.

Fixes: 71e9588435c3 ("Bluetooth: ISO: use correct CIS order in Set CIG Parame=
ters event")
Closes: https://lore.kernel.org/linux-bluetooth/179317463153.87610.8996555110=
609321376@stu.pku.edu.cn/
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 net/bluetooth/hci_event.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8dc632329aeb5..62229d3b0b33f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3975,13 +3975,16 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hd=
ev, void *data,
 	struct hci_conn *conn;
 	u8 status =3D rp->status;
 	bool pending =3D false;
+	size_t len;
 	int i;
=20
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
=20
-	cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
+	cp =3D hci_sent_cmd_data_len(hdev, HCI_OP_LE_SET_CIG_PARAMS, &len);
 	if (!rp->status &&
-	    (!cp || rp->num_handles !=3D cp->num_cis ||
+	    (!cp || len < sizeof(*cp) ||
+	     len < struct_size(cp, cis, cp->num_cis) ||
+	     rp->num_handles !=3D cp->num_cis ||
 	     rp->cig_id !=3D cp->cig_id ||
 	     skb->len < array_size(rp->num_handles, sizeof(*rp->handle)))) {
 		bt_dev_err(hdev, "unexpected Set CIG Parameters response data");
--=20
2.39.5 (Apple Git-154)
