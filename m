Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946843;
	b=Iq3e7dPMkWniDKzhAbm1/ailZ1UGTiMBpKO4Ojpa6jW3Y5SHcdZHKXIdABmEAq/4EY5w
	 hZpfDFlygENtihlUkrMAaSQ1qDmapv16lhOR5aUmWlcFesmoAal6jCsk5kNrKMA4DYHu0
	 A6Y1aVK7JmhXr48b2qxwAtc88uqLO+BSQ1gl/e1Rlod3d9KGxmcahpAAYoAzSExsaydXj
	 q+RapKbB3HvXDOs8rzfK84Sj4qqh+1PzHMsF1d+vnMCjbOlgHhw9++o+a7CnBiJNoX/Xw
	 bEX/1kiAoa+RSpTFr/pwV2jjMS980XPFlaMckvttw4RUPoLiS9E5Z/EDak5d4LOpDcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
	b=p54CWqb2h7VorGlL4GxCIcZJp4plDb1k5z5AzYRBGwu+MudWG47yWAyftd7Tfa52uVVd
	 qpPCXl2XuidJIGf3cpWpv6hMyF4R4neBvp6wPtMI0AO4No0E36HsNj4wstKwmxxdfwzWy
	 S6rh+S4QFskbBVw/YljKsD2OAB8AiBphtKziGVntIlOkCfF9yoSzFv54Xj4LRYzvHG+t4
	 CXjEX5YZk9SsNDqEYLn+ChLoSOSMnpT+yCCPSzzBjCSCy4vxel4Krb0uq1oVV1uJpXX9f
	 lNyBn1JsgAPGxlHdt9ACcDfwqOX8ySgEpxwnIVqteeSz0JDg160LEsZkbXahntmfrLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JqCZMDQs;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CFC606A338
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00CFC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JqCZMDQs
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7d65662077cso122681137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946842; x=1795551642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
        b=JqCZMDQs807rppTZWN7+JZw1bHQvtE4/PGLUIlr5gf3N9dIQfhUbj4VJ0wTVtvGO3t
         08FGq0YRK9tmdSPUOQgLL9R00/pf6YUkvVMgHoqbOGTlC7LwWzODRjPVd6QCvFo9t/iZ
         Sa5HLeQOSUEn+9B+cElEy7/gTH8y6k1tRqu3wlWMiz/Rpal4yYjYWc8PWV8TrPWt21WG
         mZQN6/DoZP5efj+HhQ3lBvEMKZ5pPDyMkBXQrL8fcxblLLi1fwzYOitWc1jzzk6kfBZE
         hmKxZg5J1rQh4KMzsJhshc8YTA2FU0nfMSTqOii1ir8W+PbgnDqAZYcDT9nGRtWqfVCZ
         smAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946842; x=1795551642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
        b=oOV4oy90IWEpTLssEzsV7eLOPH71IyFuTmeldMUPRkCFVhFyAhNKPKWaFv8+v0GHDA
         qlalVU55ibdnYvRJdASiq/e7/neN2niBw+gJGHQzigBIdBEaxquJSYIA7YQMwWwXV3nY
         fwaCn4u2AoJiC4hWxWUlgbY9cThM1rv8nNl4e7EYn4weZwgyGeSyeSK/9oOL0noEzsB9
         ZrQFbFXqk17D9mMLCQn4dbovppWXWCwse9P8ajvoAoKuLuThpwB0JKhmBEcR7MIXhGzp
         mDYUmxD5C/AUzPmup8CvEnySM06QC9Tpzwm7t9DgBlIk73ct7EFxLc0M0X0Ma3lGq9a7
         hZXw==
X-Gm-Message-State: APuU4Z/m/VdRUJkRGxrgEWftfnMfZCyFZGYris1VTKBcV5lpaOQX7T8/
	8XAV6xKd8PuKGK3kFaH6ZHlt/0+TZtk9BBy7Ebd6wIvPcirGMCGWiaVIuBGu9g==
X-Gm-Gg: AYBFou3RAQi9KLELxQqUjKEUy/Fo9rXVSM0wMAEvTpnIjnRBDSKqzM8+hML7GF8vtYw
	WbB6uKlVpYa7R0TsOMhah3MA0NocBrq9lxio6Aim9tewOVE+UL1Cf35vIf5oWsAp+KTS77nY3a8
	jpSwHSWQxrp98dIK4kIQalJ16fR5D3NlCLGMs007i+NdKhhqISmd1A9LNoVPjC/viAGpaFfsaGc
	PJFVBUKtl9QEltmxK667LfE9cXT907UZGl7QrdXS9EX7XlmOTQywk+JUN+AE4b4X/mh0OHZkqFY
	MUXpI95SrcAorC/yS/OTlxg0sFjUVg4Q/B6G7AutziKetA9ywiCPuKCS2ethQVq2JvYgwJFjL3c
	21rHEO1ZMk4uTyPVAq4aaoL85Vhc/HQm7XrzOJcyD8pJar/s8tjdO9XpNwpcSvcQnKZfrotlZoT
	i0y5mzWtjmKoSaocC8HMoP46U0pXqEb6WDJPjrdvbJ1BlDIK2iuQ72I6rToqESDUH5Arvdv3NCE
	MKx/c7Bd2GmDfvYDU+fmSRIpMfYmNa3z6jJrDcNnHQFgKSO4IFo+bo/stwpIcy0zZFcobXNcp80
	jDNYmujb1pp9W8Z4vyMQdXmPIUtHNvw+xhXuMu5BmEF/WBbWSIOhfG40S6ndGR7iSB3o+JRHjN/
	Z8l0GyvUFHTSeJwHQoS5wCwCOjfpcOUf2GnXVdsoAJwXaKxqpZZJbMQ3dO9fPmGJwGZLbcWxXRF
	mzC39a
X-Received: by 2002:a05:6102:e0c:b0:7b2:f3ff:6b34 with SMTP id ada2fe7eead31-7d6ba18e568mr70085137.1.1794946841963;
        Tue, 17 Nov 2026 12:20:41 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/17] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable
Date: Tue, 17 Nov 2026 15:20:23 -0500
Message-ID: <20261117202032.3848411-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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

