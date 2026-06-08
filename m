Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D42D73A6
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963101; cv=none; b=Nket8GIP2FgH/f1kpXPbIs9IYgatmyGI6vKPJky4Ef1+eYZUoUJ/3zlL4bmUPaJuSZxyWPj2X2jrqBa0OHR7E0ro68miZPjIp1OnKj7fYKcHi+l4e4R5gyhRJVWzN3c3azP2FpZjV9aAR6saFTzZFjnwt/46qQCC4SIqZ85uQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963101; c=relaxed/simple;
	bh=+MaPG0sE2g9ZCOD6O+OGplmh54i1nbPjAJmzm4EFp7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKJg4REdLFgm9yoIHwpFW39OLqp6hAhDbkVMinC7GiKmBzAiTDww80FopwhzkPHokc4oTUqxJXgkeCdObq0WUO1/2RpzaVWGhJfJnFVQLoRpS2dho6ZErJHE/PhezHQUhX9a6MwYRlcFWljMbzlAe8+gHwFcXRmocM15SnqtsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=JfAHu3/g; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="JfAHu3/g"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-91563382bcfso569905285a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780963099; x=1781567899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIsSw1LX8fuQIwXWmWGBymspSinQ9fTBOyuebnStRa0=;
        b=JfAHu3/gpjh8e8LYWMy8CfKul7rfPO+TlW9g1EF27/4AtV0KUkdEgTKZHU6+1lso35
         wFP0CFWqpONtVERNFXEK2S7zBMdVbjg0tRLWOhYDwiMVhCRrKq1ZUW8/zTDvBxOhv5uv
         CvHN+tfpjNRvRkuCZmMXlg7Lfs5eSupvs2DXQech1C8EIspnYyHw1Ft+G4lNNEwyfMzV
         JgvcyggvePUR2ogsmfwXOmMU35GX9uiF1BS8DhTTRHQMAJw8FQhySVg8hRilAoq0e71E
         a6FoWFS59u4ADGBKnZX5aQNPrlj7hBG+MUcKo2pfKVHl1fx+3F1KVG6bvFVuInO2D0CR
         eZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963099; x=1781567899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIsSw1LX8fuQIwXWmWGBymspSinQ9fTBOyuebnStRa0=;
        b=lysTXX6IcQCbmYuzKpIi9vQXZUg81VpKDcYylW5B2YMwXFV7YyerSv1qqI2eCS1fKx
         ulHbDKUJhjLGk9zsntGtHp97rnsxMZeDj/FwPAF/eyFmYU46JCoysmWBAc/uAjZ0iUjo
         edDOV1s6ivIgCdW/j5d20ZZ5DWlucYnLzwh2pIKg1Oll18uCwT2pY+RdnSDNmTZl3ARD
         goimjot54nF5yk54cFyt8666MgJBZg7ZUK5icepm5ZFgecDZMTx0K1u10dpnLyXpFOy8
         TpzTCl295G0Or+BvzAxNe6hYDeFS3fHE2QFyF7+gq+KjqIHduz//Q23v7n8bTEXhwykP
         lmJA==
X-Forwarded-Encrypted: i=1; AFNElJ+MT5gR7Pox/M2ya8OHKOOKgtR5D4sMYBPryq5WlJcpdzywQcrp9/56UATbeeSTp5IpIe1Z59GwtyaqLNrTCX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54KkSnxVqS+NZv3tqZyfC9vTF2mAoIAQUi2IJR5ojEiyZ443v
	wXDnr4zVQmXYxHW6PXXzESf5M5DBR8s5m646uG9/72xJmwXSwJYypOv4H4pncbwp4U62JRA8OX8
	282hehqw=
X-Gm-Gg: Acq92OFUlN2NBPbwLKmqs/DsDoCT5zs/rWKMt9Onok/mHk31N8YcvRc2N+79UAtbI/7
	hd70dvy4/0ZRD3eTbpZXX5UoBDi8zHkPNfZDo/OAhBeSL1AMsDvmuMa+cVYNt1WVVl1vMQvIH2I
	FkWalBIQHjExPNfRdsb5iME1oZy6sXWff5lAhjd7S+v15dzeNiB7x95h3SjQRp1VkJkFVNC+M3d
	rzKqMjEuOSOaaD/Hdn/9g8ck8GGBiWnX4z2+BZBPQI6iCuh6MRprfcOs9LYmv2cIWWEdnO/pN31
	/ZH+oRiatVVo9xiUEjQ2xnTg1KPXLAblNEPrufKxAcd0k8sLzpT2uYsMhZzymJtr85ORKooIXWt
	jxTjpE6VeggghPVJMyMKlEuBTwR8szSlSGG1hgKSMUTXqYaQ5mDqhYWwhDgoxq5o8CrNmeuOsUc
	t31piXpyatgRRKbVP7E4QoLehtKcNXomZl4o39LiEImfLQRc+y
X-Received: by 2002:a05:620a:198f:b0:915:c858:7d3f with SMTP id af79cd13be357-915c8587e79mr1355193485a.19.1780963099587;
        Mon, 08 Jun 2026 16:58:19 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a37c645sm1851892385a.30.2026.06.08.16.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 16:58:18 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org (open list:BLUETOOTH SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Bluetooth: L2CAP: validate connectionless PSM length
Date: Mon,  8 Jun 2026 23:57:05 +0000
Message-ID: <20260608235705.1233510.fe2269cf0103.bluetooth-l2cap-connless-short-pdu-oob@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connectionless L2CAP frames carry a two-byte PSM at the start of the
payload.  l2cap_recv_frame() currently reads that PSM unconditionally
after validating only the outer L2CAP length.

A malformed connectionless frame with a zero- or one-byte payload can
therefore make the parser read beyond the advertised skb payload and use
tailroom bytes as part of the PSM.  A VHCI-backed QEMU reproducer
injected a one-byte connectionless payload and reached the unchecked
read.

Reject connectionless frames that cannot contain the PSM before reading
or pulling it.  This preserves all valid connectionless frames while
dropping only structurally incomplete packets.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4ccfbda9d78..a9353fa91588 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7026,6 +7026,11 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case L2CAP_CID_CONN_LESS:
+		if (skb->len < L2CAP_PSMLEN_SIZE) {
+			kfree_skb(skb);
+			break;
+		}
+
 		psm = get_unaligned((__le16 *) skb->data);
 		skb_pull(skb, L2CAP_PSMLEN_SIZE);
 		l2cap_conless_channel(conn, psm, skb);
-- 
2.43.0

