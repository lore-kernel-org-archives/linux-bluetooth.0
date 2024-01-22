Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119093F8DF
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940127; cv=none; b=sBszRQRDu7YNPCl9JZCXTapWyRJGZ6ucXAhRuXBeqe10KbKXxVBsZnAfLzVOcB+aiMNLf6AXlV690IWUad5tBDQwN9yuHzIt4Kvn1QucNtyaP8jEAcd6PRWzJMgC7EiXgR7P9DYEVWdTCAKAnE83fB+mK7jNM2rJskkAje1B4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940127; c=relaxed/simple;
	bh=MJUAglIkAmUXngawOKbJZzoyQjgte/oTJ0mFNcy73lQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ESPMbieOjXo4Imkn71kSoLaJX0A7WR9+3eaRp7Zs0jxFPctEs/7aZNDPiLVLfL+hflaEn2fVJsNFE9jV0ADwRME09KR3gxLQ+pHmUvaV35i0ZI33Yaem07m3kcNgL9c10DrSb2aD1zKM8k018AtVarn1tzpJKD7WLNv1bdmM19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFTd0fIa; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFTd0fIa"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a35982c09so12711941cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 08:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705940124; x=1706544924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tbNABJqSzj0kqcHCMHSyKMQUwZZuuwuYl7pA/mkjWSQ=;
        b=FFTd0fIaMI7ch7YG96Dy6NNcS7kBqVtsuyqmuJ/kNC8QQiv1dkQRix0UVsdSvZXT/u
         IXMwwK3bPICLVHzwPCeCxGCKwZodmPuNRQ5foeX5NFHfI3JYbJC6WmOnYu42yixYloLd
         Z4TDM5fLM0T885DWEqD0QDpTaIcZWdbeiuO5qlj/+tSarbA+1uTWLRhiL6XUHP3LpAFL
         RQpudiF6Nu5GBb5zcQlgyl42fVOJH+BjiaZM7SEC4SPkH+En1Bu7KxPf256LwiW2QVOJ
         G5Nal7XURBSO1nhhTsm6JqdD8qFMulDlYpw0TVOkVD6zlERVQeobyAGlYbyQ9NNDHFHw
         pmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705940124; x=1706544924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbNABJqSzj0kqcHCMHSyKMQUwZZuuwuYl7pA/mkjWSQ=;
        b=pD0dpUatXGtnRArGvu+jYuATYTyTXW7uTdFB7n0B2eUBk5VpGyaQleqDXi0BO0ZClh
         t7VLrx1S27mcTaHgDiFZbe5jQR8w8PRLF7Scx1ezhX9dQpZzD6rWgtJUsjalj0X/QFn5
         786qMc0XuwbI23ME6oDOgZwpsGfoMzOTK2mXKcxtJqQ75LW8wuywIi4dEUGi+Pb90vTy
         A5Dyn99t6TyTZM9DGUvXwCfhT9+RLviLjbpINXutJjwoHRWHNnXt5UHnucVtcZXhsJnY
         AmQ7rVhV0oCjjMMu93hvK5Of4xMWd0O9xBxGw2IZsUwtt1nga6Q5YVzUN9uKt+Ib3FhE
         zFhw==
X-Gm-Message-State: AOJu0YxJGUzc8jOnVKUQQjQlukSjprG4dV1+VqSiyeDgW6VHzhEgLoDA
	zUpYB/6hS1N0zfWdr2Uv5hYBerwhuVj+ktwsFgH1FXziHg/AhbO6nTnFWh1b
X-Google-Smtp-Source: AGHT+IEFI89w/hYrm4Dq3BOqNxgkKndoutFdAdB1b1gAN9QZFJs5W3PrT3kMX+/gnz30VfpLPpDdLA==
X-Received: by 2002:a05:6214:2686:b0:681:954c:39cb with SMTP id gm6-20020a056214268600b00681954c39cbmr6340297qvb.75.1705940123776;
        Mon, 22 Jan 2024 08:15:23 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id op23-20020a056214459700b0068681793468sm1798612qvb.36.2024.01.22.08.15.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:15:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST
Date: Mon, 22 Jan 2024 11:15:21 -0500
Message-ID: <20240122161521.2650805-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If we received HCI_EV_IO_CAPA_REQUEST while
HCI_OP_READ_REMOTE_EXT_FEATURES is yet to be responded assume the remote
does support SSP since otherwise this event shouldn't be generated.

Link: https://lore.kernel.org/linux-bluetooth/CABBYNZ+9UdG1cMZVmdtN3U2aS16AKMCyTARZZyFX7xTEDWcMOw@mail.gmail.com/T/#t
Fixes: c7f59461f5a7 ("Bluetooth: Fix a refcnt underflow problem for hci_conn")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6130c969f361..a15924db83d9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5327,9 +5327,12 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn || !hci_conn_ssp_enabled(conn))
+	if (!conn || !hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
 		goto unlock;
 
+	/* Assume remote supports SSP since it has triggered this event */
+	set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
+
 	hci_conn_hold(conn);
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
-- 
2.43.0

