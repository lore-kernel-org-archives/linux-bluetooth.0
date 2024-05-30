Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF0145A01
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081263; cv=none; b=tE6bqGfsqFufnGdGi5I8puc0cx5L9Fax8M6omxHnNWvx2eg9bzbK8Gl9TA45ZtJg2Xz30Iw1VZ1bOX0Cc22QUgcN5DA3Fz5W4kbbg9JYXd6NsS4MXWHjUXv8seLK+G8YUXgCJm7zvCZAeWSC+bKFVHF+9mI/OZ2QzkxhDFTZd0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081263; c=relaxed/simple;
	bh=zTCzTXSatAKZBJ5sPdSyoJ6iX/dT7b91Sw2MA+Zf84E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awN6c04v7ai8bbI43vOPfA+bRfxgPAtUSnqrEPqUW08OpxtliZ7CDoxeq/0LFYKseA9IK6vLH8cLzlAaB79s+vhMf50227i824qvTiFDDlOWcZqP0U6od60erEvfjoNMvneM7HpBHsbdj4IXhiDckOceNa4/qp/hgabv4HurKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F8522000F;
	Thu, 30 May 2024 15:00:59 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 5/9] shared/mainloop: Fix integer overflow
Date: Thu, 30 May 2024 16:57:59 +0200
Message-ID: <20240530150057.444585-6-hadess@hadess.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530150057.444585-1-hadess@hadess.net>
References: <20240530150057.444585-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

signalfd_siginfo uses a u32 for the signal number, but siginfo_t uses a
signed integer for it, so an (unlikely) big value for the signal number
could result in a negative value being passed to the callbacks. Catch
that and bail early.

Error: INTEGER_OVERFLOW (CWE-190): [#def44] [important]
bluez-5.76/src/shared/mainloop-notify.c:132:2: tainted_data_argument: The value "si" is considered tainted.
bluez-5.76/src/shared/mainloop-notify.c:137:3: tainted_data_argument: "si.ssi_signo" is considered tainted.
bluez-5.76/src/shared/mainloop-notify.c:137:3: underflow: The cast of "si.ssi_signo" to a signed type could result in a negative number.
135|
136|	if (data && data->func)
137|->		data->func(si.ssi_signo, data->user_data);
138|
139|	return true;
---
 src/shared/mainloop-notify.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-notify.c
index 33be3cf8d78e..11989512e013 100644
--- a/src/shared/mainloop-notify.c
+++ b/src/shared/mainloop-notify.c
@@ -15,6 +15,7 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
+#include <limits.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stddef.h>
@@ -130,7 +131,7 @@ static bool signal_read(struct io *io, void *user_data)
 	fd = io_get_fd(io);
 
 	result = read(fd, &si, sizeof(si));
-	if (result != sizeof(si))
+	if (result != sizeof(si) || si.ssi_signo > INT_MAX)
 		return false;
 
 	if (data && data->func)
-- 
2.45.1

