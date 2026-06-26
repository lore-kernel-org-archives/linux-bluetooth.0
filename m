Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2A3164A9
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470779; cv=none; b=VOu9uPRB7mkxa/+HgnNrkTVl8cRxal75bMBplYkLD0A61BwZl7EZ8EqtWB49h7v4enGpudYPo9Ak+E+j6ExSc3CxFTl8F7kr4JwvPfArba0+yC16mcDPm6QMMTc0UIh2NOm4Rie+Ce/dXCqgLXvDX5dq7QZqs0n/UesgJUuzkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470779; c=relaxed/simple;
	bh=vKEWT6O9bP3DpdrhVvIho3UWnDQ9SYmZ2ge7bd0ghi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cww+Xi/6Ics6fkFnw3Ft1Fc05sRgTWIz8gp1DGQjCzUkzDwOrnaiBJWBafzPQD6VuBvGdmXQ5Lu6WVbHNETgqypJFpXDajjLKTqQYBsneoLxpASH/wlL3XvWnwh50e+D5v07IqMJGEMZSsfJpNHrEidHsZ+xsNXajg6P8Pez6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6xfnBz1; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6xfnBz1"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30bf132969bso1275872eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782470777; x=1783075577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qP0J1iWyaoP+HLz+xwVairx0bDAZ93dXt6GX/Ei5LK4=;
        b=g6xfnBz1cpWSfhdC9mzpPEjHqjf50psXJGZn8at5/PVxiZkzCw9NE7a3DZzE77FiIP
         K5K14S8hMnoggHgDAkz/WGIal73rLWcTwJftSEz8Um1SqkNIf/+w9C0b/GpVtnfZl/12
         uUtPVT1B/DRlw/O+d8e9fA/pTuuQuMmCnppD2uVffxCxRLJw6E6BwoTrtCliHnQxOl7x
         TFhFsqT5Fnhc8jlsg1C4KQfFLZrTbuy9Xk1n6iFdFGVPD6/4RN864qhig9GGTg6EAeI2
         gk1yr7Mo5MP3fR90Py/4+YRFpdfQSU9+yLur75CbXVMrHvg/sugBJkhT//8b9vlm6Oqb
         R+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782470777; x=1783075577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qP0J1iWyaoP+HLz+xwVairx0bDAZ93dXt6GX/Ei5LK4=;
        b=k4YMcPb1EuYdthzkiPrpVSMmpYI8rjr4YYOnq3T0dlTJusI6uliic8X5G1QXgui1D6
         VzOAxfXD0gYQckVggpJwGfaW/nMFQ/1QvKfM+fBK89fVf0bum46goi1mcpiBXGVqjlB+
         rd3SIn82v2kgKo2tP1JHO89htFBpdm7AD+0mHdw8YLgCyUQjQNR8Oh9f2QDLz0gCREyq
         DISm4uXyv6e5mw86X7QgXp2J6Na3mN+aRejXHiad1kDN8xwxXInC7mVhLqDh6/MbAPsy
         Hhm7t0i184FiwDRydkPl8ZPF5DSCaGeBzTJtS568ttt0SQw2lQZCvt94LvG42o1GaxQB
         QxFA==
X-Forwarded-Encrypted: i=1; AHgh+RoiXTB1oaT+5gVBbeNvBFAVOv7BDwwiCtcOAU1agOVf5onT5oIyAOcTUToIIe0zhSl7vlDNqP3YSqw84hif7Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cJEiYEpeuaPCqiP3xnjpmC0pWPHDLAzA1jJs1XsUbWo3NSm1
	ItR/i4I56XFN+ZOWb+mviKs2Z/OD1AfpTIpQWtvv8s5OYd4vwqm82+cD
X-Gm-Gg: AfdE7cllctR6LVOGL6fyd9v7cRroDSFG9I9aT3z9eAQMwgXHx0zZRfuBXuv+zfHRyzV
	zI7SGy4yD0YWRYcSoYllpeGWd4ijG9zrzeYNLriT5gga5eewzQhtazWiF/5lFUPvQVooKChkmH5
	/ZnLPvAZBzxG2c2oIRL6jJ84XnzjDN+ZRZUiQtnV+QAKReWuQHSJuVPf0IHqomg+u2cL5z+98Vm
	ZCxtAXH7GD5Ai4SjugEoqQmIdF82B9yingp618Ten4bgFye3sZuRcayO+5bIpXzyiVe3OBivKEm
	DAk1dig4WF0AeCXf3bu0FVyDqKMJSibBa/lQYeM7mVC7EGlGwq+ZgBi8Hh13kYlYMTHjqOgXEE8
	vntLVHWO7Xa7dejDL/2nxYqU2tdeD8XNMd3vk1m+zlLEsIVRGS+ryjeuA0V+f1j/jUgLERq7bFs
	ms/OXBAiDSmCb1mMpYuBLBfEZG3fiU0z/O6/VsWId3p7AM+xDSlOGbig6fQA==
X-Received: by 2002:a05:7301:644c:b0:2ea:e93a:ff9b with SMTP id 5a478bee46e88-30c84bcdacfmr6099364eec.13.1782470776870;
        Fri, 26 Jun 2026 03:46:16 -0700 (PDT)
Received: from naduvan.timesys.com ([122.178.167.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab28fasm17823093eec.30.2026.06.26.03.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 03:46:16 -0700 (PDT)
From: Siva Balasubramanian <sivakumar.bs@gmail.com>
To: stable@vger.kernel.org
Cc: tristan@talencesecurity.com,
	pav@iki.fi,
	luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siva Balasubramanian <sivakumar.bs@gmail.com>
Subject: [PATCH 1/2] Bluetooth: btmtk: validate WMT event SKB length before struct access
Date: Fri, 26 Jun 2026 16:16:03 +0530
Message-Id: <20260626104604.3465124-2-sivakumar.bs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
References: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

commit 634a4408c0615c523cf7531790f4f14a422b9206 upstream.

btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
(9 bytes) without first checking that the SKB contains enough data.
A short firmware response causes out-of-bounds reads from SKB tailroom.

Use skb_pull_data() to validate and advance past the base WMT event
header. For the FUNC_CTRL case, pull the additional status field bytes
before accessing them.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 634a4408c0615c523cf7531790f4f14a422b9206)
Signed-off-by: Siva Balasubramanian <sivakumar.bs@gmail.com>
---
 drivers/bluetooth/btmtk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ad8753dda826..5c6f4d4b2e7f 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -655,8 +655,13 @@ int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (data->evt_skb == NULL)
 		goto err_free_wc;
 
-	/* Parse and handle the return WMT event */
-	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+	wmt_evt = skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
+	if (!wmt_evt) {
+		bt_dev_err(hdev, "WMT event too short (%u bytes)",
+			   data->evt_skb->len);
+		err = -EINVAL;
+		goto err_free_skb;
+	}
 	if (wmt_evt->whdr.op != hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -672,6 +677,12 @@ int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
+		if (!skb_pull_data(data->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			err = -EINVAL;
+			goto err_free_skb;
+		}
+
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
-- 
2.34.1

