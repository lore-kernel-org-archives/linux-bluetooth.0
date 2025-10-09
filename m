Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441262848A5
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045399; cv=none; b=f05moHQq8G86nTFzwZrIj1E4fdN9jQcp7j4CwxScThBCiI9E6vmsWoOZsCqX2wSxtaxc/sx62enakfKhzGMrjDWtyOS3XcPC/0P/FOVMAUOZNfPmIk22PUbGBI5U6nCSxuO47EdHr5vrKLnsG4/Cv+hT5FrTt5O4MjpkLGWPMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045399; c=relaxed/simple;
	bh=gxC7W9KVZif9s1dO881EF8N+RaO/MAaFUwZNIvUMUnk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbPFa6IYy2ZB63AubiSGJ6KYopZUgWbwyo3v3WIqMKrjosnGWLhI6OedWOYffgLkR2DxmeYOyi+DGR2ql/QWhZiJVhqLVKJS9adAennIR4RD8o5bC5ahTv1QVLBDMWzMEwRlYVDAY+UAYbll/QRl8QuHTjXLiJ9wULpDGq1TIZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqkf34rG; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqkf34rG"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54b21395093so1002584e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045396; x=1760650196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBo3yLChbmojTbr90wsX4fHdFqh5Q2YoXv2nMc3TwBY=;
        b=cqkf34rGd6ZsWROUKQmzyEs5pX7DVDM8q7S3/3M+SrfznlwfX2NXO/pEOn0JfBHvHC
         3Iar01mmJIQEdIamXuzbi60cA+SZGUPW5wyuIJvUZ8oH+/75hRj9HF+obhnubnb4flSs
         tvNQjXkw9r3YcTUKQZkIETIaWQcM6zcs1D0+1j2eN0Eqb0dt62qr84Z/+k3mP3Y7CgOk
         7HbfCHeZAnpkBkDWtA2NyskSISQazNqlE+3eNHPtDmqsAIfHroQQgCRAg312y9VV7LMG
         zL3T2Y5f22QntY4HNNjHIBdZYXcZExUJ5GS9Do/t0Qf9BTqCzq4FQOeSC6o+Ez0fcRVe
         Kugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045396; x=1760650196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBo3yLChbmojTbr90wsX4fHdFqh5Q2YoXv2nMc3TwBY=;
        b=dmZlHZMsVGaH3QvbYkMUjcIqfKUwggi9HRxuU13LD1t82v5NVphDoZj1ENtoWMSW3X
         EAfPyQqTApaNCwydCufPq8i1r3eaagn/gnaiWybSNEZqN1r+TM+tycCXi26aEvmOWXzJ
         I9MdEOd2VPPm0yway0VMMlV1laLTuESJPMBCzsEejtABFswccBcYo2lSgUwzP0fOB/Zt
         1Iy9hLI+SXKanCI+d/aCw8p9iojfSfiFPMidBZ1HMkvPTaF9GK8u0f15vnzFCPYtwCUv
         sjrkqFkEVspKbccqcvsnge1uwLvDMbDImLm1yEdYupVTpmfzFcMtZn4vQv0ULfdmpmn7
         9tvw==
X-Gm-Message-State: AOJu0Yyw9CFYpl8OeA+kv5vO5bOpsR5zzbLAALLBD9reZ7v+R3fJPLql
	Huiud0/28+wU6AW4ybVEOeCGyonB9e6+YOTAL5mtp7zhupV+ZTi6QghihP7RivPe
X-Gm-Gg: ASbGncureM23zFWOHE0KRrM2Badxj2xfbAi7kJSEqhWmE2YM7jeP9vil6vpvQfBQPxM
	R7EkB8eOIf7YIOnCrZY8CBf0ZhMT4hKVdmRaDWFAYcftaGKOxe/tAn0X4LPPKUY+2cAjXfWOD2I
	S05I9QZDF7hmELHaQtnL0W3CfOODPbmTUyx6Rw5IutITy7kePawIUfX1dKuIM8mAZfokVW26oUb
	9RVxElzFp/tjImBJMbryZoVu2leuZdzqbeADQNNtkeeqToenyBELqsaH/MhNUCrNx+dqdySBuRD
	28TT5l/Rp9y55xdfCAW6ulh5MBgR9gkA37gCKuDN/nTj5tQ6YDHAmKSEcKGmQacvyhzAY4HjkHw
	DlEci/r1tDy6JwIdrn99X/Ur+/1VXxK7bymKdUQghDGRY7yKDx7kEXpAf3y5KfcKK06lp2HtTMV
	l9/QaB8Isl6V4n/GSijm5QyXU2
X-Google-Smtp-Source: AGHT+IEES79pCdejHCLuunvjTroJoxQT8d/c2hCcQr8lzyBebdq40oJM/PZO7lONlY3qZA+mK7nnAw==
X-Received: by 2002:a05:6122:3296:b0:541:80ff:31a5 with SMTP id 71dfb90a1353d-554b93b1b43mr3782960e0c.3.1760045396458;
        Thu, 09 Oct 2025 14:29:56 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.29.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:29:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/13] bass: Add support for setting DEVICE_FLAG_PAST
Date: Thu,  9 Oct 2025 17:29:25 -0400
Message-ID: <20251009212931.445719-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to check if setting DEVICE_FLAG_PAST is possible based on
the MGMT settings.
---
 profiles/audio/bass.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index d42740ca4afb..537c9206a71c 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -30,6 +30,7 @@
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
 #include "bluetooth/iso.h"
+#include "bluetooth/mgmt.h"
 
 #include "src/dbus-common.h"
 #include "src/shared/util.h"
@@ -1253,8 +1254,17 @@ static void bass_data_add(struct bass_data *data)
 
 	queue_push_tail(sessions, data);
 
-	if (data->service)
+	if (data->service) {
+		struct btd_adapter *adapter = device_get_adapter(data->device);
+		bool initiator = btd_service_is_initiator(data->service);
+
 		btd_service_set_user_data(data->service, data);
+		if ((!initiator && btd_adapter_has_settings(adapter,
+				MGMT_SETTING_PAST_RECEIVER)) || (initiator &&
+				btd_adapter_has_settings(adapter,
+				MGMT_SETTING_PAST_SENDER)))
+			device_set_past_support(data->device, true);
+	}
 }
 
 static bool match_data(const void *data, const void *match_data)
-- 
2.51.0

