Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288162DAFAE
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994865; cv=none; b=or7Y468yhL0jTDPw2DZqJcbSbXrIb0NjPCEMENrnXi1T/BXc8D/qOnm5MOFOPL6avBHsXzWNg8Tkhr5NtqK6ghAhP/8+ruGWL1STdC3nPVld4O1ZQbUha9wjejClAQup1aNSXHLqUhTK6wbJRxfpLAyfbWzXtmwXb0AlrBUbzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994865; c=relaxed/simple;
	bh=5l+CvIrP5ElZ/MvuRjHrX3Ty4OTy5yLribtt2IbwAl4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q7mfckQEp6/FOFY7jboslH46gDRw7V8vseAVT5DnTn2Tvm2Ko+Wocb9MHpXgFFJP1qw89wvYzCOBUfgwlRDxja/DoQbVRCWE/DDVnv8kJZT2jXQiZZNScqJuKIZTTWecNwzku/6uRBi2GJVk5c2LBniG/p6Iq8RqIWw2cYGP18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBC6644354
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:14:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Fix typo in configure option help string
Date: Tue,  8 Jul 2025 19:14:08 +0200
Message-ID: <20250708171411.1927181-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffelueffjedvueefffdvjeejvdehkefgledtjefhiedtteetgfejvdeuvdfhjeeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index ab2c6716eb3a..d1245a31e313 100644
--- a/configure.ac
+++ b/configure.ac
@@ -167,7 +167,7 @@ AC_ARG_ENABLE(test, AS_HELP_STRING([--enable-test],
 AM_CONDITIONAL(TEST, test "${enable_test}" = "yes")
 
 AC_ARG_ENABLE(nfc, AS_HELP_STRING([--enable-nfc],
-		[enable NFC paring]), [enable_nfc=${enableval}])
+		[enable NFC pairing]), [enable_nfc=${enableval}])
 AM_CONDITIONAL(NFC, test "${enable_nfc}" = "yes")
 
 AC_ARG_ENABLE(sap, AS_HELP_STRING([--enable-sap],
-- 
2.50.0

