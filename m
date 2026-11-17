Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941863;
	b=I0/kPr7glqg6C6ql2iwvCgjKP132yGRZfJyZVrVIb6D4uPkUlJ7nUE5Ws85q0/EY61gf
	 iM9OHApUydH1srmKPFt4YawViV4SCt4wtJajbpT6nt5sqiUje+XrT077cbTXgX24C/0qs
	 P9zDp0HiIKdyV3SPZgBH0nSkSqbUvGDczUcpMnn8MuMytqunBy0p9AmDS+g0xuzGfIuaw
	 vnY6QS5pkU0wzZg8Sc3Jh++o0+NP0JScDJHAIlJW1CiCPljOtJbsv4AO/W1qjfEvT0n3q
	 nCvHxasgvvrkYBiw4XIN5ymPPcdC73yaBnFegD0bg1xtjfYc+HkJlkPpP5L/TmWnsYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
	b=CfGY32LnS7MUCGEq0IBzpNJi/psykZD67LL6Whs2/ZbL+VVSvfOEwD/9WniRm6qk9jgH
	 S2ADGjQQ6jUGcZvvW475jPN7H3WA5otg+T2HYIFQWsCUinQEEXQ3psetUUvqQ559G5mi8
	 CIbJt3AXkPlg5jbL2gHRuY1ERd8bJceiHA/mYl6rD1T++VY4yYPYJAGvCmazDUyLkCm80
	 ZDBODlcdM7ihaIGI3G0ZlXHqpHZBaBx375VLi6w4FzNh4lhuaptyaw1NpOQ7oStssivjJ
	 1CsTlFYpdefdfmMRqXtwutWYz63E562WZVNkAMUuL31zryFbD4tmjyEMpOm6IYIy5IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FFazRX3R;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA470606A334
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA470606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FFazRX3R
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d2bf046d7fso57137137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941862; x=1795546662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
        b=FFazRX3RabBp3gArZLhB2cX5sbLUNjQt3UI1JnKhokJOT4XeFtVeu7kGp5Y3rF18Vq
         HB4XTqnzPhFhe4/+7+9M8HvSQlOMHOFjFGZgaBhsoQYFa0UYfx+m8ZP67SP1J8hn7qVq
         ElpjSpYJts3tCtG8dybu46f9PqjLYUm09o9x6TeNQhFXIC8nJQ1CmeLjNC+hlssw2VRZ
         0MYGZvtQu3Jo1QcE+je2NjuK/gPYyTPiBn4hUO/vj1lmN6qyvKcAjNCVVU8Sp7o1qbgp
         nzf0GDa+Vb1gP7P5TXeMHBImVQ9MmPLtTclZ/lovMqC8WvmZXCR1wsowR2E3m1gBgdP7
         Pe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941862; x=1795546662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=euAeN1WMdy9qvi9PqNGBZ1npc81wsumgZy+gwaxwfVs=;
        b=abbWGoyIAblUuf+umuiHJ+HJFEMUV8TiMGAPPmNHSnBgwjguMJ+oUYcyQRWZ+EwBpR
         bZ78F9Cx+tg3ldYqFDJiwD1dA7PFZZMShiyPtyxV7493CjUSIYIZXzwZrByO9PmwIV2T
         4jvujw4G7Cv2sWHZbnqF5YUiGzp6wTbgoe924CSIUldMBPt+2Vlui7iba+ykzQ2L2ZkZ
         Liy1q7dVyVK2ef1tV9B4cpKAWTRy06E11LmqaUyFufVD76HQWz2Yu5OUzrOy1Nz78XXn
         9ofXyxNdwJC6pBP6eN9ufrN4rUToYUnm/dsRTjciEJIcsJC60B7/WovhG8zIK28EXk7p
         vaRw==
X-Gm-Message-State: APuU4Z+tbq8CuimKFZuVKY1OVH//ipKs2ROXWXZwK6tXb3uXFZVwZyva
	pckhUDRzg9o3tWOCYUYMGim8QwA24PioPFDDDKTt92qfPH7XQWhGUG3DPC390g==
X-Gm-Gg: AYBFou31I/1DDAXSpGBmQo6tThn/x6cLinqi8blgvCLkaH2EaEhhmxhxmOsdPx/7iiz
	1HrTdkHsItPp4D+q8KAEswGeVOxTUqrn4N5CR1jmhu4mw5PriyyLHJX2IBjdNSO5grSPjrwRm7l
	kIF+yFd56GA8hkHwcO5uoO2WRHFxnqE+DjmZbXUYGT8T1SL7dsVOso9apCzdpAicxzNjJqTk0b5
	jcsE92FR6ATG2ycIqPnCs28dXWHe/rrF1Frlf9AIau7jgj72GHjs+KtbVvrZmywkBV5Zdn6b+7f
	/g6K6k9dg3v5fueogqWDO+L8j9qqisAT/fBEE+x99dsrN4hYdejFANWzDECmcZN14FCNP7Ontyg
	NhdCQzu8krXXmULW0B1AMSrt7+zVtxJckhCXRf4BlhWWLhLgGk5MjghfcXp3m+Vp/A8//N5I7Bd
	aeZXQKeFBmJf4NazRy9ArH+O/h0jvIgY6+4E6FbckPpWCkannRrOh4Iz2Mux2i9z/9odScjDJcj
	IeBcMhgf5ndqfO4vF46Rb72pQf1XQHWUy5VGpn8SANsxdWn+FVETWiDWqLIQVnQEwDigNabu5Z7
	j923RPd9EzwTFs6az+Mvh2nLfe7TKWtHiQ8cPQMaiG2LW21qkpDbC/MAcL6CZBP8k1V4aSK5O+1
	ga8iSZLzPvkiCSau8LdnqB7+fQwbqUwZu9q6d08YZqo4J0sZfbWpFLYyfGpSuC9RJeQEki4Ad+6
	W+ol4t
X-Received: by 2002:a05:6102:644c:b0:7cc:1274:aba3 with SMTP id ada2fe7eead31-7d64d76ed52mr6125933137.22.1794941861731;
        Tue, 17 Nov 2026 10:57:41 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 02/16] Bluetooth: hci_core: Take req_sync lock in hci_power_on()
Date: Tue, 17 Nov 2026 13:57:23 -0500
Message-ID: <20261117185737.3758255-3-luiz.dentz@gmail.com>
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

