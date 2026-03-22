Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C137F725
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215025; cv=pass; b=b4DldAk6I/iakcnsUPewJf/fz/at8JK7Dh4qOZLVv+dVlYe3ChspG/H3lBGLqZP91dV2QIKuVipVJxcgusK3ETKiHf5oRKwMZ4Uga8h4TkUu/eknFpRq7qRUGo+f9gfbnuyRP/llMqZMWCiOI1X8ILhM7w7juCx5Sh5jIfmqVXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215025; c=relaxed/simple;
	bh=ISKrlIYuEWro/9lX/ytK0xZCWwSiuJ6gpEn5YXD2Bho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcxtCtsXCtmo/hPPMQGDYCQVAJpCn+eJZI8Ka+4inCoLBuHvmzqHlwqu+St1Sre5lB/JQAU6cKe7/jGOfOIb28YExzijdgkbrwpawP2w0GeQ6VeFIinyitlbvCCQBZGSjAIuyzeD9ITtGcVVNvbAcaMkfW8j4B0rRFKMcV+aGiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=U7Y2zIAC; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="U7Y2zIAC"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ff8bW0HS9zyvJ;
	Sun, 22 Mar 2026 23:30:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774215015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QFAKJpmbOODJkGZVG9u64BvaO3fOqu7Q+0F65XvjIM=;
	b=U7Y2zIACAdQE1m94Y8MVrrb9GKoK//MioQCjS//NJU/qv0OOH95Ez/5AjuuRA8NevxyJu5
	TMd629dKQx6/Dav13VRhrmPS8Q9PZBbDCBRjS8tmnUBZiJJXBFZ0sLFN9z/eHeknjU1Huz
	8+koej9oud3lTc78Db72tldP1rAAZkA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774215015;
	b=RhVIiDDBBi8V2p5UQsVgSmNY2riPhk1CiE3YrlCDEHAYlF7u2O9r1+7xM1igO1F0EscNmQ
	QnW/Gw1JA4rMklu7mUvYGtnx+KXVB5rE4ucQRowrcI5dlTl3ObzEvYhT+E575AR4bHq9Z1
	ATZRrYWO++WHwGJ7n8KH6uvWYufFwag=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774215015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QFAKJpmbOODJkGZVG9u64BvaO3fOqu7Q+0F65XvjIM=;
	b=wK3z8zF/iJaxYfzRyCGAplIy+8g9m3Zy9dYYXCfG6FLt6peLMZBdRLN6oiKTRVGrBXoUZw
	mAyN+ImWl8bVMn6/y2Ue2VsKixykNPJVt2KkqI22aqe+g+s9NjUy4vQ0YEajz/lmuX6H7O
	IWSHLVj4LrRiEKMgJ7bQzsYrDHXmXZs=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 08/20] doc: enable CONFIG_VIRTIO_CONSOLE in tester config
Date: Sun, 22 Mar 2026 23:29:57 +0200
Message-ID: <a3b0ea0154cf5184060a6ca6f319a5ff6539b161.1774214693.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable kernel option that allows using -device virtserialport in qemu.
This is easier to make work reliably than pci-serial channel.
---
 doc/ci.config       | 1 +
 doc/test-runner.rst | 1 +
 doc/tester.config   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/doc/ci.config b/doc/ci.config
index 31e49ba96..a48c1af9d 100644
--- a/doc/ci.config
+++ b/doc/ci.config
@@ -6,6 +6,7 @@
 
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_CONSOLE=y
 
 CONFIG_NET=y
 CONFIG_INET=y
diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 64715e2e7..d030787a4 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -45,6 +45,7 @@ option (like the Bluetooth subsystem) can be enabled on top of this.
 
 	CONFIG_VIRTIO=y
 	CONFIG_VIRTIO_PCI=y
+	CONFIG_VIRTIO_CONSOLE=y
 
 	CONFIG_NET=y
 	CONFIG_INET=y
diff --git a/doc/tester.config b/doc/tester.config
index 4ee306405..015e7cc1a 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -1,6 +1,7 @@
 CONFIG_PCI=y
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_CONSOLE=y
 
 CONFIG_NET=y
 CONFIG_INET=y
-- 
2.53.0

