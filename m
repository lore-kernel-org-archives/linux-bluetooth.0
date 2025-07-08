Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3721767A
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970270; cv=none; b=GSjrORbdgim7iu/gtC9W7mTJKq6Ana1e6y2uDKak2BQZk4iZfOUi9oluw1a2s+AS63zpd8MMK5x4TG9PNXdf6iDAH7++PL/UIdeI0UMhZ/er7rPNvwBbCRIpiVoleU798QBK0zXGR9ZiKIKdF4Nvgz/Jxfi0obWb1bJPaSSplGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970270; c=relaxed/simple;
	bh=ElVoLWup8CoWP4rpRdiXjD7z16DlGFhN3jdav0Sq/BI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzH6Kyqqz5Cnta67m/TCXkz7lNHsNPE9NGHERwpBqGaOH1Kbxl0oPffmw2MQsZwVBKo9FTDIWSNlehhTVZXGm86O2Zca7kAWxblKLlqea9Kut5YFL8MhtK80gHIw6ry1XlimZY8FlEwiYgy3VVY/HY5oktzSfL1wla5w3lpVhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA1D2438F0
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 10:24:26 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] build: Remove deleted files from .gitignore
Date: Tue,  8 Jul 2025 12:24:09 +0200
Message-ID: <20250708102418.1863891-2-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708102418.1863891-1-hadess@hadess.net>
References: <20250708102418.1863891-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepkeetteegtedtheeiudeitddtteffleelhedtjeekleeuvdfgffdvveetteduhfeknecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

As all the android support was removed in
f0512114aacf ("Remove android support").
---
 .gitignore | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/.gitignore b/.gitignore
index 108c3b820a7f..155a65c5a5d5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -174,17 +174,6 @@ unit/test-vcp
 unit/test-*.log
 unit/test-*.trs
 
-android/system-emulator
-android/bluetoothd
-android/avdtptest
-android/haltest
-android/android-tester
-android/ipc-tester
-android/bluetoothd-snoop
-android/test-ipc
-android/test-*.log
-android/test-*.trs
-
 compile_commands.json
 cscope.in.out
 cscope.out
-- 
2.50.0

