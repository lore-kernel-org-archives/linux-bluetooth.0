Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDCDBA3D
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740810207; cv=none; b=oZydGvbOJWuwWke+jPOrAY4Rh64dzaoBYLUOeu1Fnf2JwLGo4YWs8pLgUeg3wSaYZJsKjdnZknNsE2Atd1mb0tBGEV9r155vSWEfeHaCId4p0zwfgZUswi+JDRxaxe6/06Fe9NL9MYVQcix4qRxMAVqKw22GLLNJr2xMyPLJ6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740810207; c=relaxed/simple;
	bh=qmpzxjURd+Kxt06UvyyN1ZAfJ70uld9SRKT1m3M0NVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1buTmEo/BazHrgu8aXJXC3e4sMxh4QsMcTKnwcqKPQSjWoUBIJCMglINu6a1+b/Rcfeerwq9iMsTPWkU9WB2qU0nEBeRcV4qmNYMVsVlzmhhohVVZMNUjhypxiNoSQmJyQ0slB5VXMe+dIXWfykjPxni4PjBwtjT1wrZpFccCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXb9Gi34; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXb9Gi34"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fec3176ef3so1844427a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 22:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740810205; x=1741415005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APewLbsu5kCMMHY4PRMW6a/YnApatlD2ZVz79Jz/mG0=;
        b=iXb9Gi34Td7aa7SuOdnIKaAQiMnM+LC1h/PbJS7Hr/f1DoOEMUY6Ok/i613DNUmnkA
         x9/Nq83AVJB9iLHKmAgF3Kx+ocQ+8iSDEptOSuNOOx2SzZjfpQA070KajUNkfxLm1M+D
         vL5FGK7t6YyZ9E3p7gNCbYhMZvzHYTRgb2EjDP26f6+diDR4ODcLsvGl5qg+4HKAANj6
         J6h61r9zzCNDVcMznFmuBR7tZwvYQ4UoUhn/t/ctZV6htAGf2wf1Z+XW+xfUD3piqWY/
         iH39yM6ApnpaXgacRCctU5sNX5UW4l/U7zD3xNHThINdrCQS51AXwo4ara77cjJJeOJ2
         v/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740810205; x=1741415005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APewLbsu5kCMMHY4PRMW6a/YnApatlD2ZVz79Jz/mG0=;
        b=IZyxZ3f9a1WvKfhef9gpTeENzJGwxdRuT0iNb/vSRJ0UBxtEyKqgOR4/uZ7FlG7eQY
         m5Wj3xNQh5lGrNo6UCFLT4fo4W+R2//rzG+mNPDZr2taF3uQLoxsNGHQwcMAtozDaV8f
         55rdHEGF4aqC9eLxc8iJ5wohYSXyzB1EYnKnQzwWEfyfg5eDlkq5OXh3HPtjSDaU/Uuk
         STFHQ0ch7yfhaFEPQO6TrNBxW6Wl28uXZx7AB0Fj1Rwziy4QNoTwL8m77O4JvL2J0r0i
         sfSVUHDBTuqrbbnFTcun5u/+IXXQrmliAUI5yrF8EVGRZQom/Ocqt4GaURy2Zkoz1e9t
         nw5w==
X-Gm-Message-State: AOJu0YzYIzAFc1vwAgFI7blqun4FS2e+8EfGtzPR17kR2AX+Hveg2l8r
	J4Ohz8h9xaC6p9iqrWwT/IODQsPHOFhgtcg3aBjbMHZz0N7IzbmQRI/NQgEf
X-Gm-Gg: ASbGnct4sYIG8GuHEsnL3b9g7GqnF0SWU/Xfkc7v37+ooc3DVS4JCz8xtkcYuRbHoPO
	OBDtniAWWXXH2ALEezMS5Lcnq6HU9i8qHnNpjqNdZPsiTiNMKmZpoItUKSZJsXz8sAIpcb+8fYG
	skpaZAD1NnUsIZ5Fwwr7sNXmB8M4YzMIj3xBhXgWykjfKSrL+jgfB0yL9y0oLCMxNGiGL4omv5w
	PKN68n7rEVlsez7k9DOLh8KV3TLwUa7CEGhm3vs0ltYd4mHtaeXjPH2QNJotmj6OQHotYWt0v8f
	oDQ2QKee53Fs6gKrcZeX53kQqP0k2bkUe0GOI30sxwH3wy5XFgwCgoKYaDJ9dzq/kIUNrLLQXJW
	KoaQgmhXc4tLusqcBg3bHrQj9cvsJcg==
X-Google-Smtp-Source: AGHT+IGVzfubiLbf0r2qWwhw+SsDs92YwoeZZNQLMfKS8+8qvJHHu8TTJQXX3ZgdLnwqi0Q1V46qeA==
X-Received: by 2002:a17:90b:1b09:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2febac1093dmr10920730a91.33.1740810205091;
        Fri, 28 Feb 2025 22:23:25 -0800 (PST)
Received: from localhost.localdomain (168-228-202-55.static.sumicity.net.br. [168.228.202.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f121sm7014625a91.47.2025.02.28.22.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 22:23:24 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [PATCH V4 1/4] Bluetooth: Add quirk for broken READ_VOICE_SETTING
Date: Sat,  1 Mar 2025 03:22:58 -0300
Message-ID: <20250301062301.18029-2-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
References: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some fake controllers cannot be initialized because they return a smaller 
report than expected for READ_VOICE_SETTING.

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
---
 include/net/bluetooth/hci.h      | 8 ++++++++
 include/net/bluetooth/hci_core.h | 4 ++++
 net/bluetooth/hci_sync.c         | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0d51970d809f..6886962eca78 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -354,6 +354,14 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
+
+	/* When this quirk is set, the HCI_OP_READ_VOICE_SETTING command is
+	 * skipped. This is required for a subset of the CSR controller clones
+	 * which erroneously claim to support it.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f756fac95488..5e0534d8b1df 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1924,6 +1924,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	((dev)->commands[20] & 0x10 && \
 	 !test_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks))
 
+#define read_voice_setting_capable(dev) \
+	((dev)->commands[9] & 0x04 && \
+	 !test_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &(dev)->quirks))
+
 /* Use enhanced synchronous connection if command is supported and its quirk
  * has not been set.
  */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index dd770ef5ec36..0c6a85abba2c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3696,6 +3696,9 @@ static int hci_read_local_name_sync(struct hci_dev *hdev)
 /* Read Voice Setting */
 static int hci_read_voice_setting_sync(struct hci_dev *hdev)
 {
+	if (!read_voice_setting_capable(hdev))
+		return 0;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_VOICE_SETTING,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
-- 
2.48.1

