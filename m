Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DF3DE43F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348634; cv=none; b=ktFZxQL639hssVX62kfMchyCFUANIUXu2q6L3mmMEPwA8FXJKSK6C3rxtRWHnKYxPwLS8Id/mF1oeXqWmDWLfZvRxXjEzf0fMmWBdeTzKl9Dmeb83Y7D/cKERlSYtx7vDgHlV0Gee7qBLWr16FItTJWDWlh/H6BjVxrpTPJIZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348634; c=relaxed/simple;
	bh=QX0FtBkED2+IcrAnAon2nRD+t8UTeVWRMl/ypTm0kbQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4Lmi63mmXlIXXFCe9y+0xiUaqZWonlFZeNSNQ0zhq1sJp3JD69kyPsjWRTGl6Escm8C8sfwINQvH7AOPTDAi2srrYaZwXcNrG4CJ+u5s5rcPewmI8i9FLMJBXSvRGFp2AhVKXe1RLPyB7AD8EfipzlNJyG5F0alCmgJwozfXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DA203EC67
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 14:10:30 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] shared: Remove unneeded glib includes
Date: Thu, 16 Apr 2026 16:08:42 +0200
Message-ID: <20260416141021.3970323-4-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416141021.3970323-1-hadess@hadess.net>
References: <20260416141021.3970323-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFlf8FcLg8mwAwyOlsxAOYUOXqQFCBXYPQyC0gepPHxDdFwUcVwGhIhLyDNV2czXtx3xiOodmDXgoPpS/QQoNTewVP8RrvcGnKXAWikM5BvRWaHOu0ZMbbWunVkuN1RgMm5ssA/limjLtsf8wVyHVTUJKu7kBZorS7CeXje8su57sW6Eq3FuCAY+M/3m4VLiXLI/xnuXtR7ICfnZ8HPUfDPzEfyRtzHSrwM3dszOukmrZ91UvBsV6gH6HMK4viZtMoHmenBhG3qg11uJSVT92Ob3Ny4uzhUep5EZYnTzuGRiLfPynsKlC4tkEB70DD72zO3Y5+XV8SUq7I5kqocnqFzUOjRo3NnxCAXjOgIie9yYOmgGKVctonuEZ4kzuU6VUlG/Zo7RTS13I+PCBMUNbW3b1i8+sGXv8xbmKQrgvgVlorF8LBUCJTb7UaZOsQv98llpy7PyBwE/wAnj3L+UpyFtrHjHr3mr1UUdyAT1xI12BSwvuk5F/zQ4GpRezR+FBxQBOEtQ1eGJ+F1LChufCHRyueEXpWwYT9cKp/noGJVkKi0X7MhOOI96uvVMIgr/G20mk/bsHtZ6uSWxfQotYATITcCpnqpnH7q3vXGRJkZlGLIA/F77vxyo7tsZ1g+/Lfmazd/P4ZxxMrAnCf0Y8cumGuomEU6EAz4Z0Ke5mMn/A

glib was included, but no glib functions or data types were being used,
so remove those includes.
---
 src/shared/csip.c | 2 --
 src/shared/rap.c  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/src/shared/csip.c b/src/shared/csip.c
index c5b77001a1aa..06b1606d9123 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -15,8 +15,6 @@
 #include <unistd.h>
 #include <errno.h>
 
-#include <glib.h>
-
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
 
diff --git a/src/shared/rap.c b/src/shared/rap.c
index 39ef3f2783c4..ccf3e6f33793 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -12,7 +12,6 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
-#include <glib.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
-- 
2.53.0

