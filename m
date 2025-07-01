Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55EB270541
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364934; cv=none; b=C6tHtq5fkJnBc8CG4S/MGJq5cW4CX83tTQYL6Y0FR9eaPfIvYUJRfERRlcVCKguvG2RRg5M1y56wda7eUq4hBq1SgDKOgSuBu44DmWstXuLpo8U3uNH84sHiyJzS0KqacrIQBZV3NMuakkngCjAe9FEiiXqZVJQhEGE8DVz3ASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364934; c=relaxed/simple;
	bh=lfCiITWKkwmPSQzOhtQmPNluIIywAhZAJ1rri2ACJG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKzcou2ldHw0HLjZ+qjG0vVtA0PphaPeYKLDUYGkdy0VlvjUZ7cUqs36IvfPAMIC0IEy1bAxUn6boLXFEM5REuuVBK1TKFv1nUuAuORm4raQcFAAKKq/SvYzXkggDRZ0bGi+hnbLjMiwH79ZqTGPMDzkdAah9Nvb9O+zAx9muHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F30FA4386A;
	Tue,  1 Jul 2025 10:15:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v4 2/8] error: Add helper to return DbusMessage errors from errno
Date: Tue,  1 Jul 2025 12:14:23 +0200
Message-ID: <20250701101520.459452-3-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701101520.459452-1-hadess@hadess.net>
References: <20250701101520.459452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

This will allow us to start adding more precise errors instead of
"Failed" with a string if we're parsing an errno.
---
 src/error.c | 12 ++++++++++++
 src/error.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/src/error.c b/src/error.c
index d82c2f2e1520..0e57a07548a9 100644
--- a/src/error.c
+++ b/src/error.c
@@ -217,3 +217,15 @@ const char *btd_error_str_le_conn_from_errno(int errno_code)
 		return ERR_LE_CONN_UNKNOWN;
 	}
 }
+
+DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno_code)
+{
+	return btd_error_failed(msg,
+				btd_error_str_bredr_conn_from_errno(errno_code));
+}
+
+DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_code)
+{
+	return btd_error_failed(msg,
+				btd_error_str_le_conn_from_errno(errno_code));
+}
diff --git a/src/error.h b/src/error.h
index 5b49400fbb92..828cf5923f6f 100644
--- a/src/error.h
+++ b/src/error.h
@@ -86,6 +86,8 @@ DBusMessage *btd_error_agent_not_available(DBusMessage *msg);
 DBusMessage *btd_error_not_ready(DBusMessage *msg);
 DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
+DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno_code);
+DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_code);
 
 const char *btd_error_str_bredr_conn_from_errno(int errno_code);
 const char *btd_error_str_le_conn_from_errno(int errno_code);
-- 
2.50.0

