Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620725;
	b=ezB8vguV0Oa6wpfPF8kJ+Q6hvx8Ac3UXz5I64bq29xA2fo5oexfYKO/unezRQ1JbIarj
	 2TcRvYr6susN2VUag6z2C65A6OB7fJwpNmgiJrgu+TgdIwkM6F0B3MfbkdZAI5kmjp+E5
	 HyWFYm83fyPLiHYkgwqZAs53nj9HXswfV/Oh/MCLM7pBvaWom1US3r/DvTfyRiHr2oIsj
	 w7TVcrgwi167Nw9ga8kXUUSlwl+DGOAcg5Zw/st3j0HUwzho++egn5OKv6VvVHTdh1xeR
	 6hbnbnjEdntkw9vy8WifOl+/5xEiuc2lDM6IqPf0zL0CfChcNI/t3URBrASFE0Ij7Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620725;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=/ntGnjJCpKQdQM++g/eRYJ938DNO72PSW6XAQpgbrVs=;
	b=nLw9bVBZeD62HsEeMdGIzUqfSM0vlqu3Rbp2kq4ZpWMgj6dVqFEH69/o/v6v2nJGauFF
	 XHTrVckofxO3NvmMN65GIhX5DXQCMT+f8fUDs37TwtzToRQ4z26BnFxKA8C31xsmhPHq7
	 jvDvmOryRcWpCWKSF3QpJc7wZ/aGNqUGS7UoGkrWWsyA8y6rNCO+P65lzecD3ORJs1bzr
	 d85sXTM/yv8J7+ajPEODGB704/+TnwL6t1i8tNjDKLz9RNd7R7l/7ShH9agj5Ucc0LZ2i
	 XLYim0BuKzu0O995Pc8K7Y7u+HmU9Am5Ue5Lk6FoAG+iSH8p+ZfN8ovGHaY7gwFu4ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=EoGy11zZ;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E8606A329;
	Mon,  2 Nov 2026 11:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 877E8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=EoGy11zZ
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b2348;
	Mon, 2 Nov 2026 19:58:39 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071770.29269.17982398081263832695@stu.pku.edu.cn>
Subject: [PATCH 1/2] Bluetooth: validate retained LE Create CIS command length
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
X-HM-Tid: 0aa19c2035ef03a2kunmab045f0fe84d0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSR0ZVklOTEJPTE1DS0xMSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=EoGy11zZDdkDUeufghbbYIyKf9/rHSdaO1tBqiUJaBfOflKT8BpIHfz+pWK7++6pncj5WuXrE3LFX8LJaPfcgbiDLZ5cIL3IW/3QrKHHC8/Jh9j/IsGWAxlioy90FTboICpNMtyrMV7BnDpCmtMGBOBivqIeAvahz2VRF8B416w=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=/ntGnjJCpKQdQM++g/eRYJ938DNO72PSW6XAQpgbrVs=;
	h=date:mime-version:subject:message-id:from;

hci_cs_le_create_cis() retrieves the parameters of the previously sent
command without their length.  It then trusts num_cis and walks the
flexible cis[] array when a controller reports a failed command.

A five-byte HCI command containing only num_cis can therefore make the
handler read beyond the command skb.  KASAN reports:

  BUG: KASAN: slab-out-of-bounds in hci_cs_le_create_cis
  Read of size 2
  hci_cs_le_create_cis
  hci_cmd_status_evt
  hci_event_packet

Add a length-returning saved-command helper and require the fixed header
and complete CIS array before walking it.

The reproducer no longer triggers a KASAN report with this change.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connection=
s")
Closes: https://lore.kernel.org/linux-bluetooth/179317462624.87574.6271582002=
629080499@stu.pku.edu.cn/
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 18 ++++++++++++++----
 net/bluetooth/hci_event.c        |  7 ++++++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_cor=
e.h
index aa04dec451534..dfeae27250ea9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2426,6 +2426,8 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff=
 *skb);
 void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb);
=20
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
+void *hci_sent_cmd_data_len(struct hci_dev *hdev, __u16 opcode,
+			    size_t *len);
 void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
=20
 u32 hci_conn_get_phy(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 209244fd93918..25ab26dab5cca 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3159,7 +3159,8 @@ int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u3=
2 plen,
 EXPORT_SYMBOL(__hci_cmd_send);
=20
 /* Get data from the previously sent command */
-static void *hci_cmd_data(struct sk_buff *skb, __u16 opcode)
+static void *hci_cmd_data(struct sk_buff *skb, __u16 opcode,
+			  size_t *len)
 {
 	struct hci_command_hdr *hdr;
=20
@@ -3171,23 +3172,32 @@ static void *hci_cmd_data(struct sk_buff *skb, __u16 =
opcode)
 	if (hdr->opcode !=3D cpu_to_le16(opcode))
 		return NULL;
=20
+	if (len)
+		*len =3D skb->len - HCI_COMMAND_HDR_SIZE;
+
 	return skb->data + HCI_COMMAND_HDR_SIZE;
 }
=20
 /* Get data from the previously sent command */
-void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
+void *hci_sent_cmd_data_len(struct hci_dev *hdev, __u16 opcode, size_t *len)
 {
 	void *data;
=20
 	/* Check if opcode matches last sent command */
-	data =3D hci_cmd_data(hdev->sent_cmd, opcode);
+	data =3D hci_cmd_data(hdev->sent_cmd, opcode, len);
 	if (!data)
 		/* Check if opcode matches last request */
-		data =3D hci_cmd_data(hdev->req_skb, opcode);
+		data =3D hci_cmd_data(hdev->req_skb, opcode, len);
=20
 	return data;
 }
=20
+/* Get data from the previously sent command */
+void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
+{
+	return hci_sent_cmd_data_len(hdev, opcode, NULL);
+}
+
 /* Get data from last received event */
 void *hci_recv_event_data(struct hci_dev *hdev, __u8 event)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1f80f2cf6b2c8..8dc632329aeb5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4481,6 +4481,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, =
u8 status)
 {
 	struct hci_cp_le_create_cis *cp;
 	bool pending =3D false;
+	size_t len;
 	int i;
=20
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
@@ -4488,10 +4489,14 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev=
, u8 status)
 	if (!status)
 		return;
=20
-	cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_CREATE_CIS);
+	cp =3D hci_sent_cmd_data_len(hdev, HCI_OP_LE_CREATE_CIS, &len);
 	if (!cp)
 		return;
=20
+	if (len < sizeof(*cp) ||
+	    len < struct_size(cp, cis, cp->num_cis))
+		return;
+
 	hci_dev_lock(hdev);
=20
 	/* Remove connection if command failed */
--=20
2.39.5 (Apple Git-154)
