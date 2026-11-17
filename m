Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941867;
	b=RJgMwflo4kGq/b6sa8N5RWZR1aGkPoKtKBbx2h6jTzskV5uZSHcxJJh2xz93MHNPbqIj
	 alOPItDg+iOT7ioXb5ecPLyVEm9qK0Kt+gKrcDeHiLZBXMCu9wkMZHREhfzweneaYAWiU
	 dtkL4pBPTLrlq9xnlilVKE4/al3ZdPYiUnhEFAjKXsI6YRtHYErPNOh5gRcBMIPe9kCj7
	 /2KPF8dMWoZ8BF8oqPtscLlpPDRr7ZHxsakfA5dW8CsfrF9KmZxlvvbMSjPQ1JBw+CdWd
	 GyLf2lvBju2zhnPHzdLcXud14qoagQwwfXeaXeUEW7E0vtAl9pqxQwNx8GhJj79TO8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l5lVligyK/bzMU1OK8fs6mBm+waz/QTy5LcGwfTw5cU=;
	b=5nOuRY/qzuta6JynQ6nJdj5tJwbg7AT/svD0repgICr0wgwI9sdHX70FoTi/OgKpkd+I
	 SHC6g8FPdMuc7ab3IacZEWnKsdVou0OrIFgJwR2sm3GT9Yi8eD9/Hm+7mIZSh+vaUF/dG
	 jQwkWyc8qHThmvqOuUVahsxeexl8cDN7O/khVy9ZTVmsx+BJ+GMcyvAeV0O4NhIx6IL9N
	 5I+AhoRDSPJeQMUT+XYmcheCNVaym728z4WeU4RksSHs4yukOzmtFijW32IhuEkxR/otg
	 TR0ke4WtcfLjyvD5RVzoboOu7q8RvILatACs3RrZOxiXO5cIBSkx1M4+EydkKbm0UeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="T1oBjE/y";
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E736606A338
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E736606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T1oBjE/y
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc91ddf447so48804137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941866; x=1795546666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l5lVligyK/bzMU1OK8fs6mBm+waz/QTy5LcGwfTw5cU=;
        b=T1oBjE/yQim+TtDXnHDwSXkG0JTO6GzvJ1geDSDJ0k3T62eno0tQvz0LzdS7nbddcR
         KOkrMHtM5hOyvqhKZZDJAtWSxCxUk9XaJKsWZ33rbflAU8ZwqZ8w7aIssy8r6I/iSbgi
         Hfvpl3RVrsXUA5RBXeIlZZSwJLuHhKWwVevGz11yWhPVXAGtMuEYCnJf9G8uaD20Ryhm
         NcEcTAH3pJsuLxkWRw7rypH7yzok32KWTQNs5OcbPIN4dTjj9qyGVb1FEXfVfQp+3MXx
         3M2Xl1kQ/kiC59Ch8759+ezl5freSUTcvk3XnHlfYpSPJWuhA6912FH0jPtLRPRzQYcQ
         W3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941866; x=1795546666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l5lVligyK/bzMU1OK8fs6mBm+waz/QTy5LcGwfTw5cU=;
        b=nF05Zv9NVbLFmObY7M4PtRjpo/nUSZv4LX4I1wIAavxUFgYqBKl4j6ow/EVBPbBy5X
         BisUq5tzh/oDiS9+7nL2Sk4Zlv2H61bj0gdSNm0canVJg5Wnb1r5beV6jQEucMBomqog
         HBWIN76UAIpphq05E3dxEY8WpSpSFrot2CdN8VHrgFF8qlEd2C3S0+7++OsN/5f13LDi
         yb7WScL/QkZNyOFNhnjpyXXaQsjg1hg20/p01Sws5MaLek1bwRuSzkrJaKnszrBuDRzZ
         4NhV7VgCQzs17tzOG7LhRRGgUveNQ+fdYKdwQzte1kYHw1kKjUqJ7AlRNGRE+xmURLJX
         VzCQ==
X-Gm-Message-State: APuU4Z/8b6m/UkHefwghRX2jaPSwr66Nso857AcKE+Z+B6pgcCsBs3LC
	vGPe/BPx85eWTZXWb+Sp6215eCAC+iQrdNipUpbSf6etr+xfe9jKgJNfmrE5ig==
X-Gm-Gg: AYBFou1mUoYjr/Ymb5Vz3AmrFJPIfKs4XtBgbx2ho0Hxi5B+nbq3oHFrc7avZ3QfaIM
	qeRQLLunXQKehrkCeJzK1bbDGKbfPCQxby8ayCwpaT2y0rzN9/muLgqOS4U12DalH+/7P0wLSvy
	uSOq6g/6EKwqCSBmIhWkWNHGPPkk/sNC+WxcE35F/AptF4eVnlwxm1sQj5RMI6IwBGmZfLjvD46
	pgafzH+BH36pigFDo0rImUoOqZC6RfdZBhQblmEyrgH/f1CKcFrTsM4vZmg0ejCCBb4m8Cy7esp
	z8GPWuVZjFmoEG4dlvLex8uA2PPvsXAs6wOKJlR5ev37btL14jISHc8yMIER9YyDVIg/rysvigF
	y5gC2MjtJIuzJCRoIJ1kkmE4jpARLv7kMTZ4RN1rW9H9jlXGVpDDobUBnMU18cAgn0EiQPsUBS/
	OOy4HDKfONfYVt+OSdSYV/pjKtmseOoSFppLkigJiJhXOpAyJeTlE96nUkI+k0/dFcLTt73vo2S
	H7deF7TzXcQmaG5laZErNXlOGrBbJAW9uYmx54uyG7JdXz9bC97Gn30f7Z36g4rCrdangxWml3y
	ZTrvCZ4D3em4s6YO2A9ZhUKCJ/yMDJilsAsWPeFFoZIeMIm6mC20Pz9EnCqmu1JZhhOifxbRdm9
	0vV564OoxxelUn10+eskITeZJUa4Kq3SooEdxGuesCdie1WQWGcj8LueG+FjAfXmSuRXr9nON/l
	t2pWc=
X-Received: by 2002:a05:6102:644c:b0:7c4:a0e4:1a79 with SMTP id ada2fe7eead31-7d64d76b2bamr4747755137.19.1794941866137;
        Tue, 17 Nov 2026 10:57:46 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 08/16] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable
Date: Tue, 17 Nov 2026 13:57:29 -0500
Message-ID: <20261117185737.3758255-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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

hci_cc_le_set_ext_adv_enable() read num_of_sets and the set entries from
the last sent command without checking its length.

Reported-by: sashiko.dev (linux-42bcc244-62e6-4295-802c-f9a512ca49a3)
Fixes: de181e887ac2 ("Bluetooth: Impmlement extended adv enable")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e93ecb4016ae..8af51524e41d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1685,14 +1685,16 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 	struct hci_cp_ext_adv_set *set;
 	struct adv_info *adv = NULL, *n;
 	struct hci_ev_status *rp = data;
+	size_t len;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	if (rp->status)
 		return rp->status;
 
-	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE);
-	if (!cp)
+	cp = hci_sent_cmd_data_len(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE, &len);
+	if (!cp || len < sizeof(*cp) ||
+	    len < sizeof(*cp) + cp->num_of_sets * sizeof(*set))
 		return rp->status;
 
 	set = (void *)cp->data;
-- 
2.56.0

