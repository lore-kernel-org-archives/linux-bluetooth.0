Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FD3FD970
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170385; cv=none; b=UlGp5q4bzik5fmTjoD0TTolHcYR1JbRWDnO2uRuTzzd06h7FcuETkRXO8JtJGPlVG8sQdYEkCqBM9esVDd2pCRl5c/GyJijHd+Cgvqf0Tc4YzrHNkF5HOOBlJ370pg8B9YT9bTODx2/mKvVCxz76md5kptU6CU6spy8nJjZONkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170385; c=relaxed/simple;
	bh=MzFCtlg7NQAurQZpo0kH6aO7FER+9XzqIwyG0ItL1QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6tNz1HtaTPf17ZyWOTsYJfkBCVN+pvrjjGNEQefPIWMahMaUmD/GpHmd9y7iuvjFVB4PK3KJpWAERiU6cMY48xkIHA5IT84A88LS7rTPVMPVWJQGsAzOFKtF3NGzLiAHU2dfWdgaMP2NNheJUqT97TI+Cpim6d79HOXO9cwLtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmnRR0cR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmnRR0cR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d6f55a7089so33316115ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788170383; x=1788775183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JWug8GNdY5MzAA3B+UQMoRVhKpGdZFi0ogypUl1fSBQ=;
        b=FmnRR0cRIex16fT5cQKbPdU+e1z3okzFfXGz+VYIIRfRqQmYqqt4MmFXPatjZx880Y
         kbWYUzSLVo0iH19Uty/972VyppFc6pvepefxo5unQqJnc9T3qVpgPWzfeVhqibAo4lqN
         FKdz+4I40CFyo/5kZCtkq9vogCd4aIFsHUadfglH7qD5gv6XXHFFSQO3gfDs0eT1B2UO
         ZCjAo2H267R14AFB6Bv0cr0WkPxrkgdu6U7zAinobXv+LKBxOwooIhM5PY/TWwVYqLDq
         xNg43j8BE02QtqQqYFV+ZL63Wr/B2V8iBxLtWMoXtgRMj8dk+/5gWzBJKaOquj228/T3
         F2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170383; x=1788775183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JWug8GNdY5MzAA3B+UQMoRVhKpGdZFi0ogypUl1fSBQ=;
        b=Um7L0OX1qHabnbyTai8SVer8I1UXyXeCvMZ4+djEYL84eUKghkcPUpKN5RbM4m8nZr
         8dQidNv0UtWpQLBleLy8pBhoJBjWY4AHhnPdwgyed8ZBsy0d1DGSW5KOlrqkvZ7jU81K
         m9WYosL9fZTwqfAO6DFTKUyX1Af/6Zm4JoDHQ9to08tT7Cd303jt1FXe1O6I0gYOGFAB
         8zI5Boss7sWvQQm2fmj23Xq5FoGFOZzb245X2PIephMtAbZUZZ7Fv4LiCBZ2dFaxA5Zc
         OtPjr3HVj0rpjfOjaucZYb3IhtJ/ntKpFtptvUx7uczMW4fM4z7v+yCK0XoFajV6wO0o
         6U+g==
X-Gm-Message-State: AFuF++nzrdWKTyWTuqFhTdQ+moDFEOMS++5xi8N8HhzJYn3gxr211mKY
	z1kbCrtC3rVNQ+cfvCpmm7lre/m3r0wPfcBLHj9IJaIzSR/CSeAvrYc4wNjVeevZsRM=
X-Gm-Gg: AYBFou2sw1o1qy6akVxYtzfQYqxjBO9Y4ThTzOjJPmfq6WFyIcNizZPnkLrbG90Wk9t
	h2BkC/6uJ/+P3pKaoUpnZubMNZG4p1SUvafRgcvdi35DgnMNf+1wISGoJ3atr1PQHUKuSEqlHWG
	vnw2q3xP/6nGvrztdarqmd+zbSk8f3FKOuaEbvEHcca3AGbYVE0XnnOvXnvPf6ywcjLU6+HZgTx
	3Q3xKEHU5hzecmef5jdqTZlufv8QEieK6hVYtaHF/h8Db8JnApzzWTC+8hZNSYZ47039K81FvPi
	O4mKFkJSBhB1hW5UpUrmVUFkFokChQpAd0xzwSc4/ddO9guVrWGuyWbrxzpsJZaWsN7r8YE66bD
	F1hTtAgbTWbYErvdSfG922Snb525D8BbF/ToXzDV4ir/8/w3ufZM7II0xRb/xdKRSeu7vvdwrya
	MOuJSmfqGTEfSbad1EFPe7KeEJLNgTgDny6FZHDoASQTk1TmQP1Nu4twYQzx96hd2yFT9633uRE
	cr4ccTn4HYRSksJWaemjaKPNrcjwW/oz404HXrInWMqCyz7ykr45TnURTeevPCKKjVKfzURQtYU
	x5rFPPilEG4YvesZbqivBbmOhblKU7y9CLlNksc/Pw0IyBsJ+7pleqfJi/jnlRu01DI5MjbFz/z
	kezlw719xSSGzVTZkYoFnkvccfP3a/p7xidmDD4J0UXPZaM8OWXoZ9N0Qdg==
X-Received: by 2002:a17:902:e804:b0:2ce:9c48:22d3 with SMTP id d9443c01a7336-2d74df05f9cmr355235905ad.11.1788170383473;
        Mon, 31 Aug 2026 02:59:43 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759640becsm32270775ad.36.2026.08.31.02.59.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 02:59:43 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	ali@iusegentoo.com,
	kiraank@gmail.com,
	kiran.k@intel.com,
	ravishankar.srivatsa@intel.com,
	amit.k.bag@intel.com,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Subject: [PATCH v3 2/3] Bluetooth: btintel: bound firmware ID by TLV length
Date: Mon, 31 Aug 2026 15:44:22 +0545
Message-ID: <20260831095923.18830-3-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260831095923.18830-1-acharyalaxman8848@gmail.com>
References: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
 <20260831095923.18830-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware ID is treated as a NUL-terminated string even though the
TLV length is its only boundary. If the value does not contain a NUL
terminator, snprintf() can read beyond the received response.

Limit the conversion to the advertised TLV value length.

Fixes: 164c62f958f8 ("Bluetooth: btintel: Add firmware ID to firmware name")
Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 998c99b17..887170534 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -704,7 +704,7 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
 			break;
 		case INTEL_TLV_FW_ID:
 			snprintf(version->fw_id, sizeof(version->fw_id),
-				 "%s", tlv->val);
+				 "%.*s", tlv->len, tlv->val);
 			break;
 		default:
 			/* Ignore rest of information */
-- 
2.51.2

