Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60D8562A
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694447; cv=none; b=O7VAziXR4kn96WoYrtm5SdvNFFdFLWxp3C8AF8wTJZjYUoyL1SMah1QVKPb/4UhfJVe6tvh+voV6YYQl7di4/tn23uo7V5vcmlv99bmrs7IvEN96VrpfE8tTg7sEgsrk8yncpe3oO+VBLnRPVjjhWxD/p96VldSY1O9Bou+GwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694447; c=relaxed/simple;
	bh=9aJoy5YWJ+2dlXqHyIFDhuX6VFc2cSpxJgETMwfMlRQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eucrLTT/KLkdmSnZvTn9OOA1IUVNcojxZB1yuoeWeA8IZXUMW/tHSA01i7Zz6uQ5wnF9ZAIKY9sDsKyPl9FIJ9cQSHdTLky2fLc30l0gUqb+QuFZTeuuWu4yhMU4E5OCV7T8oirilxbT06VtA6PXI0q5nSbVgIJBKvEXN1TBK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz7XZZdY; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz7XZZdY"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4daa1be011dso1776562e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 13:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712694444; x=1713299244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl+SppwAKGBp8KZCd6/T4Y1i/PcNDdL3WeE9JQ5bmM0=;
        b=Dz7XZZdYAl8vipvTGJZRIvvub+e51SGzXvoQo5DJ7al2+5P1OrZiXMIZoOHb7XCmuW
         70d1bmuczZFaHDsfWez0ENgARuTzNkKRCHCBoKqL0lnQ2j8p/F6VefE6fAY87Nv9HIs+
         qmkYZDTzPz6UIogH7VcwIbZfHVSyU9p74+x+3k5NlTULm7LNBNT2eGve7VAFBHzLtcfi
         wlZWS97aUeIo8zkC2UMB4sFzR96VC1BZpUVHac3boerZ4IgNYDei5+uLDHhiNnvA/HfL
         7E9Q0SuPzBPogPibILzX89tSmoyXU4iw5ylII2kMoHiRlHnk8uTtYahayCegCulVyCgv
         DhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694444; x=1713299244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl+SppwAKGBp8KZCd6/T4Y1i/PcNDdL3WeE9JQ5bmM0=;
        b=OYcW1SaQ3BttDcydY8LHCFbfuF28SbSkPkm//A+ZsjujxYK2A0VsBsgvmViXOX7M+g
         echs2YB0cN9qmzrzwtQUj+6ei/QhrH4k2tERkTTZluOklnjrujDPN5nHpWTJZm+TK9Cx
         JZavT3bD8qRL5KADhkwMn5P/Fs7cRjgQnlFkaK9a1ZCHCixVuRQJpzkQTWvMa8X96eiK
         /eO9MFuc5vQSYait6gcZcN0kPgHotV0zP8xc3Hg91Rh1LclIJaizDGWVix4++gjj3GB7
         VAfb/JuxLxyHGwt2/0Ynyud5s+cALzo+0TEQSi1nQ2bF5a8lWWQ94vOn9w1pN/JGkJrP
         RxOQ==
X-Gm-Message-State: AOJu0YzkPSBdOGSP+x7Nka/VST91ixfV5AVSJMbLDC3jpt3eQw3zzR+t
	/YvG4/LErkfgkyP6egV0QW3BLHF3/f059H15LJkYJPkBh+6165VJ5RavceAZ
X-Google-Smtp-Source: AGHT+IGPQHRJXl/4cKI9sSsNGbE4o0QeA+aK6U9MZfHHn7I9s+LeaadZSaJYsfnJOKXKu0s3thprTw==
X-Received: by 2002:a05:6122:50c:b0:4d3:35ac:3553 with SMTP id x12-20020a056122050c00b004d335ac3553mr1059943vko.10.1712694443999;
        Tue, 09 Apr 2024 13:27:23 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id s184-20020a1ff4c1000000b004d42135c509sm1435323vkh.5.2024.04.09.13.27.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 13:27:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] hog-lib: Make use of bt_uhid_replay
Date: Tue,  9 Apr 2024 16:27:18 -0400
Message-ID: <20240409202720.3894858-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409202720.3894858-1-luiz.dentz@gmail.com>
References: <20240409202720.3894858-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_uhid_replay to replay the GET/SET_REPORT messages
recorded during the first time the device is created.
---
 profiles/input/hog-lib.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 8071e1364b10..0291adb6eb23 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -856,12 +856,14 @@ static void set_report(struct uhid_event *ev, void *user_data)
 		--size;
 	}
 
+	if (hog->attrib == NULL) {
+		err = -ENOTCONN;
+		goto fail;
+	}
+
 	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
 				report->id, report->value_handle);
 
-	if (hog->attrib == NULL)
-		return;
-
 	hog->setrep_att = gatt_write_char(hog->attrib,
 						report->value_handle,
 						data, size, set_report_cb,
@@ -1726,6 +1728,11 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 				"handle 0x%04x", r->value_handle);
 	}
 
+	/* Attempt to replay get/set report messages since the driver might not
+	 * be aware the device has been disconnected in the meantime.
+	 */
+	bt_uhid_replay(hog->uhid);
+
 	return true;
 }
 
-- 
2.44.0

