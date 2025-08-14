Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4E221D3CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188702; cv=none; b=VD2cC2ommLQQxWEZ9uYMaN5QqPK4pLYd20xn9HGpNKBPL4w8uZy1c0kbM2o5iwrYh8+xuN4fe2UyLL2/VzlVuIShAcSX8szvpw27fDrgiM3QPhR7ClL5f8hGbybG6AqEqXmkPOZ4ecpPb8Yfj9XWCN3YmMRAMQTXzwO4e7iO75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188702; c=relaxed/simple;
	bh=AfjMKMR7GUIFA5bMtjh1ZcoJpcZWOwcXe/fY+6syUsM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A8azzBsSnxL+RMFLIN5sVIdeE3Hw8qnc8CnFdxuHYK5YtQBfZATKzywo6KIDUnGwCgKzW/uw/4pKtczU/v+0v71Q0EHjfZVHVLsLTZCMC6P0o2hpOdCmk5mWG+xoas0iUoU88Y5vWlhkIBTyTdEkNlviCCHyDzkKucv62eyS9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI186iqH; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI186iqH"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-50f88ed81c8so739787137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 09:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755188698; x=1755793498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4dNRiTGWmU18H5p9GnEBdec672Nm+/VldnwzLsOiWlY=;
        b=lI186iqHWdpvr+BzB3WRiVenkel45OHhBEYIFC+u94GcHNjurkpgV4w+Xc/K/Ww+4a
         PADlp+kCnolXRbYaby0azUF2xJEAJV4fw1tykOEPV1O5tKYQGte9WfoZH/sPI/hhUkpy
         qdVeg84PZqj7KelI9jj+NC+t3SXgSXRrk8188kdwUT1xOacy1nS//5UtlwO4LAmfpzvv
         gLMTHsisA4x0rP0BnsVxh0CoFlqLBWf8x0jC/AnBqu3HsWTH7t3de+Qu2o9MaVy9nmvn
         ZZaYrSVFL/BDj+ox0l5zGdEKwgsiIes1GOWuNdCdxpDQsgAqJM68OzjzCXLcyTg2aB1H
         96jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188698; x=1755793498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dNRiTGWmU18H5p9GnEBdec672Nm+/VldnwzLsOiWlY=;
        b=dVrG/Pp8BBGNliw0C+tU9IlNdC/4lDAja2lrecdj5zxeHBJg4ZL8UmdXWP6K83AqLu
         0k82NtfZn8M5fAprmF8x584wQC0LM9rPPgNx7Uw+SdrClEQcgOglI9r5tQZtpDudvxpR
         JXmiq4D24D7pt4LZzPi55JXMPF44vJFQh7SEdCLFq6HOtM1NQjW5VAKijZrLjlLu6FoQ
         QyUzWgcSriogbJHx+I2mfhWa+Isil27hLGjwr+CcdPZcCiZL72auiAwutx2EF/qTikQO
         wJIh0bOKax1S+uGjl1Ez7FuHApDMGNXUbHJ4VRv7UMjPVzjfOgbhla5sBGSkyEq3WQEJ
         /WDQ==
X-Gm-Message-State: AOJu0Yw3Mc+jcBRsQfrC+FVdUkJyWe9vB+w9dkGFy3iXnace3gPp8Vbv
	b6wTlbBKcxbhiKXDJYQrgD5/JY/kJt8F+ky4zw2NpQowc38awbDMtDVLSOZIwzAA
X-Gm-Gg: ASbGncuU7A1XNew9PcTleG8hAFAof+oKt8o5ZQ5JjaM8ynoOH27xms3E4R4prmZORCk
	haiYv6rXFOtjFNdZTbtDbty7RCQMD+mwivfabZ719lNEmSC8PFu7sZ5KrTBy9xiOBApp0a9qUNG
	hdfYpHiNQSUZuHSQFs4QVNE0DFiDgbqLG0DhcLSZmLG1DeCQwatjhderhQaa4YALYKVYJwHGi4f
	Hyc5CUJAjwdKKeen2PH5nx1VJvOe+w7Zr+9pJmYNVk+OdCvday24C4/QVN8fVucIzeNskw21o0x
	4JZO2tfQTl546brGlJs9/J2g8YfsNVzekMuehpU8VDQmiRsLxexgGE9hJ/qGCCPI8ePpg7OZUdb
	Np1zPrTNucHQUv06WDZmcNvuCyw5uGynAF08SImBD/Ld67uBvG8ChXamIuYyqdaDe
X-Google-Smtp-Source: AGHT+IGvwq5Lh1jihtEuir/uMLyMIVviACJlUZSNs2zuUhmI1vhqk7Ff2MRuHVRN0sfhf1E1djwwKw==
X-Received: by 2002:a05:6102:1623:b0:50b:de14:ab9 with SMTP id ada2fe7eead31-50feb502fa8mr1582849137.27.1755188698090;
        Thu, 14 Aug 2025 09:24:58 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e57924cb0sm969037241.8.2025.08.14.09.24.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:24:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/6] Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links separately
Date: Thu, 14 Aug 2025 12:24:43 -0400
Message-ID: <20250814162448.124616-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the likes of hci_conn_num(CIS_LINK) returning the total of
ISO connection which includes BIS_LINK as well, so this splits the
iso_num into each link type and introduces hci_iso_num that can be used
in places where the total number of ISO connection still needs to be
used.

Fixes: 23205562ffc8 ("Bluetooth: separate CIS_LINK and BIS_LINK link types")
Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bb30bde6f0e8..6906af7a8f24 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -129,7 +129,9 @@ struct hci_conn_hash {
 	struct list_head list;
 	unsigned int     acl_num;
 	unsigned int     sco_num;
-	unsigned int     iso_num;
+	unsigned int     cis_num;
+	unsigned int     bis_num;
+	unsigned int     pa_num;
 	unsigned int     le_num;
 	unsigned int     le_num_peripheral;
 };
@@ -1014,9 +1016,13 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 		h->sco_num++;
 		break;
 	case CIS_LINK:
+		h->cis_num++;
+		break;
 	case BIS_LINK:
+		h->bis_num++;
+		break;
 	case PA_LINK:
-		h->iso_num++;
+		h->pa_num++;
 		break;
 	}
 }
@@ -1042,9 +1048,13 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 		h->sco_num--;
 		break;
 	case CIS_LINK:
+		h->cis_num--;
+		break;
 	case BIS_LINK:
+		h->bis_num--;
+		break;
 	case PA_LINK:
-		h->iso_num--;
+		h->pa_num--;
 		break;
 	}
 }
@@ -1061,9 +1071,11 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 	case ESCO_LINK:
 		return h->sco_num;
 	case CIS_LINK:
+		return h->cis_num;
 	case BIS_LINK:
+		return h->bis_num;
 	case PA_LINK:
-		return h->iso_num;
+		return h->pa_num;
 	default:
 		return 0;
 	}
@@ -1073,7 +1085,15 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *c = &hdev->conn_hash;
 
-	return c->acl_num + c->sco_num + c->le_num + c->iso_num;
+	return c->acl_num + c->sco_num + c->le_num + c->cis_num + c->bis_num +
+		c->pa_num;
+}
+
+static inline unsigned int hci_iso_count(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *c = &hdev->conn_hash;
+
+	return c->cis_num + c->bis_num;
 }
 
 static inline bool hci_conn_valid(struct hci_dev *hdev, struct hci_conn *conn)
-- 
2.50.1

