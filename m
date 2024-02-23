Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6013A264
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709905; cv=none; b=H+Yw+BzcgAqdN3VlLG8uQ0fWoelVy1KgEEau8qDg3bvhU56cMFDlOCOxCp2yAtfxxiP2/TsJFwNv74Rw1jqjSIQqWwai2dz+BBiMUZeUGHBWDdLjygHeJzj/gsBxYl3+a//4/ioDuuPnvcwdIgkt/g7ufhCtiXc0aJO9G3Oq1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709905; c=relaxed/simple;
	bh=kyUH7Mqf080WPWqFOMDN5l9SUa0vrwEfiyuCYRcy07E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mwUJKuAJ3M78qvTt/eVqkolmlmIHnVN8sIbJmxCyjhSe4hOPV7kZJ3hr8KuqREo2Pq2845xB9Ul73DQ+yNemwOcfN/DsfNmizXYDImf7GVR0LvAmWXtItRkALRka9z2D1YrjHW9rnSK9v/P+picxmWCKNFxGiyzL82qCcmT6hgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPYK72Pk; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPYK72Pk"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-470646192b6so85141137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 09:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708709901; x=1709314701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3y4C+5bS7QyJOy/gmK5i4+I/ZRvWBjtUwEUpl15Fdro=;
        b=RPYK72PkG5UXU8sJeoyIFLs7L5IU10EnQEZy5/3UDcpc0C21JmDVhTYe7UfaAL5vgx
         dLeVnKeTbB3OFuUpCC1SLUh1IrgGYD2nd6ZDVZZxRc1XvVWUjMopKMNrTJQxhxIYzc9+
         P95P17aoFkyckL2vsbdbrGaeAf6aq38OKUw9gUfmIgjWdedrLSLoT78KWilUcS061L8C
         QKXmkACAxCwJ1giR+2TWlRxvwXGmKWv/8eP3C3NjreICYZjcON4kxIUsg4mKpDuKkDoW
         1J+WPgCQ+SGEVchgvQ8LrOf93rQmRmv6yUZbP6KespKtcEHslupqWXrDJBy0kv4scJs0
         /bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709901; x=1709314701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3y4C+5bS7QyJOy/gmK5i4+I/ZRvWBjtUwEUpl15Fdro=;
        b=DbkmoQjMcza8P0Jfy+h5kyrsg2Y6mTPI8HmKgfA/CrbivyZALPIv/H5CE1ZIqT+Bwn
         prgvauymEd9zYfsEqVe46D6/J/2cB+6Ra7Uq/gFEVvHeqd5iezOZVcakLkcaqiZplpEW
         gXxFOW0xIcpJOTwNM1objur4/3AWqQ+87tTN7btYeFCh8esQMR/mOvIAd0B5k/dIJbTr
         jJsyj0iO0xNczetLsdmI4W3/I81yPehXGbwlX9LnyXcnCX+9OGDifjNtWyV4E0GKjWkQ
         ZXqWBa/RZx/PboCLoIlgw/Ayx64/WkMqNF6lwy2ewbiOhA02YM+PU5vvNGCEaTve9TJg
         c4rg==
X-Gm-Message-State: AOJu0YxJZifJ9CbUaFwb7A6vGbb7rgbVEp0rxNhj+kXPjW/BmLFT/WSj
	DWDFR4mmV5byk1TfRSBUp/gHLpfMtkDp6/7y6ufQdINlP2SwcRhu3R9WiQnT
X-Google-Smtp-Source: AGHT+IFscGTINL3c/Fuv/0oPLBFD55s9Mgl4G7/JDuS2oW0tbIjlpF4QpoEn34xLlmD2pcp/qcS9YA==
X-Received: by 2002:a05:6102:c03:b0:470:54fa:b366 with SMTP id x3-20020a0561020c0300b0047054fab366mr833853vss.16.1708709901362;
        Fri, 23 Feb 2024 09:38:21 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ca4-20020a0561300b0400b007d67af483d9sm2476353uab.35.2024.02.23.09.38.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:38:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btintel: Fixe build regression
Date: Fri, 23 Feb 2024 12:38:18 -0500
Message-ID: <20240223173819.973508-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following build regression:

drivers-bluetooth-btintel.c-btintel_read_version()-warn:
passing-zero-to-PTR_ERR

Fixes: 36618e0d5a6d ("Bluetooth: btintel: Fix null ptr deref in btintel_read_version")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a083c4b8621c..6ba7f5d1b837 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -435,13 +435,13 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR_OR_NULL(skb)) {
+	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
 
-	if (skb->len != sizeof(*ver)) {
+	if (!skb || skb->len != sizeof(*ver)) {
 		bt_dev_err(hdev, "Intel version event size mismatch");
 		kfree_skb(skb);
 		return -EILSEQ;
-- 
2.43.0

