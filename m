Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D23403EE
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607799; cv=none; b=FeqKgKujbQT1b4wo9ONqTlIGk84xLc080sPII8VihpPx7cmXFvZJOuOqKcoq6N97DspJ/JJeMDG0DQjIWIPLUagCbU4t6Bi4gDlISeXaabk8cCCG7DCRdIehsXKUWEvGx1Vx5y6MVhoNPQaiZMpMIoXVGj+dCF+Hx2MN8fI6f7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607799; c=relaxed/simple;
	bh=WEcjtcqDNZS7fanXu6IxpCAayUzbMvypPt8/LGV6H1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBZ9+VesuxM3XcyJnpyWxyvBvmiyefTR0dd2n6vXvzSayxdIg0EvoJe+uDMw4dDxXhxXOwUA6XdDSxsT+odqKOBOwIKaof74kLM+sy3aslRtsfG9v/oU0Q2/j7XOG05pKLmqfQCe+43DlM8Ry0BQyBzyQqNo8m7PC+5Fb0l5kHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrYPViOF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrYPViOF"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so1083330a12.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785607798; x=1786212598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6O0fpU3QwDSXR0C6so4bTXrLoipUitFQ1pdNs7HEMwk=;
        b=UrYPViOFaXiGV6t8VJmrOPE2hud7yOB4Us3HBuUxlsUsRKcve/JErNuJuYubryZeBe
         YHmRHYstLVdeB4ZuK2zxGzgWiMAFq1xhSIp42ucPCSxMpv1TKUR6F4iTSdRDWvyvExBt
         ONsI6K7jDnaFkiGonq5aoD/TfCfcQjzpLHzh37aTQSKJxLGsN+/T+/KjiXNuh2xeUAja
         J2Sb0uw8IR5zml8BM+oDx4L1jkBk4GSWMXR2555BJlYi7e1ndl3y8R38/TFp5ir+bP73
         zc3R1dbTKsrDLY7fiaPf/8b0h+9J+XWoYgq9pz439gV3B4qIJpMHfgxYDrwIZ8MRqWK4
         Vfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785607798; x=1786212598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6O0fpU3QwDSXR0C6so4bTXrLoipUitFQ1pdNs7HEMwk=;
        b=G/Qj/L9e4HnOxo4AdJI8YGneD4BIeYq2DpjvtGjVehGC+jTgU97F1I0z2Z6ReUrd7M
         cCId7IxjXV4PfTZzMSqMI/O8qicxBMPIZGs++pe+XZI9+cQnT2ZEizWdgMgV02/HQtbR
         NTEb0rN9QZDsmbA/r8I3cjhPDeDI5QcPW3aGHzrBYSHunGkfWebrecEuH0tT8bgTkVjL
         3IXd+Hexq9wDkf9EaBgDQWZb3pAtnu+2d+McFRh3Q9emfFgtZc9oeOOg+wxosinS5gL2
         lsNFLJYQNTetaemsCDzNWVMSDKriJWMYA3qi1JigIAcSLsGtozIQbqlfcV9IaMCrEBaI
         A1vg==
X-Gm-Message-State: AOJu0Yw3OSNnnh2kwhAJ7zfizq9V1cbHph02QLmVGUJgOlv24F+QhbNR
	oF9XN65X4mqFViSfy1qeLxf29vLB6xDQtQThB7KFw4AQ8kSCVMM24fTwPF0h7n7Y
X-Gm-Gg: AR+sD108d4Tk9gRA1/hkkBuDP2/0psZPEdxUi6Ib1KB608TrwFwnBnZMTkITnsu1o8X
	MqNFiTq4e9M9sC2j5ZAH7bJYBL/1MtwWXNbRjnolfDxcs6RUvnubM6TOMRCqfJ1tH1RL796iCU7
	h600AiV3E1fT4yrLhmIU++9ouaJNA7eVhPNpZa3WLCzxLbmGZmQkktf7KC8m4u7tX/TWsCaKt+A
	KH1FsC68gQe+1BU7+dzS4XMW3shTw1Zr/ZmCfc1v6Rmd5wujKyhArknCEOQ7vglmXzLyQ1UUcIJ
	piigek+EZuF1Rd1VAQdmoAjtpNIphqFjxzfErC3AWll/O9uPi3pqeuwHzgl0OToDsMaXA32UmmG
	vkkKRsyusZYVtS7QkC2/IgpwtRa+mphGhDudmUeUoL3tPAK55SyC/QFVusRnwWeR1hNYDtm1FcH
	gOuzwdnkIQp9pRY4siwexi2Z4u7n/M4zUqZV2a1a4BGBmLBKpLYL70MsNiuDNCRZCoN78wGanvw
	A1f7dOw01CjX7gzC1vDi8fSHsjjYPBEnC1csi1tK5TUWYqhnd33w5mEa0S8OzARiL58JvZQoaoy
	/yC/kYUM5zX7YDBjzlE=
X-Received: by 2002:a05:6a21:1798:b0:3c3:c130:3532 with SMTP id adf61e73a8af0-3c92a9c16fdmr3674481637.41.1785607798104;
        Sat, 01 Aug 2026 11:09:58 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:7865:f907:f2bf:8664])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e70esm34428797eec.29.2026.08.01.11.09.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Aug 2026 11:09:57 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: validate LE Set CIG Parameters response
Date: Sat,  1 Aug 2026 23:54:52 +0545
Message-ID: <20260801180952.52072-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Command Complete dispatch validates only the fixed part of the LE Set
CIG Parameters response. After that part is pulled from the skb,
hci_cc_le_set_cig_params() trusts num_handles and reads each entry in the
trailing handle array.

Matching num_handles against the command's num_cis does not guarantee
that the response contains the advertised handles. A truncated response
from a malfunctioning controller can therefore make the handler read
beyond the skb data.

Validate that the remaining skb data contains all advertised handles.
Include this in the existing response validation so malformed responses
also follow the established CIG failure handling.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 741d658e9..fc6ce00f6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3827,8 +3827,10 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
-	if (!rp->status && (!cp || rp->num_handles != cp->num_cis ||
-			    rp->cig_id != cp->cig_id)) {
+	if (!rp->status &&
+	    (!cp || rp->num_handles != cp->num_cis ||
+	     rp->cig_id != cp->cig_id ||
+	     skb->len < array_size(rp->num_handles, sizeof(*rp->handle)))) {
 		bt_dev_err(hdev, "unexpected Set CIG Parameters response data");
 		status = HCI_ERROR_UNSPECIFIED;
 	}
-- 
2.51.2

