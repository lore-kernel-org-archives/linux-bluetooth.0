Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792875587;
	b=puzNc2AlB9xKziUEfJ5IazxWb2J5UsfvmA+guFVBqbFOGu28LasZCNbBpG3I4LK7IeCq
	 AYI/Eiv1+QrwDB4NaxQoAWAQIMU7JtxWA7Ufy0OYwCP2pvtC+G8sSkuN1mACOMJ0riwg4
	 80WhuhTQFrHaeRttMi9LtlCvyitAoeGVwE1wP4kdm09hpts/xTnLif+UGZDwFzvHgl4qW
	 MkS8cFJSAhDKw1SrY+QMigjKmVMwgS8lsQlvgbOw1r3NQm+d4gweNHww4hSBew9USrmql
	 ZZc3cRBrjwVUHQ29KOW44RiiTIgAyW6kGz1F5P0fHBORVMTOJd+JHIO/1FJfhseLMgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792875587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WzDkiyczJyz4mNLu3rtCyGgbHEPN6yDhFIklvUTjWo8=;
	b=zw+3HQ9Wd1dRWNJnQXdjYNWnVb32CA7nYC57mMAEbPyHj6IOCs8JCDv0Qzapp8RAYDwJ
	 ZehrQoVSrouf4Ld6CQhk3AzKWcsuiUTWhHCOrGXwOJJ1jfmTkKEUmDFFQ3KlsxpPTHcPc
	 WFR/hYnKrMCZBypRJ2Uh4hKFyLcFL1xlHSt9bTPYhgzHiNxDL3Eg1kCGs4bZO0a9a5R3e
	 jWR/BFDQxDo6P+Z7ySgE02yicYshl5y+97bHQ+Ookmv9JHLAjaFWguhD1bJPH0t5S8r3M
	 zqT/F0I8UU+CHS2uSzgGd2U03xb0vG8/HZPvQ/dhgUhiM5c+6jeKkcgChTIGVvBsdgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="roZ4/y44";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D24606A31B
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 20:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D24606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=roZ4/y44
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a210470b49so14328945e9.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875585; x=1793480385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WzDkiyczJyz4mNLu3rtCyGgbHEPN6yDhFIklvUTjWo8=;
        b=roZ4/y44G1EO27OnJPJ3sDl8ZFtcBwtcgPA6kkACIwOzj2BlHLGmNU2t97n8+6Uk3m
         Y1a02QfANryXw/VAZ59g0euXvFSdeNXCq1WvqYAdUTSSDVuCDGboBVCnV0sd0ujDKWW/
         p1Y2cyz3AD77dd2YoGCVfqEbOXHfz2ByWLA5eWcleHp7H9Z2tSVXprpy3tG7VzDhMoS1
         QK3c0F5TOeLSm+n2gHWxXUgkydr1HVheK4GVOIPiDtZTqSuSGMc+OnUYN9lQIpON9jzI
         gK4ei3pdbOlXG6I3CIRBhLuvqJUBukapPDgDAwJgSZbHkne9rpkgOXKg6PBogmn5+H5I
         Hh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875585; x=1793480385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzDkiyczJyz4mNLu3rtCyGgbHEPN6yDhFIklvUTjWo8=;
        b=MJSmjyt8FqSFzUQ5wA7zW3fbO8+mcWXn7EmLViir5nl9aqlCK5wAC3b/op7eX4tLws
         ywo/eZhNMU8raQ7uiOC12vrxVeGX86C1tgaiAV6h/hACwZf4d4tKyvxNLfgVNrBMl11h
         hvpa+w1O+qGBkm+VhWgwm8iFb32qUPQZxLY1pU9YGQfScPjnPyEvEk2UGbpDKbbEkP04
         3DjQjUdqx5TG3S2QMzDGi5n8gPImZgafqBMTAE+2uNs20uGSVnoKiRYODDsX1uhFVNOb
         DxWAXKXRjYmCTHnfAeK7hYlkqWHE3QyfDifncYEYFY+xhDJuFmMcowXepwGFgX3xYtej
         T+Kw==
