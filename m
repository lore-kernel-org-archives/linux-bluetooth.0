Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61245347B4
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347664; cv=none; b=aqbyBuEVdLkuOqAOtkxhMiEuF/EOZiWeOMrblWyJLEab9/gQ0sQ1WR0KN63YQw7QOXUvtPMEZOxmcQSjvJeEHfiIO7J1bRbKC0BwUtBkrxSqRk524Zogt5zYwlPH1bf3XBuni3rdkLIgthjo3lq1oWIonYK1e5eBWqA355iNYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347664; c=relaxed/simple;
	bh=M7R3FufmR/Ms4MORWfiKiWlhmwo3v7q0DmcqzAmN6/c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uMgGtM56Y5tgrdM/vUIsr7YiFDVrE+k7LnThVHYUfmeDJfOGsBaJvBtzddYTKZnfIZrc/b/AoQY5c/7ZVAUWDhdvMBy/JC8QiLKGfog65So1PW6Z1b+Hr7UuDs0zdqjedf/2DNsAPaNPHbC0bpUMiPhQFgXwJe7pRc+0BR+QGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOrji7qL; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOrji7qL"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-556f7e21432so185240137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Oct 2025 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759347659; x=1759952459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QECU1yQzdNd81rwe9PcZHiB6uStuR0pAlQVxOgvxsDg=;
        b=jOrji7qL/poD84G60W5j5gkBvEZBi5UC8FebXOTANEL6bFDTdEFyLHzhh7Hs8CII7H
         KyWt6hZnVxSaCRyj5f4jeTc6c3Qj6VuK+qjDDKt8DxrAWXrslr4NshoLo9HWU5Mql7Vn
         kHwQ54JpQm2dQt8i6lTrDfaL0drcss9jpWGeJqtxeypG6Pj9ycqd6LAXe3UCdiS122zr
         wYr+8YS/PcIW4ZuY5LnlWCe9gF3xYNyvkyZd+Z2HyQhTq1wPODB9XYGdTBbtNI9MYTds
         uU2ICSdcrpAycw9Q1qOX6aDdNYLo9JhGt9xAS/JDgmGHPGLK4pRo5D5hpODNHsNyxl0J
         cHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347659; x=1759952459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QECU1yQzdNd81rwe9PcZHiB6uStuR0pAlQVxOgvxsDg=;
        b=NSCE7rls51p4SQj1YmeestJDd9frGAr24dUQFUTTP45ocr0lqY+MKPgTIRxmyXxxqh
         B2ICGCVi/XKzEkLNdcUsnMpNfomjAR12Oaokbf/hBODETnwsfocwTLCxVyvDzhHr3iyt
         GtrurKGxThAuhs7HCenftT+hLjClKF34KgI30fd5vJDMSO8I1kIaSy2FyGeA9k5wCuok
         p26epxymIjny2OYQbiHeFWWsQKqJx2DBYIYHE3XpLj/L4IGdaU/ebZwjttBsY7/cRnOQ
         L5GgoEQCrfHdIORIPS48/wYXw1ObDffWcDAqAo5M6PbYzJU1EsigFN8FGiiugzEgwi+T
         DjkA==
X-Gm-Message-State: AOJu0YwoOBvHnYDTaZ/AOokhPQy2WEjJDZOOAW+YDk7KgD3KWsJYIIY9
	4hzJUQjc9Iph/LJABkcKo4FNbsi6ObHiklIiEmtH9Xqd/hTWnT3FipMMT+1GRyJn
X-Gm-Gg: ASbGncu0hgGybjrtHAypcwPt8iu/PPdJLuk7lSnWep7tO5X3txRkIVdpiBT06mXdEbt
	UFZ4BcevrzMtaj2PEjflOqWrDKHORxvDrIDJgVgNAOQWC1BE6SkeUFNhCj0yhISKdJ3e+2VlJXH
	+PywvYzDO87cdZgw9loCGptSI2GndQ72gJ7dVCg9/pDLg+JtYywzcMoULUufY7x75AQ3YHPgJPP
	GpxRjtWKoZIgnqonMOfs3Hsms1PgjfuDoQCks2hPExEx1NBpWn7BQXwhuYIRpSExKSuoFL/DmIX
	nYVCwtDyBkWGRIgQtMKBBD5i8Z6rLq0m9XashL5t5tdm7hhpY9lHtGdFuiBS5VzSqeqBGHNXfOO
	ti9kowiGRn9FCG6alt8TpHabRVZ/7rvbowBlS8dD6OVKPh7aAsX7lOFrlCnlwoISxraikBRMDhR
	txOP/5L8eoeiA1/g==
