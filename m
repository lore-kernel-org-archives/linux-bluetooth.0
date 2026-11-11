Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415900;
	b=yeUFmQA1gsvPwTwD55g9hI6r5F1WshQA4RbLTZoEpmKTaTE1LrbJu56jc0OlE6ZJH4Wz
	 p3zY6xNR87EfEVL9ZmtQfx0b64UwvAR1ZKkYYQjVePAefs2k+IEoBty/D7S0LV7Jza+b2
	 yR7peppoTtpkHTYwZ7zA3VBfQXqdQQVLXB5TOcWkMYdwaVoNDG3pOseE10Cv/zEyzXSDS
	 FKXcXGNbXOnlolVzNgtetqvY6BZOMKmqSRhkzMDWAxbTQKxb42U/9KpLwuTtdmU0hEslH
	 uFqwvqThj+jugGqP8JSpWBLU2FrXrESz0FsyyDEmXd6Faq8hLakQEUTWmcBk5Wn5DOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qbfUdL58dfT5P1l7WHlOccnYOyG2ThCfIcB1g7EjOCc=;
	b=0rinRPthhsoCN36qbEPnmUZiNTyzAjTNAcat/90yCP17AOb05We/DcggmzJFRmFtC1jF
	 IxBkwfDjuhbPXhTdl2Oml2ba5gqYIMwR+PgVJpJx9xSd1q4M2t35Ixwh1dd+V6k1aBXjb
	 w+ZpqiML/JIx2PR5T241F6nJ67LchYAXtDYrS50yl4xTQgri+lUq8mw88/FDAFmbkZE8Z
	 jHGIdeP4ttya22m22fLQXudc4f6wPr6AN/MBG612Jv7i8pHk5e74uBynDzAcalpJ81CFy
	 QiIDdGTWKiOPVUyC4ePf+bcUb2tVUVAX81I74Lrmo/5oNkoWuRhxdCbdKfYN472s+Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXR8NFdC;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65B606A33E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A65B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXR8NFdC
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3704d30b84fso4289260eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415899; x=1795020699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qbfUdL58dfT5P1l7WHlOccnYOyG2ThCfIcB1g7EjOCc=;
        b=CXR8NFdCzvCQHmfB7nPqe8pfgTDLj0Pk680SdRNh9VkUGk/T/rbP2SN+GfXQUWYY2+
         blKPpJORJkHkSjwlbH1H+wW6yTHOh98OVM1bP7AIJ8lyOH8bZGbnE71oFQDQQcKesiaq
         58xp0WIFSxmbzOjaGJEfASKyanrvhv8wEoh8srxwIbStW6mnugey87OXKw9ADeouqLps
         LIQRJD4ZLVKuKBmkchR+EYpVrDoyFxFE7mJ3x87SVN/pjV9u4kR9auofRCeq7qWt+JYw
         SOb0GT7hGHty7sJ3t/9CmE2TYSM5CbuO4zqMG2TmquE3vigyUQVVNiOB7pMtYQOBdNk7
         3KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415899; x=1795020699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qbfUdL58dfT5P1l7WHlOccnYOyG2ThCfIcB1g7EjOCc=;
        b=U0TNN4xUfrcpsVV7Jnww1Ikf7VVbLcHDsiQlOAwXZGGANSBhut8/jrn/vrWS+Vp2r3
         UlwRidH8PYfgNFcRRsM3aijhzbxp2uTZAwr2pfKsDGTSMaKz6S9o0Bpz7mlOJldo+sJ9
         vz05ZDnWN1J13G9TNaHdypH++XXUMADZ5eGEV/8QTb0Nd/boyFSEEcM6k6c2PtxhiJko
         U42FTTtZQcJAWyvDpWaENl6wzlPpk/Hpt16dPP1WKJDHUgHpoufycGN1AXthY+asT/bJ
         S1HHj716RbR664LNmMlyaFptU74YGRAaYi7DqVKkvJr+QpeTaVpWpyiZ5HgjyRpUaBwS
         IkfQ==
X-Gm-Message-State: APuU4Z/Wfn3WI2D+8hzI03z92ubh15HpBJHygb6J0v2nfp5laDv7ImyM
	/ogf46Ok52ewBPrRLN5A4paPfX5Lk0AekB7dOTTNkn3c8mX6G5in1BbPmJUmotv2tCo=
