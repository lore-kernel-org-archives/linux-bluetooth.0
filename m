Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57493B8127
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352821; cv=none; b=hAR9U18UCA+pTOeziJx2jmBCjk8aISZ3nVuqeeIUmnWqcgAFBd6BDjI9301P6xxoTSmSwvxS/IPIy7rMCGucKkWZykmywgq+m3wTQb68zz0Rh5GvlQaDqmkAW768NFHpL+PeE51Y7yJUsOWJMVADYez1jWI4f4CUM8ETD+wUJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352821; c=relaxed/simple;
	bh=Jc8MnfFwd5t3/FqlRZlLIBmERNgEUrC18DKe9lyIFiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iM0pe7GOVjvBiqgk55BnDG0wKOxn6ybsYp4wWi8/d1RhenQG+KXsaMcbM2BiXQkw0DqnAZ8BlmSfxu3UpHSNMJ1Oh99ejUA6ZjwBl5ovAhK0/FiE1lSqL4Tg/OeB+J+G9+Tu7OEmzQejnS2aKbKuP6lzOpUU+LPUuxYtJhhg3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMYNggWx; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMYNggWx"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-75637679fc7so220212137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352814; x=1785957614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XBxHApPl23SxP8wsYoVeXSufJTzScMb8ZvIH2bZgw7s=;
        b=HMYNggWxERD/rckc/65JLiUsIxKQiyZ+6MlN6tYP6YhBgqhiDRNjYESd1EBPhF0iOb
         3iYijZugerCp1aLUpu+rlhGpzbx3jiqkiusm7hAIgMX9Gn5GKBPHDGvw1otXFbkZW8V/
         PJtPZO13IgtsqDsWPK3uqEvvhUGGck3ahPpL9nUhn2H6aIDeUCVugjeeg98HcQmdzysm
         pw+voJeB5Zbj9RBJEwatzt9yHhjTHWXHrEnhMGSBpr+nxhJJGfbdXyKSVRzEKf9OewkL
         qvJB/0Zod0QBUeZ1XLelnc+WylxkA3v9Xww6HMYJ9jLWPdCJfc2knht7ApqOi2ib2chz
         XMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352814; x=1785957614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XBxHApPl23SxP8wsYoVeXSufJTzScMb8ZvIH2bZgw7s=;
        b=DdgxVkFYylQxIvWcu1xy56+/c2lbs5ZpsLKDD0qY6W3XfKkq0hA6RRw5bc3k8GZaiZ
         xn5WofQG9i4MA0Wqdl3B+9ZqTL0V8Kn0145QswT33mnEi7HsPuFaN9keog4JOZKpr2IH
         HA/4dU8pyDGDHHru/a/7kq05OfS5vD9amSpifNzO2FLxwikokFHaEPM0x9TliwjctMbl
         kw/Z1lI3U2DCDCh231qkctF0gAj1HURi/HeJFDEesIMw4xzEEOgFdCMfE9inJRo2AcT0
         /RhkuSSVO945Px538PuJA+Iaw7+NDH38aFBVys/TPIU2Pi2W4AKjn8cfmbOHbS8ArW0R
         Dotw==
X-Gm-Message-State: AOJu0YyP49Ua6ghSMA84Ax/XiI7tx0pGA/wDOqDNGoqOmd0K6HSi4Kf6
	HbC1vEdBNjtd53ue6jDf83slBjfzaqiKHMQqdJ3Oofp50h55EY7F1uHiS2WWouo4
X-Gm-Gg: AR+sD121Sueul4F5zzgd44ugIE7Ky9aXA9xAeQvwYQub82LYALSULqcb/4kvjKTSssH
	FLcoWewqVLLE9RRzAeu+WfcxhWlGm+/FyN9Kj6ANxQyJMl0aBnRKxmL1SsP0ieUnUUlqdUgJVmm
	7QIYPlTwr3QtP/GK74sO0Nz9+EJNGzqwqAHCu8hKlwOxAb8TEEdkkmJLEgJTGkHK5ffWKgtIorz
	WIeG+qV1rkOruguzQ8+jFi7t1rDJSd3FkLu0CdieRRx8faN0k2eDZWyt3jEE05CqQjM3WpsAJjP
	8o7Ksjl+7aWxSYiFUgNgZyVRf6ynvbet+Yh4sJFm53RgVLZfUlHAXZD61KwKi2SIR4m6g2SdjoF
	GziUeBJuuY7QDcTHNLoenXFBesIIwTWq+ty0oOePjb6iJC2ogIbTyFFV0JsmhgMOevtEgu11Eju
	xeDRMmf1/rKZc7AhYEBx4KZmuBX7JjV2xyeWoTb191U0QMf5a3ZXvPN13FPOpmzQ26EoOt0jbhw
	3YGZlHsHZ+wa46pZBmg2RInONWYbFoSd1BGylLThEvJ/QnQnd/o/Pi09tZSETB2HM342bE=
X-Received: by 2002:a05:6102:3a0f:b0:74c:7dbd:8c89 with SMTP id ada2fe7eead31-754a2bc0982mr3515566137.25.1785352814435;
        Wed, 29 Jul 2026 12:20:14 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-755a95889b0sm2106844137.8.2026.07.29.12.20.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:20:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/3] Bluetooth: Add MGMT Shorter Connection Interval setting
Date: Wed, 29 Jul 2026 15:20:01 -0400
Message-ID: <20260729192002.2636087-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729192002.2636087-1-luiz.dentz@gmail.com>
References: <20260729192002.2636087-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add MGMT_SETTING_SCI (bit 25) to advertise support for the Shorter
Connection Interval (SCI) feature. It is reported in the supported
settings whenever the controller is SCI capable, and in the current
settings whenever LE is enabled and the controller is SCI capable
(SCI has no separate enable command, so it is a passive capability).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 ++
 include/net/bluetooth/mgmt.h     | 1 +
 net/bluetooth/mgmt.c             | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3da86ca4fe5e..d1f37097925d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2085,6 +2085,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 #define le_sci_capable(dev) \
 	((dev)->le_features[9] & HCI_LE_SCI)
+#define le_sci_enabled(dev) \
+	(le_enabled(dev) && le_sci_capable(dev))
 
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 08daed7a96d5..b285441db55b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -118,6 +118,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_LL_PRIVACY		BIT(22)
 #define MGMT_SETTING_PAST_SENDER	BIT(23)
 #define MGMT_SETTING_PAST_RECEIVER	BIT(24)
+#define MGMT_SETTING_SCI		BIT(25)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4fd37ac79986..58f01fbfcf71 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -861,6 +861,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (past_receiver_capable(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_capable(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -952,6 +955,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (past_receiver_enabled(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_enabled(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	return settings;
 }
 
-- 
2.54.0