X-Google-Smtp-Source: AGHT+IEQzA4xjK16ahsbXCffmTVRbL8NjFVRBiSl0tv2dFLOmbUdy8SMjBkDNfJpVmSxNDoxG7tZvA==
X-Received: by 2002:a05:6102:c13:b0:55d:cfa5:9d52 with SMTP id ada2fe7eead31-5d3fe6e6b73mr2393249137.27.1759347659509;
        Wed, 01 Oct 2025 12:40:59 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d40c68c57bsm120152137.9.2025.10.01.12.40.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:40:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] lib: Fix headers that are used to interface with kernel syscalls
Date: Wed,  1 Oct 2025 15:40:49 -0400
Message-ID: <20251001194049.86963-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the headers that are used to interface with kernel syscalls
which seems to be broken for a very long time due bluetooth not having
proper uapi in the kernel and libbluetooth not licensing the headers
according to the same headers in the kernel.

Fixes: https://github.com/bluez/bluez/issues/989
---
 lib/bluetooth/bluetooth.h | 2 +-
 lib/bluetooth/bnep.h      | 2 +-
 lib/bluetooth/cmtp.h      | 2 +-
 lib/bluetooth/hci.h       | 2 +-
 lib/bluetooth/hidp.h      | 2 +-
 lib/bluetooth/iso.h       | 2 +-
 lib/bluetooth/l2cap.h     | 2 +-
 lib/bluetooth/mgmt.h      | 2 +-
 lib/bluetooth/rfcomm.h    | 2 +-
 lib/bluetooth/sco.h       | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index 88a5d8b66134..a16523815442 100644
--- a/lib/bluetooth/bluetooth.h
+++ b/lib/bluetooth/bluetooth.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/lib/bluetooth/bnep.h b/lib/bluetooth/bnep.h
index a0d39058c6e4..f8a08b46ec08 100644
--- a/lib/bluetooth/bnep.h
+++ b/lib/bluetooth/bnep.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/lib/bluetooth/cmtp.h b/lib/bluetooth/cmtp.h
index 7ba8bfc3bf6f..47ec4119a6f9 100644
--- a/lib/bluetooth/cmtp.h
+++ b/lib/bluetooth/cmtp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/lib/bluetooth/hci.h b/lib/bluetooth/hci.h
index 732477ec4b55..754c32cd8913 100644
--- a/lib/bluetooth/hci.h
+++ b/lib/bluetooth/hci.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/lib/bluetooth/hidp.h b/lib/bluetooth/hidp.h
index da42a1b9ecbf..aacd398562c2 100644
--- a/lib/bluetooth/hidp.h
+++ b/lib/bluetooth/hidp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/lib/bluetooth/iso.h b/lib/bluetooth/iso.h
index 1e9f79ce5d4c..e0b22eced82d 100644
--- a/lib/bluetooth/iso.h
+++ b/lib/bluetooth/iso.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/lib/bluetooth/l2cap.h b/lib/bluetooth/l2cap.h
index 62cc04b57ae9..ca6bcaac8805 100644
--- a/lib/bluetooth/l2cap.h
+++ b/lib/bluetooth/l2cap.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/lib/bluetooth/mgmt.h b/lib/bluetooth/mgmt.h
index 2b45010d1b0b..ba539ad0db1d 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/lib/bluetooth/rfcomm.h b/lib/bluetooth/rfcomm.h
index 0347ddc36770..354263135ea7 100644
--- a/lib/bluetooth/rfcomm.h
+++ b/lib/bluetooth/rfcomm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/lib/bluetooth/sco.h b/lib/bluetooth/sco.h
index 307d81f813ff..c27f7530bd4c 100644
--- a/lib/bluetooth/sco.h
+++ b/lib/bluetooth/sco.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
-- 
2.51.0