X-Gm-Gg: AYBFou2TqZCAa9kUQ3rXtF4QQBuLu/gqr23F/JqwFo8pVkK1WiRXzr3cwd4NkkNSfS6
	KGwOm7e9pTmWgCcXiTARBOsybvrx+OPbyX/sjNKUpJeb10OYOSvokz8eRDkk+MhQa8K1OS4eL+f
	nS2m1DFB3Sr7d3/xvgZDih15K7tAqqZKRn+O2rhVcIf8NYQykFevCpYnTTH1fJjru6jBBdePGNC
	mUeEoTdR+FXpmlVzV3TVLF9LUw8unBDbYoO9pH6lgHa1NyTtDJQnlNeCBhwFvrEDk13jNVh+7af
	yzYz3eqvgMIQ8Y0F/M8fWXjdJH7D3qG8V59ru8BdcL7MBvLwGLJOGBHJ82nwEreKXuqUs6r5aGu
	2BZrVA8bYUiYC1seF0Hg4kf5Ud9wEwM6JUEykN68w2mSnbVb48ipD1MnmxVJWIZS6/G4Gqb37dG
	n5NyLmJ73Sl+v1EKDBKTXxlbP7VrxUIFJc7Tb26pVSVwM7qyhm+Y1kmTOtFtUNDim2f0LmIqcro
	5JYGX0uRxmmY5wGfUMCn11pEhscLq6xNffly82TCNtaGA16g7J7GIIFIY2rkS4W3IVqNB7raU/q
	zyZzoimJrKA1L7jIvZCjTrj+oF2GmSDjIBxLI6Cpt8fV0KMZNdMGvxyCZG3WwV/uiDX1Lj1uymk
	=
X-Received: by 2002:a05:7300:2d2b:b0:36d:2704:6adf with SMTP id 5a478bee46e88-3768579df8bmr4830631eec.11.1794415899434;
        Wed, 11 Nov 2026 08:51:39 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17119793eec.11.2026.11.11.08.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:51:38 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH v3 1/4] Bluetooth: hci_sync: Set random address on the set's handle
Date: Wed, 11 Nov 2026 16:51:30 +0000
Message-ID: <20261111165133.827594-2-weihong.guan@gmail.com>
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

When the controller supports a single advertising set,
hci_add_adv_instance() gives instance 1 handle 0x00, and the parameters,
data and enable commands for an instance use adv->handle. LE Set
Advertising Set Random Address, from hci_set_adv_set_random_addr_sync(),
still sends the instance number, 0x01, a set the controller doesn't
have, so an instance using a random address, such as a non-connectable
one, never starts:

  $ btmgmt add-adv -d 0A09434841445654455354 1
  Add Advertising failed with status 0x0d (Invalid Parameters)

  < HCI Command: LE Set Extended Advertising Parameters  Handle: 0x00
  < HCI Command: LE Set Extended Advertising Data        Handle: 0x00
  < HCI Command: LE Set Advertising Set Random Address
        Advertising handle: 0x01

Send the instance's handle, looked up with hdev->lock held.

hci_cc_le_set_adv_set_random_addr() records the address in the instance
numbered as the handle and leaves handle 0x00 alone, as that handle's
address is hdev->random_addr for instance 0. Instance 1's address on
handle 0x00 would then go unrecorded, and its RPA timer never start, so
record it in hci_set_adv_set_random_addr_sync() once the command
succeeds, as the completion does for the other handles.

Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
---
 net/bluetooth/hci_sync.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9213e3ef9..320c5ba0d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1258,6 +1258,8 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 					    bdaddr_t *random_addr)
 {
 	struct hci_cp_le_set_adv_set_rand_addr cp;
+	struct adv_info *adv;
+	u8 handle = instance;
 	int err;
 
 	if (!instance) {
@@ -1269,15 +1271,46 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 		err = hci_set_random_addr_sync(hdev, random_addr);
 		if (err)
 			return err;
+	} else {
+		hci_dev_lock(hdev);
+		adv = hci_find_adv_instance(hdev, instance);
+		if (adv)
+			handle = adv->handle;
+		hci_dev_unlock(hdev);
 	}
 
 	memset(&cp, 0, sizeof(cp));
 
-	cp.handle = instance;
+	cp.handle = handle;
 	bacpy(&cp.bdaddr, random_addr);
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (err || handle == instance)
+		return err;
+
+	/* hci_cc_le_set_adv_set_random_addr() records the address of the
+	 * instance numbered as the handle, and leaves handle 0x00 to
+	 * hdev->random_addr, so record it here for an instance using another
+	 * handle: instance 1 on handle 0x00, on a controller supporting a
+	 * single advertising set.
+	 */
+	hci_dev_lock(hdev);
+
+	adv = hci_find_adv_instance(hdev, instance);
+	if (adv) {
+		bacpy(&adv->random_addr, random_addr);
+		if (!bacmp(&hdev->rpa, random_addr)) {
+			adv->rpa_expired = false;
+			queue_delayed_work(hdev->workqueue,
+					   &adv->rpa_expired_cb,
+					   secs_to_jiffies(hdev->rpa_timeout));
+		}
+	}
+
+	hci_dev_unlock(hdev);
+
+	return 0;
 }
 
 static int
-- 
2.47.3

