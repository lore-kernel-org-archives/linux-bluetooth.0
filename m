Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D458599E
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065758; cv=none; b=MV2MetGAK3i812qGSXy7fWc3eQEtmbzQQG3cLQgBlnXRC3x5cp+759kYoIZsoMdeo3TV4sIIzC5LwdI8oPAsPTRLFaW+TZlg0u6qb7W5p4lRWTJmrjZl3ZxNsS/slU4rRr+6TderZdR6A+8n61RccUkVymfEdnHagK+qFLn/Bvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065758; c=relaxed/simple;
	bh=n5AS2BVldLrF2N82Hr+C/tVEMXt1Ei8alwO7LDR/qPw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLZ8nk4jElj3CuSNHl9WvaDy3duLO/KcVgmJZ6MCdWeOFcebIOrdOV0lUahV0qnChxCu/R3wol6b29iyAD/RaiyQKGr/lMeze3cYSA/7UelakmZPM8aKOL38hTWxWTxPUyHa7tTux68wAZkHE5Ygo/IEneJnyIRwPykLlfs/UoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khCAhZut; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khCAhZut"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5c83fbd23a5so552055e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065755; x=1789670555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CMdMMR7ySNFK702jv/OFOCV+WQ2E1Y+KE1TEPPlwnKo=;
        b=khCAhZut3994XvUnc7UfDrvb1prh2dT/535HL/ivXBmIxCPivp99eN4V8/XMlE8/of
         Kbl8t+Xk9xfrpclTqaokU1B/s9DzICo4W9z+oHbL/svmk34+//r5Kmcfeln1CathzOSO
         BMlIgq9gXv0Ku+Vf0OZAQcPrcKtSff7ZpaY0pQYHRGPIkLkgB5dcwtpGvdphAlPXYg0j
         1lQIxoCy/upiWfKrd5QKZzIVJFL283wo40gFbP96gnG7G0OYiiIhZn4OjbznFEPxqWbJ
         7HzFcdFxpC8FTXiWaDjNWUnHpHQVPscJg7WbqDyEZAYhe96Cxb+u8pXW7tI6kUnl3Ksq
         /P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065755; x=1789670555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CMdMMR7ySNFK702jv/OFOCV+WQ2E1Y+KE1TEPPlwnKo=;
        b=lLoHmZEf2QqOU395OaA9fY2UzspD7K5kp464BIXOzzGquN29T/x34GUtnhplaBdiWg
         9RPKOWYTzOpGlI1g5i00qA1MhDdCP3CenLU6cNfyYTiK5VN9Hdl/Gk3vR7gjwiaT8Dy8
         krmf9cu375NxWi64nSo2sJ30+i7uagb1Ny+j8bjE0fiUosiwij1CWrftM2LVMNZcA/qT
         EevPO3Unm7z+4n0FYfIEwrbxnsYE0vWbvRdBLCoTtachpsqr70aOhU0ZjT8sDRcMDDsy
         KrlK92AK3N+5unnckf7wQ5WgDLV8cW7Ly/j565yJy2InPIJvax9rAadZs4WZaGaZLzj4
         gfvQ==
X-Gm-Message-State: AFuF++kmFHnYV+cASHUMnv0o4MpVhBqeGo+sKl4XePdSq03j8C803wz5
	zQJH5MsjUkZssjCzbU6z2Xf+NzzZpHNJkgBEqpehleR5hxkdLn9oZJsKShMXX/Jj
