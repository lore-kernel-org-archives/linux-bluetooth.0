Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C27270578
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364934; cv=none; b=sJm9N9R3QiUdRso/o+qUDamXchaTbzwoVuWSb+Q1NM0DBSJF/BKE3ZjvJzcwYrhz3oAjjCsOfZ9frmRkXSE0xe/I3NOyWoKJste6eDiOkZ8aZ6C2mE/VDznqWaR2ltMA0IbgPFTXTbQtJuSPYd/E6LcCepFm3csgtaw/+S5G2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364934; c=relaxed/simple;
	bh=zCpydbdou9tIwZMbFmp31xvataLogLXFlYJdL8Zn48Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTLhLjwXrsNSaRA+eUBDe4rFkyh2XKUn4zwJ1yPdx8zyzXahiNPyNnsbIDmuN3KqZ+eKc+fBfYk9pf6jaeh9xMXzzMhqb607t/7mwOWpqNJQQf/V0dHaaWZrLj3STmfpOvWxG9iHsFiT/kxv6UxNt1Oy32dyvPffKLSRISw36Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 934E2438CE;
	Tue,  1 Jul 2025 10:15:30 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v4 4/8] error: Make errno to string helpers private
Date: Tue,  1 Jul 2025 12:14:25 +0200
Message-ID: <20250701101520.459452-5-hadess@hadess.net>
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

We're not using them outside the error code itself.
---
 src/error.c | 4 ++--
 src/error.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/error.c b/src/error.c
index 0e57a07548a9..74b8f80e63c5 100644
--- a/src/error.c
+++ b/src/error.c
@@ -134,7 +134,7 @@ DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
 					".Failed", "%s", str);
 }
 
-const char *btd_error_str_bredr_conn_from_errno(int errno_code)
+static const char *btd_error_str_bredr_conn_from_errno(int errno_code)
 {
 	switch (-errno_code) {
 	case EALREADY:
@@ -178,7 +178,7 @@ const char *btd_error_str_bredr_conn_from_errno(int errno_code)
 	}
 }
 
-const char *btd_error_str_le_conn_from_errno(int errno_code)
+static const char *btd_error_str_le_conn_from_errno(int errno_code)
 {
 	switch (-errno_code) {
 	case EINVAL:
diff --git a/src/error.h b/src/error.h
index 828cf5923f6f..0fa3975cff7c 100644
--- a/src/error.h
+++ b/src/error.h
@@ -88,6 +88,3 @@ DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno_code);
 DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_code);
-
-const char *btd_error_str_bredr_conn_from_errno(int errno_code);
-const char *btd_error_str_le_conn_from_errno(int errno_code);
-- 
2.50.0