X-Forwarded-Encrypted: i=1; AKwUvBz8hbdlJf5j353fW0qIwSNXw1LTPUYSqi91DrLCqqF4lwQ2Z7AqNFscKGthXRr507rEJ/DOtj+PcMxAaVm52Vo=@vger.kernel.org
X-Gm-Message-State: AFq9FYInBUlYdhnUbZ2lbKVHFp0lm0Xu1aIxua2bcGbNsDtuv4Nyo0DC
	91cA0YkieXKdxS0uqGwnHQKPuDvQMLIwmo/zQAYYyPKdOCVtGgfa8CM=
X-Gm-Gg: AYBFou1KBAqwLQ92mP5AYMSdRErv8ezOt1OprE0b/BsnLxXKAx1MojF7h+92uZBOWub
	2cX9PZP3sJqmjy0oUlTIIUOZZaFbGg8zDJ0uuxXdni/dI+b6oxLoN7DhdEfG7RaxE9xTlFXRWop
	sI8x7qaa3TjmyKMSC20AhM38pYjCnWqSRRqeQOa/VQF70fyLQVJC42TWGkJW/pGh1Ef6MnIlJWb
	51q6vrMYnjfV74LjAAohSnvt7DwFMf4znUaw1RjHHn50nKq3xnkAxdQG/owxEColJGdExSM6Vnw
	IyXu+7utsf/pmrA/1teKki9VWa5q3f6E0Avm9wknkv/3ozW33loNZNwL2zf3iniZ8IPdsPX8DmB
	ARwCAA+gv51bf76JGrJyNVHuR+H2Vv+JECtSE2xBC7pDINNN+7yB4s2qXI62yqL4u9JqimnvLDR
	sk3fp0CN2mPyLJaTykThl/JQUv9RKpzSG91Bf/MN6DilnO7oQ/jGaOA1oiUWry+D+IN61ZXk416
	kWMAozD92M2XfnkqN4YHeSl
X-Received: by 2002:a05:600c:8183:b0:4a1:cef3:fb3a with SMTP id 5b1f17b1804b1-4a35ac99b77mr40539715e9.9.1792875585215;
        Sat, 24 Oct 2026 13:59:45 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fc1207sm60326925e9.1.2026.10.24.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:59:43 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Seema Sreemantha <seema.sreemantha@intel.com>,
	Kiran K <kiran.k@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH bluetooth] Bluetooth: btintel: validate PPAG table element types
Date: Sat, 24 Oct 2026 20:59:42 +0000
Message-ID: <20261024205942.4056250-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

btintel_set_ppag() validates that the top-level ACPI PPAG object is a
package, but does not check that the inner PPAG table at element[1] is
itself a package with integer elements. If firmware returns a
non-package type in that position, the code interprets an unrelated
union member as package.elements, dereferencing a meaningless pointer.

Add type validation for the inner package and its integer elements
before reading the domain and mode values.

Fixes: c585a92b2f9c ("Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/bluetooth/btintel.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index c69a5d226e882..aeaf80e03f8ad 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2637,6 +2637,19 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	/* PPAG table is located at element[1] */
 	p = &elements[1];
 
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count < 2) {
+		bt_dev_warn(hdev, "PPAG-BT: Invalid PPAG table format");
+		kfree(buffer.pointer);
+		return;
+	}
+
+	if (p->package.elements[0].type != ACPI_TYPE_INTEGER ||
+	    p->package.elements[1].type != ACPI_TYPE_INTEGER) {
+		bt_dev_warn(hdev, "PPAG-BT: Invalid element types in PPAG table");
+		kfree(buffer.pointer);
+		return;
+	}
+
 	domain = (u32)p->package.elements[0].integer.value;
 	mode = (u32)p->package.elements[1].integer.value;
 	kfree(buffer.pointer);
-- 
2.47.3