X-Gm-Gg: AYBFou0c7s5k3UeBiSt83lgSCnhNDvBO4Q7iIdYRILdHTshtwcWwdtOsbJUMHY/IU+N
	DPfY14cj2PHEb6QU9EVwNmebkrb8N8pMtOtZxAc68ph+mYOcZ3hiKxq7WNA+6Imexerm5UW0JHf
	QIh7O1C4dJBeEXYRh0dTMZueOpmRAd0df8gQk9FnbS2GOzA/p80LxBfwri2wm7LnOHGf6Qo+gKq
	RsMqMpVqaOpuGJKx7avI9qUYLbyOuuvwYzyRIuILvLFzl1PcvXXEh8xd0fiMUsHhtJdf6Q6UT73
	uiuFuo9jbR8ANIXqz1ueA8YZmBvOJrujSPHC61siHONYduuo9DvOwWBsuzAQOz55jIiD60aesKH
	v720WYO5b2SJNkwAWiHH8TnLzcjqezXCRkN2gFpsMArvAIR6H+8Qrf4qfbYBug337VXEXHJDqoE
	WkxZMD2jpGa+G6sjYmTi9de+Lr7OwqNnNfc+4GC51eHaRqKNnX09TolVl+Q9BzkK8xnhnTbZtTT
	6cKHQ2/jpHGWQORQXf66ndLSsbXk46Bu53myi4K4LXn2TSZ8G9/ZtypZ6xbU+gN+A==
X-Received: by 2002:a05:6122:6b8a:10b0:5c8:3dfd:68f2 with SMTP id 71dfb90a1353d-5c83dfd70b7mr2100488e0c.6.1789065750685;
        Thu, 10 Sep 2026 11:42:30 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c8470ae7dcsm222256e0c.4.2026.09.10.11.42.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:42:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] client/bluetoothctl: Declare the controller helper in its own header
Date: Thu, 10 Sep 2026 14:42:16 -0400
Message-ID: <20260910184216.1601639-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910184216.1601639-1-luiz.dentz@gmail.com>
References: <20260910184216.1601639-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bluetoothctl_get_default_controller() is implemented in main.c but was
declared in admin.h, the header of one of the submenus that consumes it.
Move the declaration to a new client/main.h so main.c also sees it.

While at it, drop the bluetooth/bluetooth.h include added to admin.c,
which is unused.

Assisted-by: opencode:claude-opus-5
---
 Makefile.tools |  1 +
 client/admin.c |  2 +-
 client/admin.h |  2 --
 client/main.c  |  1 +
 client/main.h  | 11 +++++++++++
 5 files changed, 14 insertions(+), 3 deletions(-)
 create mode 100644 client/main.h

diff --git a/Makefile.tools b/Makefile.tools
index cb113f96161e..6844a52ac739 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -12,6 +12,7 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/adv_monitor.c \
 					client/gatt.h client/gatt.c \
 					client/admin.h client/admin.c \
+					client/main.h \
 					client/player.h client/player.c \
 					client/mgmt.h client/mgmt.c \
 					client/assistant.h client/assistant.c \
diff --git a/client/admin.c b/client/admin.c
index a6fba2f1ce1d..98276f56c652 100644
--- a/client/admin.c
+++ b/client/admin.c
@@ -16,11 +16,11 @@
 #include <string.h>
 #include <stdlib.h>
 
-#include "bluetooth/bluetooth.h"
 #include "gdbus/gdbus.h"
 #include "src/shared/shell.h"
 
 #include "admin.h"
+#include "main.h"
 #define _GNU_SOURCE
 
 static DBusConnection *dbus_conn;
diff --git a/client/admin.h b/client/admin.h
index 00423d9d35cb..0047770dc737 100644
--- a/client/admin.h
+++ b/client/admin.h
@@ -10,5 +10,3 @@
 
 void admin_add_submenu(void);
 void admin_remove_submenu(void);
-
-GDBusProxy *bluetoothctl_get_default_controller(void);
diff --git a/client/main.c b/client/main.c
index d8d2e32d9556..8f7a7c4135ca 100644
--- a/client/main.c
+++ b/client/main.c
@@ -28,6 +28,7 @@
 #include "src/shared/util.h"
 #include "src/shared/ad.h"
 #include "gdbus/gdbus.h"
+#include "main.h"
 #include "print.h"
 #include "agent.h"
 #include "gatt.h"
diff --git a/client/main.h b/client/main.h
new file mode 100644
index 000000000000..0d2af5c5014c
--- /dev/null
+++ b/client/main.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Collabora Ltd.
+ *
+ *
+ */
+
+GDBusProxy *bluetoothctl_get_default_controller(void);
-- 
2.55.0

