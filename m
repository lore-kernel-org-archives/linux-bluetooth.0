Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599056;
	b=ug6iqgmxbuTHDQX/kObnDI5qYdur29UijxlDtYu+mTmRbptiJpo+eCKIVykGm9ZHXbJH
	 vJ26ASs3geV0nkVZwBbPoBA/398+0LUxcN/oYwS9kCuVUqGRtnY4WOSh3ooyX956e+WtZ
	 kCvCd/dDTzCDdjIrBxWIuXBfI5nkmL2yIOAQ5zvU9EVW0zfOHW1LYUygfj+0Q7PoHIySu
	 7cDL2bPFzDenjD/yAHJLj77YNon+wWAjDGMMVicp0ZHwcuP7GSPS7O26Dem/bfBgw4iOZ
	 R3eBtPwcYmJkvJjxthVFO5eaC8dzuAG/Nad2SgIT9IBjZg09JDMqONbH+sx9HrhRdDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I2k/a6mQECX9SJa18m0wd08GRI20x24K3kfWl4JRMIY=;
	b=3Ozk+DUaTPlYm14Lzt/uPEedxHfsXjsRLrDfbvCqS6UukG3/j1aV+F4F7n9SQtX+i1Rt
	 SZydbXHmuDcwAG7gNLtPBIfs4T3K4/sqkWUVk6PnLzvne2cX51qkL06vsFxtyySjygXCo
	 e/Ab/nxVQO8bG0u7xS4dg/O+XYps453ucEQjTSiVJ27xOX9rfr/88cf3mWeM4RlFOVdOq
	 UfpRi1/i3rvml47ppS4QY0XXSmPKfd0j/g5WFwJAFbazgrfqrlB9ymAqdGs390gvTNpsO
	 kzfXMtDpwQpypmVMSEEHW3Ef4nbRIYfAsjurx+eCOkDIR8NPxSgzf7/6jNSpYcxNNJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YNWXc6r8;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D646606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D646606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YNWXc6r8
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-490d59c3edaso3740849f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599054; x=1796203854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2k/a6mQECX9SJa18m0wd08GRI20x24K3kfWl4JRMIY=;
        b=YNWXc6r8Tr7pGkQTkgrOwXGti2YSQEYweanEGmmVxaHxG5ojfqnJbZG0bCR8C3eAo7
         YRiN41T5jMnoDCHmBwZCD1pmx+RoHAbsAeJ7zYnDxpPVQsYYiEv1yKYZsYaQO/RSxRD5
         t4huvYenXDx8fLJwmW7BmWkueDVWntqeYQkmOz9udTrjEhUyRPhqbGde7SojZQS/lLez
         EopmoOeJFFu3DIT+PMpbB4g7KCBvpgij8B9iFQ+3ezCb5ZOLfD2HcUHw7/QNqpmXiXzt
         XF01dUkcGQqzzd+/kOkh4HI9++vDoICoyYn0Ytvp5lNBmTdAxnN0rUhCk3/FNrG4UUmK
         CDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599054; x=1796203854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2k/a6mQECX9SJa18m0wd08GRI20x24K3kfWl4JRMIY=;
        b=cW7J/HTAtUFXyKbFHTPD+Np3CwKxOCeEkOeaDR1VzzKdbXc7XrlvNUDcQ9Or158j7e
         4MJF0vqiquuh1gi1Gn0lcakYTHiGH3dOey4nN/56JARTBIrJ9ZSS6RgwM0Mt3WhyF38n
         Q/FC0aJlVqn1BLhK24mJTJf9/EHqjSalPYeGvob54MDE7N/XhXE3r8ZdVEUV4bjDLpUo
         T8EzZAjlBiB9v/kHzCoqlIiLleneSM2Y9M5h6ELTXqitmbAx9O+l5UrlaBzgV4PMc8lV
         zXKb1/nScvoBPmWV+dCHkHypjgjaNCuhuNeIcEFLjcj6yERPnijeT1NyV/LDVkgaeuC/
         9ddg==
X-Forwarded-Encrypted: i=1; AL+hErFB/osQIU+GoSrEgdqOJG1WBOoB+qwXc0KHHUI2guiMXG+OkI6IRhtJF6RNcphquwlt/sxv0KVTa2+F8Ay3Orw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1bL+Xkrmm6qMpXd2a4A8u3D/yltLd8DwudPD32NFtZa9S5K9S
	I+/G2q1B86eEkkQNxGBOwJc9lJWnr5n7c2qyRT0fc6rfxqnM5k8l0gnc
X-Gm-Gg: AZFdTZfW4YmcooKFTgWd4r1v7YfD0kULB5pnKl/ErKBo6Ei5tyN8pPpZEpszvIaoTGz
	8dcgZRheiG2bMDIm5NTWKj3jYcuzVerUnrruFwUQFNAhvC6ZC8NNCHC48lG414k9Wt0oJ/7nQiV
	tODS7l58xRyG9gNuCQPRl+yvMr0DeMkDS1Xab58zTLvN83Vmi7avx5gKH05uO3r6TrhWO6IOh2S
	2k1qpK+PdjIKYZuuhhbse0OYIhc6cEmqe0v+djpCT7SPVvjIIBQuMmAdmWADv6BWut7Dnl5KNFz
	3+4ZOYNx6jtGpwUTUo63J2ajHrWUTnr0doGTXD0du/j0tBtulCdLd0111XMbKuaxIcQWPJ8sSsY
	/Erwpv746eV8aJWHmS1/hLBAXMd53LZb8s0G572rCIYZy3vB6sB//9luza0nJ5+OtT/gOqIuyUO
	eg4JkvDaiqrHYqqPZ05vjSCVcIRlesv3D6jvedzY3Hi7NPSwjz3leO0i85SmMEKZGrDWIcEsnFG
	Uz8zlqBkei1aNom/Yd+bIF3nW6QCAlcUVTPvDjP5fH5A44AYGugu/0ja15oIYb7c4eKjoify+VK
	AYOP4Rd/lCEG98+7W/5m
X-Received: by 2002:a5d:64c5:0:b0:490:1395:9b00 with SMTP id ffacd0b85a97d-4aa545e25c0mr40657507f8f.10.1795599054259;
        Wed, 25 Nov 2026 01:30:54 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm32220869f8f.47.2026.11.25.01.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:30:53 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Wed, 25 Nov 2026 16:30:33 +0700
Message-ID: <20261125093035.224140-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 59437cbb5781227567dec226aaa88c66a09ccc5a upstream.

This fixes not checking if skb really contains an SCO header otherwise
the code may attempt to access some uninitilized/invalid memory past the
valid skb->data.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Petr: add Fixes tag ]
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 net/bluetooth/hci_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ff3ccb33da0c..f32473e02c1e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3905,18 +3905,22 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 /* SCO data packet */
 static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_sco_hdr *hdr = (void *) skb->data;
+	struct hci_sco_hdr *hdr;
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
-	skb_pull(skb, HCI_SCO_HDR_SIZE);
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr) {
+		bt_dev_err(hdev, "SCO packet too small");
+		goto drop;
+	}
 
 	handle = __le16_to_cpu(hdr->handle);
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
-	       handle, flags);
+	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
+		   handle, flags);
 
 	hdev->stat.sco_rx++;
 
@@ -3934,6 +3938,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 				       handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.55.0
