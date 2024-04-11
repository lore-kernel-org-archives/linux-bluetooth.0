Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815B205E11
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865795; cv=none; b=i4hQF+x1A4rbf303vSd2UHRjAOfUfi2uGgfMCkhC3SEoccWgT85u2msP77iR+Ng4yDDDM4A7W2v+vauSh3LjIAyE+2ZK0YOnPh4c3XRFO8oK6FWO7nT3YFPoNKVNBO1dD+E4BfyF4q+jX88FfXfP9P3jX/uVDdlRM8RwsPQt4RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865795; c=relaxed/simple;
	bh=dtAPDI39QCjupB+FxpLOoqWcJaGUTH+LY0xeHsBvIv4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/0CmV/FIm94eWVA8RFHhIYTpFQdl1+DR84Dr/rYFGKEEgeir6taQvdBPLHmckK+otdo+MieAxpITJYxAyQGpXV79Tch+RQZ1hVuw6POzy56pUGIMRUnHo6uivQJ0LiHzlPawU20f9eAj2yqYoyS9MR/6LmpIXmyJXgPR0LdKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhrkjGBO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhrkjGBO"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb5511088aso169373a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712865792; x=1713470592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fuv8XoZVaViKeL+r9IEV453m08ChD5Kn+dw5wsZl58=;
        b=dhrkjGBOsEUTaAJOiPI2iStczpsX/wvH28OUDuqVVvrjSOmTRY4cezdMrAxqIEqiF2
         SEInJthUxggSA+fJwlvqM6QDvDMHY6sIW6u8OxsAkT+GpkIxPhciRIV28TvNU/n8UMEF
         5D/+d+RLbOcjE70HtL73bgURmD26VaMl3y/7zCABORCpHsH/AAITJa7G5Wx+dpY13vVv
         GU9rwKnbuHQsdK7oRX8O81MXO++b1fNckbMFJbkvlAyw8z3I94IYPqJ+ml/IyLkc5IbC
         Py8JDyc4LpS3j2vjNqjk3fW5gi90DuA4bSimWkeSOiVE0wtNx7SbsZI94cnRa313uiWv
         v1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712865792; x=1713470592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fuv8XoZVaViKeL+r9IEV453m08ChD5Kn+dw5wsZl58=;
        b=coyWZ0irSLMolNR5bLWh0jhLynRDeRD4WdeVjfkPYGLHB8qM81HHOIp2y4LXhlHmbj
         Ly9trawUZB0362zpJrAVV40+t6R4MfbDQYp5XUgx3UzQiJgULCUlC/fSAe2vhjEQfR1y
         6hzHh3K5JjvSMzBSc/W5hdCy+lCHu/W+YEdxYGKqw+Nn1dAuK/WWY4IuFSBsWdTPKRdq
         fwiudrHehojM6HhgUav/+/JdNaLRJVXVUnW7Qs7V4yDp3g5UP+ANi1wSxQc9TrTtzsOE
         d5SdQ6kN+/jqEDIdZ7Kdi0Doi7am1KsDWrcp2Y/AH0nCsclJhVcLjHv8KSdaq4gGS0ke
         TuPQ==
X-Gm-Message-State: AOJu0YzYG6i4dDrtyoqO7UyA4AGzUVTKkT2vzYqcKN9Xk28IzIUBBkWT
	1D6reBsU/jVRj3pRrfftrRXbtr7vVps36Xc5qCxI5KQv+h2PEi6YBlpbTQ==
X-Google-Smtp-Source: AGHT+IHw4OYdGLlqc/SVRpEEV4imaWb97N/xEaPzotTajAUs6woHRzVMUKkGV8OAebhy6ZbuW2hUKw==
X-Received: by 2002:a05:6808:212a:b0:3c3:d315:e769 with SMTP id r42-20020a056808212a00b003c3d315e769mr656028oiw.43.1712865792184;
        Thu, 11 Apr 2024 13:03:12 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id da2-20020a056130230200b007e6b31e535asm268110uab.29.2024.04.11.13.03.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 13:03:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/4] shared/bap: Fix not resuming reading attributes
Date: Thu, 11 Apr 2024 16:03:04 -0400
Message-ID: <20240411200305.183703-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411200305.183703-1-luiz.dentz@gmail.com>
References: <20240411200305.183703-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there is an unexpected disconnect and some attributes values
where left uninitialized this attempts to resume reading them once a
new session is attached.
---
 src/shared/bap.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index cc1fa1ffbe32..5fee7b4c54ca 100644
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
@@ -4715,6 +4727,48 @@ clone:
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
+		/* Resume reading supported contexts if supported */
+		if (pacs->sink && pacs->supported_context &&
+				!pacs->supported_sink_context_value &&
+				!pacs->supported_source_context_value) {
+			if (gatt_db_attribute_get_char_data(
+							pacs->supported_context,
+							NULL, &value_handle,
+							NULL, NULL, NULL)) {
+				bt_gatt_client_read_value(bap->client,
+						value_handle,
+						read_pac_supported_context,
+						bap, NULL);
+			}
+		}
+
+		/* Resume reading contexts if supported */
+		if (pacs->sink && pacs->context &&
+				!pacs->sink_context_value &&
+				!pacs->source_context_value) {
+			if (gatt_db_attribute_get_char_data(pacs->context,
+							NULL, &value_handle,
+							NULL, NULL, NULL)) {
+				bt_gatt_client_read_value(bap->client,
+							value_handle,
+							read_pac_context,
+							bap, NULL);
+			}
+		}
+
 		queue_foreach(bap->remote_eps, bap_endpoint_foreach, bap);
 
 		bap_cp_attach(bap);
-- 
2.44.0

