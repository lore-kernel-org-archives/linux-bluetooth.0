Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946838;
	b=ImILsc0DA6N/Z7leiWEheUksKiCuw7yn4hEwoQBoREkOrRdrv7C0QoEYn3+G1+NF3N2t
	 +Dfo1jXiiKzRDg2MsyWwj4D/LWoVpvahWAMDbPrdK2bcK0kyHG8oHNB5jNIPdu3XJn33P
	 RTRlj7XvvHlkTk/joiEa0GO2gdLs/IBLG3eCrg8RuazNRQUjS3MJVA9cKE/FNMT9l91j9
	 GqqbiWOfzZ1jBPsTt0UQeDgjEcBaPr6A31J+V8a3YAhO184KD/heS3WIIBKoSIoRqKC8D
	 I/cSqLAgwlS8cjZa0V9BjvYjcSesdhf+pHU5Ywd6zVSlQGn0bNq01m7AX6hySb6thww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
	b=xuupO5sL3qBc+s7GsHn33FmolBVejBjgrQqUn1i934xOX0EFIvu6GxpmneSCvEdOCesw
	 0OnV7w5pYtG27qQYa3GsknSxTwuYJoqC0N3P2u+UjQAawKcNvF/W1Q74mYkYVGTdHYyjm
	 hHZBej8VBAVwnCNCYFW8o0tQiYIoHI+7jgzWcUmyNoQaPSCkSup8oWBfyTgVN4aKXLTDr
	 h8Jr9yPFCiZJEfY9BQbnuYe7kTYYPWXhbfngxjP5/gmuA7Hw8rSOGpfFcVPkLxdTJmhqV
	 hMXAC/HLSbwCXel1LzUSDd8c+HH5/b4yOHdg+5z3p1h0dixg3GB9h2jVJVsTzoQsWhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MMR3eoZj;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55702606A334
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55702606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MMR3eoZj
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99e0b1ee864so84110241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946837; x=1795551637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
        b=MMR3eoZjl4vEdxjUfwDTk4KCHuWxcr77qJmkuzX6BI1O5MWIMZ4eKzTuVEDghTGw2I
         TAdnVz7q8cN/okJ9nW+6RayyrOIiEEy6beTVTYhKl3Ty31uBijHIkmnTaHnFTpZDlf5A
         6b2lNDG4RPEKInxgbcEzDRM0gokvo2aNFUvyHu6HCDySEFrgs9QiNp1yKNA1O9kcDmg/
         9CycitBs3AFpkoDN8895e1h8EJ9MBfS0HHbeMvzJkMFmp0TitzeZ9qP5IHeEMGyQjpQT
         ZyjP23mRUacPEeoLIU30kBFphTBejIbUh7yRFPdZXMxkgim26b+ypuGkJJ+XynOuYuP3
         PF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946837; x=1795551637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
        b=2srpgWTrAGw20q7lr5BFR3pNzZYjtTmqXYfB62zJyKLliTMYB6Z9boANonJAVcu0bd
         onyx+l3Wx6j1k0hFIqdXmI5OM+Lv5EYoV4Ayd0Q4RRB+DprLeHBwIXWuto04rgAYaiZx
         qeeTeDFQplRrGq2rMjzdaki/md+J9Xx5V5MPKHEoCC7RadmwXNFMzqof7nWAOboo/pKV
         5NeUjv7O4qxXJZWFP/jdHdGZ7bJrvN4MybJ/crmYSASVr0dY2ZoTMAQw/YVbMM++ThFQ
         oqwjseUAljOw1P92PtjTqJLKPGq04+HFzNsxctReh8dOvg04s2TROmujIlZakx2pLvPf
         hgFA==
X-Gm-Message-State: APuU4Z8hQ4Mg8JfYpXprmFCi3007OGlC4mBwPW/LRG4tr/K89DEPXISE
	6FzQbFdHCpzgGVVGTY6K4mdK4WoL4Z8wqDgx0fNrVXg/tfP94S1T+GTmULmFBQ==
X-Gm-Gg: AYBFou1e8tw5dn+EYSxmiReiS9gQ3X3rui/VkESB5rCVpyomB71N1xZn9SzhjLeo/J8
	ZHZ7mO7k5r8fLpPaxIG7XYX9KPq/nB8LT5ztd09DfbwENI0YjKVtesnzF8SNro2Du1p2HLb94RM
	HA4jq3wJ8xu0KwM5G2q0/0gdsserB7ru5HJBAiA2F+n4ZvO6Zv8UUmoLPVzHlkzBHWZMNtkZeVI
	SggjI1jm9me3Xpf0X4eQ5n/XFR48RctCImkKWXRTTCSaJJmFSQVD0nhAdTqC1l3hSqLkV4UUqRu
	87qkklsgvpLv+ooKMbcJ6qVcn0+B45xsVbm9MVNqC2ZWzfZLfMa7iOXdzmtgZaSN3Fb4XcwaGZV
	oi6lmIHcDVxtItiVALfWx9Voy+JnRu47Z/WDGlI8cqWPQ+nk5ts2lR1xIrRQ91Ufdis1rD3OJBC
	rfI1I0ht5bPibWYgm7htoCF/AYx644MxOoc5+48J68xmmrhhDHggsTgoM04yNdt6KN1PzZWTWPF
	I7Y5tvLuWB5fW+tWLE9fNoZwKhf5Q9PJJAB78YlJ08TZjbiz+Qe0MVcQ3We5ogo+/tgknpocLQH
	XOAWhpfrIyzBxpCPdSCLjzZDPCEZrpWkDDPK54iY9X39yv8s3XD3QASBwoUPG2x42LHlNSPShJu
	f6rMndXcVdElbFPgqCUMM2wqSJAHWDcgUfN62xR72+IcKqEjtyylWm5y3a6jk3N4myY4qhYmcDR
	Xx2+2LQ5KcuH1i7I6zkQ35Pxca
X-Received: by 2002:a05:6102:441a:b0:7c3:1898:e8e2 with SMTP id ada2fe7eead31-7d6ba373012mr62053137.13.1794946837195;
        Tue, 17 Nov 2026 12:20:37 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/17] Bluetooth: hci_core: Take req_sync lock in hci_power_on()
Date: Tue, 17 Nov 2026 15:20:17 -0500
Message-ID: <20261117202032.3848411-3-luiz.dentz@gmail.com>
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

hci_powered_update_sync() issues synchronous HCI commands but was called
without hci_req_sync_lock(), racing with other request users.

Reported-by: sashiko.dev (linux-1baf7393-3aeb-4fa5-806f-19cea743b9f3)
Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0c0180a616d1..9acfee486be0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1010,7 +1010,9 @@ static void hci_power_on(struct work_struct *work)
 	    hci_dev_test_flag(hdev, HCI_MGMT) &&
 	    hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {
 		cancel_delayed_work(&hdev->power_off);
+		hci_req_sync_lock(hdev);
 		err = hci_powered_update_sync(hdev);
+		hci_req_sync_unlock(hdev);
 		mgmt_power_on(hdev, err);
 		return;
 	}
-- 
2.56.0

