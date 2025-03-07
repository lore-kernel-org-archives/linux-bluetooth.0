Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F023226D1D
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370529; cv=pass; b=LnLTQ30LlnnC/BDftBYUNLnlPFNU6TqviR9U8H7sernTHgc6tkREFrYwQ39WzAw5mzKRe+dKi7VmPTGJmvRrYrtLzutrnCMjJJDDj/PzRkhCOvgmWFBzcGGa5E+IZdCL+ypgYsCdL+iMIdptfiMwFbUSR7NXVBPYw7UI59z2GVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370529; c=relaxed/simple;
	bh=ingKNGgrafJeyB8CphgJLmFQPmYlJEKviX6Rpk3AjQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTjh74/T8q1796+iCT8eBVZLUe50kkQCqbi5NvWeLVzhEHSfsoHO5biAeLH+3YbQdy+9rBxKG0vn041OaaaRw+lgH3ipzmeJZsFNttcPr3p99XgpJ3xRe2wT3opfjhXzL8k4+fD/q/IIf/my8GaRz/EasYsH2qYS3kXUFrS0zQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BfWuH0Z+; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BfWuH0Z+"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Z8Yyb1qDgz103W;
	Fri,  7 Mar 2025 20:01:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1741370520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADY6fRBrm6ktynVpo1nOXmj14nqagKe6lrW6MOuduw0=;
	b=BfWuH0Z+Iy6Ly22eAht/eDjCUOPouMpbOK+ZVBKqDh6q+o9T4lwpKG/Feeiq5GdWPHDs7J
	6L6HN9J+2vZFzoMsLGkrzkIRzLQ0ddJPD7BOkFWXnnwEGVXdfgnboN9E/MD01g15FsnAn1
	PoGJfujfGsPedHuXw4Rfs7FC6+6eEqs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1741370520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADY6fRBrm6ktynVpo1nOXmj14nqagKe6lrW6MOuduw0=;
	b=QZINk8oIo+mbm9Ku6UNSyFrxeRbNCohFn+BCELffHSKYzrYOYxjxKTuL8k8sydWmMDug3S
	eTKZLQcYhoo2ZX4tBis0efqXJOKYKGIeOa+DwitoZqEb2olf6bI6R1QKz7XfpGSGl3x9by
	6wS3BtWVPCErWVsfczGghncgXSIn660=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1741370520; a=rsa-sha256; cv=none;
	b=mQk8SCVVj5EFs5pEesCanmWrlHm2ARgXoVD7i/3IMRbcRpCameNb+3x7IwuwWqYNFJIBYQ
	F5itMshFAout7QRXNnvzZ9N0zOd5h3uHu4ECt7Fb/IJRBPMMVOpOPqYrLzJPjQee1/QfPE
	Y/Zo5VEBldZmUYu7+H4ifSxLKUEUnsc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 5/6] btdev: support disabling commands
Date: Fri,  7 Mar 2025 20:00:58 +0200
Message-ID: <ce4f50612ac11f8de42ce8093adb1e03e1fb4fe4.1741370367.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
References: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add function to return command mask, so that it is possible to disable
some in tests if needed.
---
 emulator/btdev.c  |  5 +++++
 emulator/btdev.h  |  2 ++
 emulator/hciemu.c | 14 ++++++++++++++
 emulator/hciemu.h |  1 +
 4 files changed, 22 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index bd8ea0d7f..976c1125d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -7406,6 +7406,11 @@ uint8_t *btdev_get_features(struct btdev *btdev)
 	return btdev->features;
 }
 
+uint8_t *btdev_get_commands(struct btdev *btdev)
+{
+	return btdev->commands;
+}
+
 uint8_t btdev_get_scan_enable(struct btdev *btdev)
 {
 	return btdev->scan_enable;
diff --git a/emulator/btdev.h b/emulator/btdev.h
index cad5f699f..a96c1a325 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -76,6 +76,8 @@ bool btdev_set_bdaddr(struct btdev *btdev, const uint8_t *bdaddr);
 
 uint8_t *btdev_get_features(struct btdev *btdev);
 
+uint8_t *btdev_get_commands(struct btdev *btdev);
+
 uint8_t btdev_get_scan_enable(struct btdev *btdev);
 
 uint8_t btdev_get_le_scan_enable(struct btdev *btdev);
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index f13b4bda1..ccc57aada 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -528,6 +528,20 @@ uint8_t *hciemu_get_features(struct hciemu *hciemu)
 	return btdev_get_features(dev);
 }
 
+uint8_t *hciemu_get_commands(struct hciemu *hciemu)
+{
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return NULL;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return NULL;
+
+	return btdev_get_commands(dev);
+}
+
 const uint8_t *hciemu_get_central_bdaddr(struct hciemu *hciemu)
 {
 	struct btdev *dev;
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index dba920fdd..9fbe34316 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -55,6 +55,7 @@ void hciemu_flush_client_events(struct hciemu *hciemu);
 
 const char *hciemu_get_address(struct hciemu *hciemu);
 uint8_t *hciemu_get_features(struct hciemu *hciemu);
+uint8_t *hciemu_get_commands(struct hciemu *hciemu);
 
 const uint8_t *hciemu_get_central_bdaddr(struct hciemu *hciemu);
 const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
-- 
2.48.1

