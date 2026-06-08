Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364843B71BD
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915164; cv=none; b=Z8ZARSYQ+wOsjfiY+pYhppqeQ7Rbfp3PlJwOANInH2Ww3dvy5vmPasPDez+C05e4rxyDqykkj5nBEN/CZBPK+zBrN+FUbr0Y/7zp/gudVMJYclFHuhbaa4bAivOAOK8LILTrO8z7FJ9XMo3lYZa7f570oV/ECL63v3BXlShjeg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915164; c=relaxed/simple;
	bh=bIEcrbWKTjr4pdE/d5hVwDxlPG4KK/Mcqo+brxKcI78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKhh0edofFVPFa7D6/hIcpkpVETbRg5V2xAGvMAB0chba2WemFv9JShMcKgdQmLUdYqCskkdKCmORJomeAYCw21XNUOY/wYu7XWItTruauqWxxaDGda+IctUR9q3D1crwmXOAw5p9BhS90iENqwPB+cuTmIt810sl78ThXWf/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=r+xyZC+p; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="r+xyZC+p"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b613a17bso40278205e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780915160; x=1781519960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG6L6EOWOBOmDDux5xjI8XWy+wHtnPSV2XzZIQyATRI=;
        b=r+xyZC+pXZOLgcuxfO1c31B8z89XU222tiOQtmeK7dOmeIdPlHL0io95+ERFW2MxD4
         V+ZTWmOm/su9WfNtOPm0g4dmr+2yirMuGbFdXG66PFG70YL3KC23fzjrUlEXAU3aI5Mn
         x9o4MqvjuFJUL1S+fo7aAt375t/JpxxHiid68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915160; x=1781519960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZG6L6EOWOBOmDDux5xjI8XWy+wHtnPSV2XzZIQyATRI=;
        b=pSGN9dCFs7LJZ27eeZn3ecK16DQuE5tv1eBHIUkjhhkhydkg6zQB3fNRtj3gsKRnQH
         4G4LMxmZoG+GCAX7IWBWz+k23qvA9FAwXv90yirJUWpkyRpxLE+8oMGGXiGpYVKsLnE2
         ny7Q+2G5mVNbTZzTD4QTxpDIQ1NV9KDzf7I81tvivCT3CXos8d9A4e2esY7yg/9VMZbl
         tAbDr5eFvTP9nc+lxhS/QNLV79bD/mvV/ysj6QcAOOjz8C4hMDMWQK3Mm1v/EoTolZeX
         FWErQKdFW91BzArOnIi0Md5H90f1O9G34EKQpGrzPkCfyYQZebN6zj0eMWWRddcpjnj9
         cTpw==
X-Gm-Message-State: AOJu0YyehXVW37VgP8aUPnKHGXOj9wR/7h0cv4pLesrkCYZQNJRPLVjQ
	x7ZLqRrz6K+69SIO3m3B+feRlN3wM8zkET69SS+36a3xcpHds3iHEPcWCm5ulpLl+5vztog0ctP
	jIN+l
X-Gm-Gg: Acq92OEoywc5EcwBjKTLjSaEOrY4R8/awaYGItR5Y6XJgNP7pR5ir7znthuCEgF8oNu
	Vl96PJwePvxt9CNgGc6lNydnHbQIroaxDs/5ELZh6E/yXH1cxV1HYp5a/E/k2n+XfvUAjKEypSQ
	GvV+CRyzWla63/8jf16DFrzn7pn8bFuCgErgof6xhzk2fzah7f62suGIWLak/7G2uTEVRO7sjHU
	4xRcIBiyF/rtPZhxJqh1sTVMkA6YoTrrHOtkNlHBPbsWj9Q2nzGje4/e2R57XR48k2qX+ChfNE3
	ZU/5yeLOoRFEi0ln3oDogHghM1PSsQT4e2X586OKslLNIi1BiiZrtiayxwQk/KjpNuMsdYbr90K
	fiZyGp3kUXq4JSVDPVJlIiTYdT8jXi3I4RiTKAKAmjb4SgmW69wYM+O2eKTtlMl17O5y8hwWtxL
	PIj3R+5bzybsxqtvSck9tpqDwV1978itzJ5mFnDONxsUQDViRQQHul1A==
X-Received: by 2002:a05:600c:35c9:b0:490:b8c0:d471 with SMTP id 5b1f17b1804b1-490c261317amr242555705e9.23.1780915160480;
        Mon, 08 Jun 2026 03:39:20 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm92776130f8f.29.2026.06.08.03.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:39:20 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/3] device: Rename start_discovery function
Date: Mon,  8 Jun 2026 12:39:04 +0200
Message-ID: <20260608103905.3614057-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
References: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename it to start_discovery_cb to indicate that it is callback function
from timer.
---
 src/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0c2ee7d8d..da70f9cc0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7185,7 +7185,7 @@ bool device_is_connectable(struct btd_device *device)
 	return state->connectable;
 }
 
-static bool start_discovery(gpointer user_data)
+static bool start_discovery_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
@@ -7364,7 +7364,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 			DBG("setting timer for reverse service discovery");
 			device->discov_timer = timeout_add_seconds(
 							DISCOVERY_TIMER,
-							start_discovery,
+							start_discovery_cb,
 							device, NULL);
 		}
 	}
@@ -7409,7 +7409,7 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 
 		dev->discov_timer = timeout_add_seconds(
 						0,
-						start_discovery,
+						start_discovery_cb,
 						dev, NULL);
 	}
 
-- 
2.43.0

