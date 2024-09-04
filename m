Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85621DAC4A
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458675; cv=none; b=MDnM2Vvdt1Bmcxd/UNbRboyQe3lAyV/Cw1zQEASSuJ4kAPT6j3ucicuAdsK8ZAO57OUxXb67IXBFMe+TzMwXYlGsTWdYkWg8edfHrelIFuPzGaIxgcOkw5mBU62co239WNuFI4xTn+NkU0tmZM5UOCo1Oaq+zhkp87eRSWUnwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458675; c=relaxed/simple;
	bh=A8blzmq+E/iQiMBT2QXVr7kNSoQNuLnPaLeHK5dL2mk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzguVp2lH+4k8Rycar1GB0gZyphAQF6cqRogvmLr3aZNr5JAhYcs5LL1jcAhOWoCMk3d4iMIcXRVjDyi6QM4/L9ixN302FP/4u4Wv9kH4QDotRaMbyAVUgHyVL88X71mWFDJptshieZqgLDad8vN4o6kJxjL6lAlJ9AXs5P8D2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WflALX2U; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WflALX2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725458669;
	bh=A8blzmq+E/iQiMBT2QXVr7kNSoQNuLnPaLeHK5dL2mk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WflALX2UK4xr4XlWm0+mBAhelagFdPj5+FLoLfZb8utqX3bwz9H3LC1ZBQtOhgsTs
	 f7CPxqNomYeqPZcrHVNk8Ell/k2FXmBDUCfQbH2OPTvcJCbB4WbI1jSwtPnHO0ZZDr
	 mRy0KBm6Ke3epjJKbQ1zLi9h9SUvxKV+k9vMgf4xcRfSM64VSfpjl7EQvn5zD4pdNc
	 MqFXQD7vyDD6b4Uv9ZEy1MmRhkSNxl7b+1Wjt1SEzMk0JS/51hA0SduHfSDQpRql57
	 zl4uKcxTY9c1tblnXEND/4NYYxOdpfIDp//Nc+lW50m4fR9zM3nE5FJ6WFvh7czk7I
	 A1fRngCT4rPig==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CEA7E17E1166
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 16:04:29 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] doc: Add description of org.bluez.obex.BipAvrcp
Date: Wed,  4 Sep 2024 16:04:21 +0200
Message-Id: <20240904140421.283166-8-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904140421.283166-1-frederic.danis@collabora.com>
References: <20240904140421.283166-1-frederic.danis@collabora.com>
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
index 46a8cfb49..12c37329c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -379,7 +379,8 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.PhonebookAccess.5 \
 		doc/org.bluez.obex.MessageAccess.5 \
 		doc/org.bluez.obex.Message.5 \
-		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5
+		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
+		doc/org.bluez.obex.BipAvrcp.5
 endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/l2cap.7 doc/rfcomm.7
@@ -412,7 +413,8 @@ manual_pages += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.PhonebookAccess.5 \
 		doc/org.bluez.obex.MessageAccess.5 \
 		doc/org.bluez.obex.Message.5 \
-		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5
+		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
+		doc/org.bluez.obex.BipAvrcp.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -494,7 +496,8 @@ EXTRA_DIST += doc/org.bluez.obex.Client.rst doc/org.bluez.obex.Session.rst \
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
index 000000000..0b6103969
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
+:Interface:	org.bluez.obex.BipAvrcp1
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

