Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E3137926
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858853; cv=none; b=crEhlxTG1kcntwtjFLVtC73Ou+KxwmAMVu703Fivzj7imwK6tM9/p9rcgS2NINELa/FLJndNF5lM/3YsaTSJA3x245+waSDRDDSuTK32oyoQqpV1bH8IPPYnCAsaQMyAY1xxYpQVnFtWdsZFj/LVY3R4BtCGKIkoTP8z1HkA54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858853; c=relaxed/simple;
	bh=kJ4h6rOJ9cgq2Pg3uwNNmPoC9V7YFE295QXlFUvb8yc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IolufmuzfDQm4miU3EiKCuUi5CR287xiLVeVEsJ5poMhdiv9xrph4hDzt7eHyVWr5SbgxwRe1wqyP9HBKSiiudq22hbCvSoySQ9KL92+OZxxJryVcYGBo7N+QgEQIrpwU82Wzf8HFpmplP02EpxDQ/vTW2YmTuj/bxpm01q2d1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuSC0A4h; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuSC0A4h"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ea26393116so127033a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858850; x=1713463650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOI/F8iDtBdBhXssjS1UcW44VcPujPo0VyuOuDxcVF8=;
        b=TuSC0A4h9wtx1FedbMTv6YROJyHS1v1lNv+p7B9fZvWWi/V5xo3+fRMF4MomHgZVLk
         dwCE+MqUScyStbjAZU7KwSC1uw1k6a0uvz+WJdqcLmIDluRR9Akjbv7D3SaXzAB3+kV6
         qCOkC2XNgUJGUJ1HIZmuK5/UQfKrmiKgr7kVRPhdwatbHcoYrsdM4r3XWNUnBbWU0khX
         C/INhrDjc3JWZSDJhe3Y1cd3c5KqfW1lOByqwXgLF01hd87wr9pbed0UPR7ztogaCBpO
         GS26l6wSp4BA8NtFihk24GG/zVYt6Ix5XBq1bEREmM8uKD78n2cmGASV7QiDL73GVwKG
         wxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858850; x=1713463650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOI/F8iDtBdBhXssjS1UcW44VcPujPo0VyuOuDxcVF8=;
        b=E0bsVfroUlXwtnuO4xX91a6TH4C4XGGgDZ7sWPRLE9pMd2wSr7Nd07BfDrAJSUDvU8
         ZbjUNu2mN40ySzllatwIOPtDz+sE1egc9HXmn3dGEChLk804tEWiHau42fsQvssMggRJ
         NwnkU53PldJlTWkZi2WJKm6U3M1UqZUbFOp51a/0Kk1JztHl0xDxz6509vZTJW46+RGA
         nfJPJV7hbM125DP9Q9K0lqkz+krRJ/JEuSdny+jhsfvliCVMTUY5QtCSLoH4HssJKWX7
         9m/IoV0lfYiVKCbiUZmI3Xu5qIIhecuuVeD/zazbWr7FHTZwBqWnAHYq/z5WVwkAPejE
         LK8Q==
X-Gm-Message-State: AOJu0YyoUY2ioLjbzdcKRYSzeoxcFkFs969TgPJHlWaUbYuEys5lLfm0
	QFJAjhiq8DM53qz/GrmBG2Y/x/X39hY4lpFCFmyexof9KgerA/v2RwU+/w==
X-Google-Smtp-Source: AGHT+IHuHga23Mh0bnaIHLSwCO1Z5yzZXs6VvO0dZrWZ2UvEBNXRhwUuAR5QqJstylppzFJq2J5agQ==
X-Received: by 2002:a05:6808:2b0e:b0:3c3:d80c:ee5f with SMTP id fe14-20020a0568082b0e00b003c3d80cee5fmr301432oib.51.1712858850043;
        Thu, 11 Apr 2024 11:07:30 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id z4-20020ab02244000000b007e7b2f8e0b5sm225711uan.13.2024.04.11.11.07.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:07:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/3] shared/bap: Fix not resuming reading source/sink locations
Date: Thu, 11 Apr 2024 14:07:21 -0400
Message-ID: <20240411180721.157181-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411180721.157181-1-luiz.dentz@gmail.com>
References: <20240411180721.157181-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there is and unexpected disconnect and the source/sink locations
where left uninitialized this attempts to resume reading them once a
new session is attached.
---
 src/shared/bap.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index cc1fa1ffbe32..79d9345d9161 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4703,6 +4703,18 @@ clone:
 			}
 		}
 
+		/* Resume reading sink locations if supported */
+		if (pacs->sink && pacs->sink_loc && !pacs->sink_loc_value) {
+			if (gatt_db_attribute_get_char_data(pacs->sink_loc,
+							NULL, &value_handle,
+							NULL, NULL, NULL)) {
+				bt_gatt_client_read_value(bap->client,
+							value_handle,
+							read_sink_pac_loc,
+							bap, NULL);
+			}
+		}
+
 		/* Resume reading sources if supported */
 		if (pacs->source && queue_isempty(bap->rdb->sources)) {
 			if (gatt_db_attribute_get_char_data(pacs->source,
@@ -4715,6 +4727,19 @@ clone:
 			}
 		}
 
+		/* Resume reading source locations if supported */
+		if (pacs->source && pacs->source_loc &&
+				!pacs->source_loc_value) {
+			if (gatt_db_attribute_get_char_data(pacs->source_loc,
+							NULL, &value_handle,
+							NULL, NULL, NULL)) {
+				bt_gatt_client_read_value(bap->client,
+							value_handle,
+							read_source_pac_loc,
+							bap, NULL);
+			}
+		}
+
 		queue_foreach(bap->remote_eps, bap_endpoint_foreach, bap);
 
 		bap_cp_attach(bap);
-- 
2.44.0

