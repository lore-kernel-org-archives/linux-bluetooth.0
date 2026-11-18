Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010728;
	b=SiAJT5wbzzHiwBMMv2/P/0miuHDLkOdk9k8ASSWdHJ+mxI73FWqyLWCc+U1JPSItJYNM
	 1LCqoGWm7Rcx6H4kFYnyrWZ/zNcaoSexIKWLIOWC7vOBjY+Rwu0CJUAF8X7jfBodxTr51
	 0wxIeomJr0ZeY4DdHhWxZCjrKbjlhP2Ov9LHdTajB7CagzqIDCOemDFXX7jWEMYgfQlIk
	 Lx5Q1uGWh3Wukfq+b82urxbacWVJJ5ASLyeI1M4DtHfdw8ApmPduRXxykBqGddJmnGUQz
	 UmgRkjL7dmjyi35eb5yICPpuLxe7Fd4GYaqQfC02KbkFwUSJVUfhHG5JEhnRa5T1KJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
	b=sSYQFBUsuSGnoreVg7ZM2l0V8nuHbya8pIgKsJ1c4QvioZN+MrlrPG2VEXwHHyRg5jWq
	 TwoX+bVrNq/2JY4AmYPgja6eLJnSdh2FiVGeYCdrQSpD4+84Y7e9QHWA2R/3hTL1E8g8G
	 PFkKwTOjRXdw5tN7799yiUGWmk1FU5zJiGjt/sgcD4mE7LWhYjYgKaEvsUumvZqla12j/
	 +GdPPZ7LteosoxmphCApBZvpgYjjQvGgNVcNTMAZEkLmdPZpSEzqV/K0FWLJACA6P22QT
	 k/vVI7hUxpVNocsrJLHBvjb3ehrfaNeA3/AiB5G7ptIi2191zVlN1yuEonnmT+taP5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQ6oTCio;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051A60A2634
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8051A60A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQ6oTCio
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc013095d4so352303137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010727; x=1795615527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
        b=MQ6oTCionRfXjNFxm3UapwcDbX9iY8POCNSDPQALVZvtFEBlmIi73773a74joiZj+e
         qqKS6MLroycebvnoro2fgxBLwWOfNu2dNW6xmOQvgNSMmQQ/qsSQRqNogu5gklb+cK/o
         6J1a5y2vdPTlMUmgfSjMRzjQdnMc+mB2Ti+eQu8gquXYcITmdqzLFUeMVW71dsS/JrfR
         iIczYQQdJ/NaCJToe2XjRdz0dWFoY/pJWKym0+upC9PTUOIWTqEjB3FJH5soVdw6DYs/
         vJb/4PQKMinXORFUvjEjECfBbuBMRdFR5PIHOf/be6cPEdWjq9A+ITGaAhKcDhOA7N0q
         lWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010727; x=1795615527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
        b=puFSE06bmnJ3zdVlJaMG6SJY/O/6g6K/peS/qJu57V507F1GlRLFq+M4mWtaD45vBt
         1wDBaYFLCNHxfiGXd8Tgw1i6UL5yjGbFK+ELBbRcpSb7RKg2ufZD+XgZLSa2U5Aha6Bv
         jlgzyJwdu4Tud1u+YsIQRysXVC/KWpnMBQ0jUmS00NIIvr++moTrfr8ATisq3uNAzUYS
         tfQX56grcqr6+5F/lPwCRKjtbQ6NMPp60fUJI9APxSwpIRtzOH9n2nBuVyJnuSKkG7Tw
         EBs/W4B4VEi3oNzQzk1vLWVPbMecx3Su4kFVDedbIWvKoBTa+o9bbyNttddOWrL/xks2
         e3fQ==
X-Gm-Message-State: APuU4Z8WrGVqwlGgWcI8GuOr3CwHu1s3o7CtiVBkbfU9IMeEnEk1kqxG
	/H5/bk0mNIDmmbXDHlLtrv4RdnYnBMMz+0IiFUy41KrBn87EiFLSc4fFUJBhnJIi
X-Gm-Gg: AYBFou2xUgFIMP+dbx2WTTdUaVhIoJFXNbXyg46a59W6Bi8HGPsLJenJ8Cb/aLXJ1DQ
	AJi7g861dR4AGzsbqgbkG07sq8W+Hj0tP+7iB2O3MFR5FreIwCGGNaEajPvFPu+83W7lDXINutG
	1er2k+OrLkllClITvz7IJgdFs7/7ImyTaz6OZg692seJjAEF7KkBl8apj8Y4kV0HZEy04naXTgl
	QhI081SJXU1+dZINT0rpxxq1l+M8vfgQWL1abpUJg7rhkY0eEXj9jKreVKHts+v7E7z56nDwGcN
	fzmoNsRFSt+UhjbHX0j7mQOWiV64mwMA/epqTBIsMRq8caLEesin+ERMQB24x4SCCL+5Up90kaL
	Gl86h82yiE6/GTJ/L4VtGacCY8ScLhwrvPVGF6lceKC8UqAQQXX1uKR/FDeMB0JwdThugPeJJvA
	BK8JLNiyOw8E9tnxJvbDzeI16yKzOqS95i7UfGb5F17FKoedwBsSstNKJ5zxVyCfavb7hP4XPXB
	Sv87jygmuJv9z1J+LZZKfdN/2Cg37YtINpdKFXcWgI9b+pNxIPuJ9QVDVZWeSBBhKhO5F6TZ27C
	xNeIh5/nOzMtE1MHH/LIMUuMz/2snZ1ONX49C0JVrjREBeXdA4fqrB7KmefB36agtyCU1yFl5es
	W9pWtTiIqFsUWfQQx4Tr/9IqNqatZ23B1VWQF4l0+3es/XQWPGyCaldsugYXZ20eUmAGZIOTNyB
	T/7gE=
X-Received: by 2002:a05:6102:809f:b0:7d2:7c63:5a08 with SMTP id ada2fe7eead31-7d6ba4ba199mr806348137.32.1795010727283;
        Wed, 18 Nov 2026 06:05:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 08/17] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable
Date: Wed, 18 Nov 2026 09:05:09 -0500
Message-ID: <20261118140518.59878-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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
index 7908d920c67f..ab875b90a143 100644
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

