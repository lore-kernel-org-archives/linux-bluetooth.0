Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658A1F150B
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743527419; cv=none; b=HoO5VJrs9DIBw5bUHIi47rijA9AszBWr+UXiV2iyMiXy8RwqrGYI2/WMxGhcbeh2sHw0wxqOQ7pLgMCL2ub4abuW++sf+5CVbQML4YR6+yjsMX2ofQA+Q0Lh6ghg9sAMZpeIZ4uXNquMuATCJQCY7rjYSvFJ/OpKb+Sz+INE6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743527419; c=relaxed/simple;
	bh=CM6eHZEW8xZx3F4v3k9rDsifq3PQE32MxJO5cHmmMZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nFCG9uqTz7dKLJ0RmWgntDTUbbsPLNFTX53K70/Vnduwr9UPRXZ1cqXEcQf1B/pvWzb3+S2rfCkzi/BmwsYXwWAdMejENnVD5iaq7gsVsirletC/kGf0F7a8CFohNfDhOKEfOydGzTHoayOb1HephyU3CpC02Hjjjbbad9Ct/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGtPjkyk; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGtPjkyk"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d3805a551so2618571241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743527416; x=1744132216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UyFNoTO1CTj+Lc5nYQRyIXk7G/CTkekzz9O6dlUw+nY=;
        b=GGtPjkykZX3sAXwYPwclEw+8XSgY4m4Osv7x7RMnDMdHh/1oKr0QvHdWdp8S2iCwpR
         dfNBvNKR1gAj4LjUOJNBPBZ7xG9HOL7CQif6kT18mkcV3TwcrIKTnxtHAR3mOZbCigOU
         Du2gXRHqbqSkrjwjk+prOZ5LQvmW2Ub3idOlu9NTZVSrzAbYqDiFhYUUbIhkzBRC68Bi
         FS0/oUWmxkLo7d0OnWqYbvZnrS6bEm3peMYG5WZQoaOw6FTZLXaq98EYsR2PI9hM/TgG
         NczRbDEl+3kijnZ360viLh2k8tCLVqG5PPZJzeD68OX+BZSLXW2hpHL89iMUaItpLKAI
         kubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743527416; x=1744132216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyFNoTO1CTj+Lc5nYQRyIXk7G/CTkekzz9O6dlUw+nY=;
        b=GnnbvJquUlahVLLPooaZ6Ko8QDj29CJAcUcQrt9mAUhIApB+iwKGi78H+QhKCmSiuo
         FAGr9XVvn7NPHdwTexTFeMHUyWc7blxSHvzbKES4sBke6HP72NbkahsUsiKf/fQ/0KbA
         18lFh/BMELCmgBmGF6TaOeriw54tWX3npKPqRPUF2UhYSqZe8nLJ+zPyipPbPu1ptxCQ
         o0DzwUNWAXwczWEWk0bGImni5K/OyP6f+jupadELvpAgGMTI+bTqmt9BcqqxGpPjTlTI
         HVaShSwpYVFhBg+MeF0DC1HI/7PampPBvC3FYsH6uALBAZj+FajIC4wvIDztNbtaFwid
         7vEQ==
X-Gm-Message-State: AOJu0YwFVuMjmCpwaU8TvQwRRD57edkDekxPG/Q4qXyDhoLb6fOUGDqs
	lCk8u86t6GqKlVIIdE1HyPraKzGDCqbb+FIY8GaSBt/BgJaKz67t+DhZB3k8
X-Gm-Gg: ASbGncu6VXNysD5CG6qd3mVu/YgfL6XKQIvRiAOHVvGnhlHdzdQ+FUamQnV+zHEmF/S
	7H4mIKSAyv4Xmn/IQSp+Jzgd5Izg4LrjRLHIsB6jUfQEEi9D6gl1Tkvn2gdwVYoNYN1DedQSEAa
	p7GVGg8jlEgf7ctkFRbvv3kv6eYTgIzNud7vUUtIHHYA7J0/9RI74yZzTKXmpUxFtteT7NPwZAG
	WPSFEsZObWN4/SiFIOn9cZhOJa0atHvd7RXjBBLt7v9JyHhI2k+P6rIWoT5XobEbw6F3U0849jO
	PyTwm4B4gkpGFcmC4DOegxT+wJb0kkjGV1SQwL5b331BNcbmLF31ExvYCN/j3l2jwspu8yN04IH
	iv0x4IF1l4qLWrw==
X-Google-Smtp-Source: AGHT+IG4mrPO32o0m/XtoCeuPEGhbcrY4mx+l2X/PTq2qbmmhqhKKaRe6oCKCuVYTVonJENkUuURpA==
X-Received: by 2002:a05:6122:65a5:b0:518:865e:d177 with SMTP id 71dfb90a1353d-5261d4a0493mr8754420e0c.9.1743527415521;
        Tue, 01 Apr 2025 10:10:15 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5260e7f28fasm2107601e0c.20.2025.04.01.10.10.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 10:10:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address
Date: Tue,  1 Apr 2025 13:10:13 -0400
Message-ID: <20250401171013.3785788-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes sending MGMT_EV_DEVICE_FOUND for invalid address
(00:00:00:00:00:00) which is a regression introduced by
a2ec905d1e16 ("Bluetooth: fix kernel oops in store_pending_adv_report")
since in the attempt to skip storing data for extended advertisement it
actually made the code to skip the entire if statement supposed to send
MGMT_EV_DEVICE_FOUND without attempting to use the last_addr_adv which
is garanteed to be invalid for extended advertisement since we never
store anything on it.

Link: https://github.com/bluez/bluez/issues/1157
Link: https://github.com/bluez/bluez/issues/1149#issuecomment-2767215658
Fixes: a2ec905d1e16 ("Bluetooth: fix kernel oops in store_pending_adv_report")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1d8616f2e740..5f808f0b0e9a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6160,11 +6160,12 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * event or send an immediate device found event if the data
 	 * should not be stored for later.
 	 */
-	if (!ext_adv &&	!has_pending_adv_report(hdev)) {
+	if (!has_pending_adv_report(hdev)) {
 		/* If the report will trigger a SCAN_REQ store it for
 		 * later merging.
 		 */
-		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND) {
+		if (!ext_adv && (type == LE_ADV_IND ||
+				 type == LE_ADV_SCAN_IND)) {
 			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
 						 rssi, flags, data, len);
 			return;
-- 
2.48.1

