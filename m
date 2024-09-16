Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78562156F57
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493312; cv=none; b=khqI6REebtWPlKj0gH6IrGicX6gq8nJcxR5Ef5A5gKOg5WzeBjnuOj16XGdJKGPKtrtFnHPktVuRNZ2Uo8AV28abW05DwXjljbV2iwlr8fOMMUdG34Khm/M6S24qdpbvAVHyqme4wHlNrUxiSVjdrSTYjMNkOfSjg2YgUFONN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493312; c=relaxed/simple;
	bh=Xws2x5vTC4bCXGRYndHuuAiGQVgXfiPyG+VzH86zf0Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1hZFFZVJCTvz/IqMHK1D8cC3ghdKFEhING0iD2Rf3SQgpOAwaAP5NQA0jldXiyQ8V2MoVxTPmfPqHO/o4fB6Q7sWZpuFs61qCq4thwPdO+Hep91hI4y2ACQ9HB0KzpAHE6FzRSNDivJqqqVZ9jH5GkQsotPAuy8ioEtRUKGTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Aw9d/efQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Aw9d/efQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726493300;
	bh=Xws2x5vTC4bCXGRYndHuuAiGQVgXfiPyG+VzH86zf0Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Aw9d/efQQ8ouAB28LPxzs2iIG4PTiJSOZfricwk1xC826hBGNyu8awrvz1wWabLYj
	 aUDumIMDMDA5M0zSjSIX9G3PyctIFR4Yh+CS8hZpe0uU5BBmPwyIfs4bX6jTrS0D/9
	 +I5Vn6JYsSvcKJImRv007/TCFpGYnkPs0Y5p8xztsuWi2DoCaF4DVpREuIV4IanJ2I
	 l2tvKNFJ84hQNcZT6fMewQdlN/ZoUzXgNtTqEUDhaW1Ig2zKHvmE+r1e5yQ3XBbp6T
	 HVjw1dCDy29h+mpsZv/ciSzAQNKo6GVITwKJ+H6MGZvt4PSy0sO/Pq83AXMCfyc+V9
	 L6LHuOa1Ak3ag==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5177817E35D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:28:20 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 9/9] doc: Add description of org.bluez.obex.BipAvrcp
Date: Mon, 16 Sep 2024 15:28:13 +0200
Message-Id: <20240916132813.165731-10-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916132813.165731-1-frederic.danis@collabora.com>
References: <20240916132813.165731-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This new interface allows to get the image referenced in the audio
metadata ImgHandle available in org.bluez.MediaPlayer track properties.
The image handle is only available in track info if an OBEX session is
connected to the ObexPort port provided in  org.bluez.MediaPlayer
properties.
---
 Makefile.am                     |  9 +++--
 doc/org.bluez.obex.BipAvrcp.rst | 72 +++++++++++++++++++++++++++++++++
 doc/org.bluez.obex.Client.rst   |  1 +
 3 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.obex.BipAvrcp.rst

diff --git a/Makefile.am b/Makefile.am
index 88044aa05..3a9728782 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -382,7 +382,8 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.PhonebookAccess.5 \
 		doc/org.bluez.obex.MessageAccess.5 \
 		doc/org.bluez.obex.Message.5 \
-		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5
+		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
+		doc/org.bluez.obex.BipAvrcp.5
 endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/l2cap.7 doc/rfcomm.7
@@ -415,7 +416,8 @@ manual_pages += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.PhonebookAccess.5 \
 		doc/org.bluez.obex.MessageAccess.5 \
 		doc/org.bluez.obex.Message.5 \
-		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5
+		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
+		doc/org.bluez.obex.BipAvrcp.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -497,7 +499,8 @@ EXTRA_DIST += doc/org.bluez.obex.Client.rst doc/org.bluez.obex.Session.rst \
 		doc/org.bluez.obex.PhonebookAccess.rst \
 		doc/org.bluez.obex.MessageAccess.rst \
 		doc/org.bluez.obex.Message.rst \
-		doc/org.bluez.obex.AgentManager.rst doc/org.bluez.obex.Agent.rst
+		doc/org.bluez.obex.AgentManager.rst doc/org.bluez.obex.Agent.rst \
+		doc/org.bluez.obex.BipAvrcp.rst
 
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
diff --git a/doc/org.bluez.obex.BipAvrcp.rst b/doc/org.bluez.obex.BipAvrcp.rst
new file mode 100644
index 000000000..46b12f645
--- /dev/null
+++ b/doc/org.bluez.obex.BipAvrcp.rst
@@ -0,0 +1,72 @@
+=======================
+org.bluez.obex.BipAvrcp
+=======================
+
+--------------------------------------------------
+BlueZ D-Bus OBEX BipAvrcp API documentation
+--------------------------------------------------
+
+:Version: BlueZ
+:Date: August 2024
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.BipAvrcp1 [experimental]
+:Object path:	[Session object path]
+
+Methods
+-------
+
+object, dict GetImage(string targetfile, string handle, dict description)
+`````````````````````````````````````````````````````````````````````````
+
+    Retrieves the image corresponding to the handle and the description, as
+    one of the descriptions retrieved by GetImageProperties, and store it in
+    a local file.
+
+    If the "transform" property description exists it should be set to one
+    of the value listed by GetImageProperties for this description.
+
+    If description is an empty dict, the native image will be retrieved;
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+array{dict} GetImageproperties(string handle)
+`````````````````````````````````````````````
+
+    Retrieves the image properties corresponding to the handle.
+
+    The first dict entry is mandatory and correspond to 'handle' and 'name'
+    of the image.
+
+    The second dict entry is mandatory and correspond to the native description
+    ('type':'native') of the image.
+
+    The following dict entries are optional and correspond to variant
+    descriptions of the image. If the 'transform' entry exists in the
+    description, it lists the available possible image transformations and
+    should be set to one of them before using the description as parameter
+    to GetImage.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+object, dict GetImageThumbnail(string targetfile, string handle)
+````````````````````````````````````````````````````````````````
+
+    Retrieves the image thumbnail corresponding to the handle and store it in
+    a local file.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
diff --git a/doc/org.bluez.obex.Client.rst b/doc/org.bluez.obex.Client.rst
index 5ae7cc5e8..f20dd5baa 100644
--- a/doc/org.bluez.obex.Client.rst
+++ b/doc/org.bluez.obex.Client.rst
@@ -43,6 +43,7 @@ object CreateSession(string destination, dict args)
 		:"opp":
 		:"pbap":
 		:"sync":
+		:"bip-avrcp":
 
 	:string Source:
 
-- 
2.34.1

