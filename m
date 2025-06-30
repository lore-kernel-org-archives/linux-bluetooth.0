Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC879D2
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312381; cv=none; b=CtGERtuDHeQzCJcL38UPLcGNArNj+dRRjwnfFCAZW2MBwBQ9GhlIt5oLqQxptw0jTHRL//rf5C7rQ3ANAbXSQv5fWBXl/zpdArlYdHfr4hDEgxIN1Mxa+ZeLM8VTbxnSBr3gr57tKulTHvGhxF/uPLP208gmJC93ufk4HApiDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312381; c=relaxed/simple;
	bh=y1ebhXQshilV4Q3ycoOro05ND0OGgLvp9P/TKKZTrFc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LAL5G81Ui/wz9ZU3drO/HqCIIozy4JWjFNoxuAjA1x8KO43QKzB4R6w+BnQS+KuAHEEGdPCmuytQoT2wM/1oE1GLKNuz1D0XbvVQFvH0dD57N9sTdHU+3lGGY3gTXS7DLSdWfz8RuFl9AE6lqwsUPJL7p/3/1hZZn/mUOM98nDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvwuJwAK; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvwuJwAK"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5315acf37b6so866820e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751312377; x=1751917177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGadUCVwNNT8WE0o5GTKQ9Wt3rpRzQNy0qwMnAN7g8U=;
        b=IvwuJwAK0qv5sygRUIaX94H74i/XzBd2tprTPcERNPqxGDXAzKl53WROvSUOOEeRkk
         odjfvst/u82cxjjhbpw2muiJAerfXb1oWWOvErsiAx70M4QR4UuCcm4Zd1rnRNq4eurV
         CJKCmC7blKWu7lfU09/15lwGgCz7O6jS2pv3953TWJU1ckop6sRv5lCOIakPsQKbJiFH
         VGXe90KhPgI9m8Wzj8J26Vm5yC2dQpcK4GaiEaj857RtOMsucKWF4Jg8IObDEG0KwclT
         +Rx7o3FbZtjb1gGWhu6WeyNTctDktgfCctQDV5vo/ZFoAN7yibM1uhMe3cul8apJoeDA
         I8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751312377; x=1751917177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGadUCVwNNT8WE0o5GTKQ9Wt3rpRzQNy0qwMnAN7g8U=;
        b=JmHNM2wHl1rWbYkr8mfmGz9H1QUneMmDBjmNqhZL4bl+4lefewcGbZxO2QHmeCZ+Rm
         dwwS/Vl8I7SGiCgDvSNkGeCArbEzmvcSS8XkfsvenMz+yr+AWySRnv/laI4p1tQxo5CD
         UGjE67jkHsXE59ZgfSHAG9SW0nSSPnm03jjrFLCOwDs2fiOfcTuxLMDjVWyIUhdtZ0fG
         IYWrf4AC/m8e7wUQ+krYoGVdGbo+w/OCBrcVyFEccF1eo2sazfCXNbwfUu2+ZNWCyJgF
         FQG1R7lGmzSq0Rb++PeosSJWEhZlHFVLAnv4Y4LWPHH97RUHg579CbNwTLGWz+DvwISu
         nIZg==
X-Gm-Message-State: AOJu0YxUwJn1eU1WZ3G+ebjW0uPNiZBBQ8smUbtAf5ln5ZyD3nM8qdQp
	dyvfNi7QfxFfHz2NDkmMSaB3qW+cKIzvnGMNrgRi6A9lL3c7CCu/22XWXfnn/Ei4znc=
X-Gm-Gg: ASbGncttoA3PW1BPmDap/8PWRMI9JIoUdhguoNAh6beOEtCw73gzof0alyMy5HpmaZg
	06XsXwtdjKs+3tpHPr0pqY3ChbOkOEsiVQ9oYUZFWbibLK7F+ORUi23bnjaimpgyqysfa9vSEAc
	0FAA82WkKg6EYz+ZIC9KP+ZYd7nfV40/9jPLVEDHPbrnmuRrZimkQAM0zseApGvXvNRMb1+E/24
	moDlegwEZNSc6ndQNYh9g7Zxy/1Hp8M+ftKPLkCaeC52oVs8TgUzghaoj05mnKzIqgcxkSmbONz
	v455lBNbaCRmgXoewjIjk4hAS1aXUR0efJIMFiUMozyVQwQeHy9l7Lx1C59QSuM85gxOmpzzq23
	+V1zjdBTdQb9ZqbcbxLII46uhoHC0J0U=
X-Google-Smtp-Source: AGHT+IH5hL4CVHoR6EoOFAh1ntxSRkMmyD64mi12ftpCX/t6D7HCWbhL8GSpq4LuJ7TsXPNb9zswEw==
X-Received: by 2002:a05:6122:3712:b0:530:81ac:51be with SMTP id 71dfb90a1353d-5330c066a58mr8655562e0c.8.1751312376690;
        Mon, 30 Jun 2025 12:39:36 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5330909c2e2sm1469380e0c.11.2025.06.30.12.39.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:39:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Remove check of BDADDR_ANY in hci_conn_hash_lookup_big_state
Date: Mon, 30 Jun 2025 15:39:34 -0400
Message-ID: <20250630193934.987691-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The check for destination to be BDADDR_ANY is no longer necessary with
the introduction of BIS_LINK.

Fixes: 23205562ffc8 ("Bluetooth: separate CIS_LINK and BIS_LINK link types")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b47c74080b9e..4342faf43484 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1350,8 +1350,7 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != BIS_LINK || bacmp(&c->dst, BDADDR_ANY) ||
-		    c->state != state)
+		if (c->type != BIS_LINK || c->state != state)
 			continue;
 
 		if (handle == c->iso_qos.bcast.big) {
-- 
2.49.0

