Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13A27E1C5
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826830; cv=none; b=UFhAQA1apVlyryXHWFqA3fLvRqTv0da1uW05E8Qms1xREhfoV3qmMNK4y61CKdYBnar1re7xfwWQxzRLzyxVMYTwuABe++iirN6Eyae6zb9iID35MWwtUZF8REz1XwDNw6SlvcEnOwlinVupBkgPGpcthP3gvlSRgKvL0g8WGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826830; c=relaxed/simple;
	bh=c7vWCXybUs704msx87xI+mqGG01CyTg0RYBEyAWZFjw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K376h11CK93O2K0H0cNoGmHlMqSRUwQGJEHYTANtwslSTs6IfGQknFlf94782hN4Iwh7sPS9wzrk7tXegi/NKpyqmb4IjSBNWb9DdeJpTspst9OFOKsMQqlQ7PTDBdLApMqy1vkd/fNE1iCLS1iLYgvC9WllcUCy6P73pC28u00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [IPv6:2001:4b98:dc4:8::220])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 94FB9581A34
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 08:36:42 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EF0E434D1
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 08:36:35 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hostname: Remove unneeded include
Date: Tue,  7 Oct 2025 10:36:14 +0200
Message-ID: <20251007083626.1956499-1-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/hostname.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/hostname.c b/plugins/hostname.c
index 767114586bc1..35420e5d587b 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -20,7 +20,6 @@
 #include <sys/utsname.h>
 
 #include "bluetooth/bluetooth.h"
-#include "bluetooth/sdp.h"
 
 #include "gdbus/gdbus.h"
 
-- 
2.51.0

