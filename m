Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415902;
	b=iw3QduUqhDpl/ylzDgoEcH5gqj+EFgi4PSl5pAL8+WnU1xEjcmL+K16Mku4FJeI+kv4g
	 QJngkXmaifYXyFm0iLptkHFXjKe/SwVhK2iDwfHIKc+rbydBnOjrGM5fgFwC/sA8N0AsZ
	 0RZBWFacITj155FNr0mFDBcf3X2bv5gUgUhc2jxz1nOUoK7vj3jqJnQJGohmhNzmumhTB
	 AQPugOyy+IYTtNQSJELyicH7Orekmyta2dvmEnhoWc4/zjh2DCBmjSx2595BH3ZcZrZmO
	 N8dR8wuB1gNyCAmr7kdyT765Y6YI5PMBZXigdqzOrZ+2AvFXN2WxWms1vWRN/YNspow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PMiaNymztdkT00+CUBxVMLcMZ3Kd1CYIA5PCenXY7FQ=;
	b=NrcMtW7VHsagdJXb4KKiE+PYIz2SXaMx/z3vzs/EA15tTAogJXIzriSmFanly1vI4WCe
	 1ibaSQOy+Fs9Zusbxy25332uSQYXkBCXVHWILevr8rCVM1AS8DqYEEpsxGPDTPa71Fq59
	 Aq42A3g3GHJDOt2N+zyWc/FbbK3kijcPly/1CeBNPC2D18+c0drfQRadgoJ9kn3oevunV
	 Sb03l8pycsVr9CRA3cX1xwsdfQi8uMCijSobmbH2+TYYPUd9TNu2SuarKy8vh+aipXteI
	 lZBzWSCg/rSiMi+cjSiUzhMzxUFPMPVYnFLzcDdTRsCPZKTm6kA9/1E/KcGizc9QUgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jL/XqwFx";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CD3606A88C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49CD3606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jL/XqwFx
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1749753eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415901; x=1795020701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PMiaNymztdkT00+CUBxVMLcMZ3Kd1CYIA5PCenXY7FQ=;
        b=jL/XqwFxpJBhXtP3azrAIKKpVKPwxlEd1bwcecSnbAum5emzIIGy2DDRIKlZWrlJze
         1Ra6iRUulFUFirWd9JOciGZYxE4kg9dBgPkWUZD+P53pISB1b7WnHWfvdG0qiN0VIjvo
         dfRyW0ftjgWjnxqAYxYU6aCP0DbfyE54pLpbs87DuU5RJXeC/TvU6z3p0UCUmizo51qZ
         S2j9GAKCTkygHhLUob5r/EnIbArikkDQogY7TkSZXrkVoRhrKdHQFNe0VzGFqPae2YR+
         YLM1Ztk+c4Eyn4us53pt1pKnNSXTa1Gx53axLwtAnY5upR+uIN+Oi+2tydu7Y0d6AX/x
         zg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415901; x=1795020701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PMiaNymztdkT00+CUBxVMLcMZ3Kd1CYIA5PCenXY7FQ=;
        b=OTYky7sXkqSjpUGj1HsfsjHSlxdn6LKfDIYDXf15ueSEM8lHsJKE8bt5OW1HgZ6eaJ
         cRfHlxD4C9cK8jQ3CdLOvw0mXDBJ4G3HU5Jch0UamGKIg2qNzubKxwbttdX99jEhiK8b
         nAMjWT2lXTKrh8I+JFvWDvz3XdXTawZ0lTTuh/XghsL76pG5nXj4G+uOo4+QxzwQT4ky
         3/qWXLl7fsqWTfU8rFk0/b/LUjzoFodylWlNzsBePLg1KBGkqeHNvvhoZolQUN40WAfe
         G8bHZrGKuyn5p7cu4SDV94d1PdvDBdFR82KZ4gyxcdGEBB2eJeUWUAbb3kMusityNIF+
         iYzQ==
X-Gm-Message-State: APuU4Z+pgMofGLeR6H9s5i3anJwwE7woeGcdqHccwf4LET2p4tlIdJeF
	ANJT75hC8PXADw3w4OBj8a63efSlTT05PhAyPoAJ1qq+DvviTXzHkmP/Y5SdWeVVJXY=
