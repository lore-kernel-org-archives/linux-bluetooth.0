Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9137C901
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826331; cv=none; b=iJ2hyRMV6OV9rSERJgtoLUVj2fqyt4H6AT8qU4xzU/vCDCU8aRClqpSj4Q5AFCqRia1FdLcI8EK5mYjesZDQjvIFyUWEZKwEm0UOVAlpXednHC94TBumWCDbJfBH7sEk3e66t/SnXBDcmJ92Z+K9m4hvAi5DoPjT3NGJ71vkhX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826331; c=relaxed/simple;
	bh=zdMaYaIF/WCaUO1A22gCU0P+PgdUjBhJZEz17jz2Bt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOQYCKOVvw8FvztAY+7xoPqYHUrJg8E8wqL7McDKee6JDggsBn7pjPubT2rNczdS2CxyrmNQd+WvwEBErdBcoN+/7GR9EXfd5bMGS6Xsc/pssrVSObwqbgCjY6Y24Uh0BqCVz9V4h50tyV9XPwc3gh21ncNO66I+R3s0dfIAleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ49ZISy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ49ZISy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ad135063so72319385e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 23:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778826328; x=1779431128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1gkR6dt+RMCWBmuIuEthasGqBXKYWjHEwzJZ2BcFqc=;
        b=gQ49ZISyin+W8yjszGpFSi7ZaUKdSAvM0tNvvdRwICjjvTSEFZTSWMUMuaG50FB22o
         lXpzYamlmkvSZjUSaESGg7LswCiqg5VtdQHB1rcLNZ/SYniUmSVlK0XY4PnzIzcUjZO1
         z0v/KYppWaGYUsTGsmLQBpNQpGfjT/NrKwgHPXzoIVijd/vrEomX1vc9FeQBbjywU/76
         VdgaQHICSOUuDPEwcs+YMp7JWS2fENdnum+FdoVuVVg9KWwMlKPY7rj2EXNNkjoscXUf
         wVtxDViEx1yiP93S1OAPGAoUdU2xdPFkmP42ft8MROjzL7DsXY6rQ4LVJLdprtOc0Bjv
         GQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778826328; x=1779431128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1gkR6dt+RMCWBmuIuEthasGqBXKYWjHEwzJZ2BcFqc=;
        b=FlBCIWCILGO5bS6T4Urp2l+kset43EZLn9qesSWZrQ4/03l5wPBF7ypvoulo24cQeG
         BOXvTfjCUEUlm+1xkMu3ttDJ+e0RSLJefYgmcZun0HD4whqAxZB+HueRonMpTm6/lFB7
         6yM06Z91SDydwhaMYODcHbXWgzjBReSypE2kCoPwEyOP3w/4gE+PiUitxWOPs4LDWDv7
         QvKmWl2IKdwYGSIOvQu2oktYmSGJsumxkN+XFNjwyCdNPaOuh4qvr3E5JzU9dSc/1p7u
         ECjR/2eRcpMK2o+mKfZGZp/dfftrKOSl8N+8OtDYLGycLARaUelaaGi3Eze2tI+VHRr9
         Oz5w==
X-Gm-Message-State: AOJu0YwQOHPBm+7+d1irMrZaJaa+B0PfY+obYfUadUzsnlrOstWHVpnC
	JCOLyrnyjBnZtR18l2q5Z/ErbT2YCbHSpo60fYYg+8h/S9f8x23FeMWa
X-Gm-Gg: Acq92OEugGx4GVdLMQ07dOjZ1xRoEJPJGGDglMpGmLeZlvp5YcErFCctdb68/4Rros6
	ACTfWKjOKYZ85EysagQIpWN5AiuvbiQx+6E8KG8JgYKik+W2g3h8AvfleDdimx4ufcLXBTBnYMd
	FYPm2XNL7XTAmvGaG0xNDgt33oyZetfvdqA3A8zPrtQ4y9tSGBatssRVbRBM6C95qOJg0nz4L2B
	+4eB9NdAXOp27YgTmGZu/DKrI8TYEqVpQFJ/AXfxI5OBNTFWmHpgumUKfOFc/Me13MU+jJlh6+L
	8Xtp6wb8+yOZo/AVl4NUf+XBz+gPWysKxTyEN6/7B4DeVJgR5bhjaO3jd3GO+CddYQIXXQurGwQ
	ag8xwKwf1l5CqSGdPDT5DdBo/zoXhfpu0u4L5XY3tgwaTIAY29g8xp8cNKlBDuaw3rPyrF++I1n
	FZ1hZwvui+98GSmKXIbzmAGgqRTCRPxZdrDs9Zsdk+ajj7YElCsu18VVEXPdDssWEuzdh3tbZWU
	WUk9PtTI5cz1tRAHMVsdQ==
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id 5b1f17b1804b1-48fe60ecb9cmr29688155e9.10.1778826328398;
        Thu, 14 May 2026 23:25:28 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm11016277f8f.24.2026.05.14.23.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 23:25:27 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
Date: Fri, 15 May 2026 07:25:25 +0100
Message-ID: <20260515062525.57603-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ISO data PDUs carry a packet-boundary flag indicating START, CONT, END
or SINGLE. The ISO_CONT branch of iso_recv() guards against a missing
ISO_START by checking conn->rx_len before touching conn->rx_skb, but
ISO_END does not.

If a peer sends an ISO_END as the first packet on a fresh ISO
connection, conn->rx_skb is still NULL and conn->rx_len is zero, so
skb_put(conn->rx_skb, ...) dereferences NULL and oopses. For BIS,
where receivers sync to a broadcaster without pairing, any broadcaster
on the air can trigger this.

Mirror the ISO_CONT check at the top of ISO_END so a stray end fragment
is logged and dropped instead of crashing the host.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/bluetooth/iso.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7cb2864fe872..b971281f0a2b 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2593,6 +2593,11 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected end frame (len %d)", skb->len);
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.53.0