X-Gm-Gg: AYBFou2TdDm4P8NGtMW1WJLRV8klyl2A/l5Ol6R4NhCT8W7u2/lBVWu7fyK+uhpzAzr
	6gM0le2mTxcHtQGqQbSxyfVLdtAcfUnxapb7cx1vwfYFbEbIMRkfAkNv8wMRDhVHY8m2xbTlNpb
	cWs3Geut15kKcCrbhVgaHhai8grr2uAecOhoDp0oOya4ZSUQgOQtMsydTXpUXcaAci1VgIveEs+
	GUIODFjHjD03heMNih5QUMOZJQwpnShAYGB+YDg2/Yk3DzJunSaHxbiUBqnS+wlS6EJ8JXwMDom
	u3+li6WbTuSBpSD53HWhGg4dC5spO4t8hISgkakkoPl3cax4Itnem5f/fTMtHonjO1N8L//rM3b
	thmux9jiA9hylap/RxsSnMITvJqdtVBjZYEJU34h8fNio0NS7qu8jAH+h2V7qntH+KtbFLkvH4K
	ZzgTAI6MimFD6toyCPcrlsnpcgF1GmArkuWOSAebuYfPR3XuuiPqkk++jIjtRDXwrTaNlbuLkib
	5zTr1GucZnLOc+tk6GHMywccBSORlTigEEx8TDx/ryovXCgasyGrpNGDnBHJeAjT+I2hekz+9xB
	Y9c09n03/fI16ZwXd/xYVL4PMQAump7wRLmKR8MV0HCzpVdJoJuwnLDF1xZvwmjDcGv86+0QbyU
	=
X-Received: by 2002:a05:693c:66cb:10b0:36c:b138:651e with SMTP id 5a478bee46e88-3768675fba8mr3555477eec.22.1794415901421;
        Wed, 11 Nov 2026 08:51:41 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17119793eec.11.2026.11.11.08.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:51:40 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v3 3/4] Bluetooth: hci_core: Add hci_free_adv_instance()
Date: Wed, 11 Nov 2026 16:51:32 +0000
Message-ID: <20261111165133.827594-4-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111165133.827594-1-weihong.guan@gmail.com>
References: <20261111165133.827594-1-weihong.guan@gmail.com>
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

hci_remove_adv_instance() looks the instance up by its number and then
frees it. A caller that already holds the instance, found some other
way, has to look it up again by number to remove it.

Split the freeing into hci_free_adv_instance(), which takes the
instance itself, and have hci_remove_adv_instance() call it after the
lookup. No functional change.

Suggested-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 97ba716c0..c3d75ad92 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1976,6 +1976,7 @@ struct adv_info *hci_add_per_instance(struct hci_dev *hdev, u8 instance, u8 sid,
 int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
 			 u16 adv_data_len, u8 *adv_data,
 			 u16 scan_rsp_len, u8 *scan_rsp_data);
+void hci_free_adv_instance(struct hci_dev *hdev, struct adv_info *adv_instance);
 int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
 void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired);
 u32 hci_adv_instance_flags(struct hci_dev *hdev, u8 instance);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bfc5bdebc..8677c553b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1705,17 +1705,11 @@ struct adv_info *hci_get_next_instance(struct hci_dev *hdev, u8 instance)
 }
 
 /* This function requires the caller holds hdev->lock */
-int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
+void hci_free_adv_instance(struct hci_dev *hdev, struct adv_info *adv_instance)
 {
-	struct adv_info *adv_instance;
+	BT_DBG("%s removing %dMR", hdev->name, adv_instance->instance);
 
-	adv_instance = hci_find_adv_instance(hdev, instance);
-	if (!adv_instance)
-		return -ENOENT;
-
-	BT_DBG("%s removing %dMR", hdev->name, instance);
-
-	if (hdev->cur_adv_instance == instance) {
+	if (hdev->cur_adv_instance == adv_instance->instance) {
 		if (hdev->adv_instance_timeout) {
 			cancel_delayed_work(&hdev->adv_instance_expire);
 			hdev->adv_instance_timeout = false;
@@ -1729,6 +1723,18 @@ int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
 	kfree(adv_instance);
 
 	hdev->adv_instance_cnt--;
+}
+
+/* This function requires the caller holds hdev->lock */
+int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
+{
+	struct adv_info *adv_instance;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (!adv_instance)
+		return -ENOENT;
+
+	hci_free_adv_instance(hdev, adv_instance);
 
 	return 0;
 }
-- 
2.47.3

