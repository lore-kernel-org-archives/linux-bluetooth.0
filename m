Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41C1531CB
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558952; cv=none; b=TgFanOemqwcj1O9P/A5jF5CyBHm0pUOXtcVUKFbdlCdDWI58ejQfxUEcH3U+gtj3hgtkR6nCbTQdr5e6kWyrvUVwbzL8G0fseS/wH3CuVyH+9VAjkEleyoHBvt4TozjDIq70cCN6xw2FXoveNi4HEW0MiU8q2EwsqfNmcYL8h/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558952; c=relaxed/simple;
	bh=gEWuxhGv6DQWM/f5KSXhlN++SrGJaN6FwEHyxQ1KIdA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk4afWU7lXh3Fk49zO24QGjL3x7iU9bNEsOATUpxFfI0rPfcyH16mDk+hNtBf5tOzwxzqbSTbSYHxSIa7PAr+OYd/M3ERGYc3kH5OVVOCrFUiZ+8WHgLWKU3BVsqS0cjGZxGCht+4tT6ZNCHjB8tTw/RGo7DlmZt5Lr/iK15FVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NP6k5Rb2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NP6k5Rb2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726558946;
	bh=gEWuxhGv6DQWM/f5KSXhlN++SrGJaN6FwEHyxQ1KIdA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NP6k5Rb2vLcCXfTgjx5q0kWYdUAJfeLJfAMbjmxqPm3XX90GF3cL9fu2CVpuVixom
	 H3K3NU8gZTvklAUWcCAk7inwRxIz2TQhZlZnOJ8lzJcA1yQXKmhhFn791PZIx9vZkT
	 Ld3yLNPADMtHrgToyJBuuzCVBgo88nlPjsA8hy/35CdXnJ8WAd2SONjAIp9JdqxMVB
	 3B4NYPS6fexVAGY4KK3KTn4SRUWQda8P+a11ROWpCnTHNzbvFXYfeLwc05F7DjUwva
	 TxoVfCvdKwhKMqHjzIscjFyVTmme3pPbkasOaMt9B9aGqWLKD06O7moAQuUXUqzCSk
	 e6C0YdMge/8YQ==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E142717E1034
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 09:42:25 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/5] doc: Add description of org.bluez.obex.Image
Date: Tue, 17 Sep 2024 09:42:17 +0200
Message-Id: <20240917074217.231677-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240917074217.231677-1-frederic.danis@collabora.com>
References: <20240917074217.231677-1-frederic.danis@collabora.com>
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
 Makefile.am                  |   9 ++-
 doc/org.bluez.obex.Image.rst | 118 +++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.obex.Image.rst

diff --git a/Makefile.am b/Makefile.am
index 88044aa05..3eb0a5302 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -382,7 +382,8 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.PhonebookAccess.5 \
 		doc/org.bluez.obex.MessageAccess.5 \
 		doc/org.bluez.obex.Message.5 \
-		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5
+		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
+		doc/org.bluez.obex.Image.5
 endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/l2cap.7 doc/rfcomm.7
@@ -415,7 +416,8 @@ manual_pages += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.PhonebookAccess.5 \
 		doc/org.bluez.obex.MessageAccess.5 \
 		doc/org.bluez.obex.Message.5 \
-		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5
+		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
+		doc/org.bluez.obex.Image.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -497,7 +499,8 @@ EXTRA_DIST += doc/org.bluez.obex.Client.rst doc/org.bluez.obex.Session.rst \
 		doc/org.bluez.obex.PhonebookAccess.rst \
 		doc/org.bluez.obex.MessageAccess.rst \
 		doc/org.bluez.obex.Message.rst \
-		doc/org.bluez.obex.AgentManager.rst doc/org.bluez.obex.Agent.rst
+		doc/org.bluez.obex.AgentManager.rst doc/org.bluez.obex.Agent.rst \
+		doc/org.bluez.obex.Image.rst
 
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
diff --git a/doc/org.bluez.obex.Image.rst b/doc/org.bluez.obex.Image.rst
new file mode 100644
index 000000000..386805203
--- /dev/null
+++ b/doc/org.bluez.obex.Image.rst
@@ -0,0 +1,118 @@
+====================
+org.bluez.obex.Image
+====================
+
+--------------------------------------------------
+BlueZ D-Bus OBEX Image API documentation
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
+:Interface:	org.bluez.obex.Image1 [experimental]
+:Object path:	[Session object path]
+
+Methods
+-------
+
+object, dict Get(string targetfile, string handle, dict description)
+````````````````````````````````````````````````````````````````````
+
+    Retrieves the image corresponding to the handle and the description, as
+    one of the descriptions retrieved by GetImageProperties, and store it in
+    a local file.
+
+    If the "transform" property description exists it should be set to one
+    of the value listed by GetImageProperties for this description.
+
+    If description is an empty dict, the native image will be retrieved.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+array{dict} Properties(string handle)
+`````````````````````````````````````
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
+	Possible property values:
+
+	:string type:
+
+		Type of dict properties. Mandatory for each dict.
+
+		Possible values:
+
+		:"native":
+		:"variant":
+
+	:string encoding:
+
+		File encoding format.
+
+		Possible values:
+
+        :"BMP":
+        :"GIF":
+		:"JPEG":
+        :"JPEG2000":
+		:"PNG":
+        :"WBMP":
+
+	:string pixel:
+
+		File encoding format size of form "<width>*<height>".
+
+	:uint64 size:
+
+		File size.
+
+	:uint64 maxsize:
+
+		File maximum size.
+
+	:string transformation:
+
+		List of available transformations separated by space.
+
+		Possible values:
+
+		:"crop":
+		:"fill":
+		:"stretch":
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+object, dict GetThumbnail(string targetfile, string handle)
+```````````````````````````````````````````````````````````
+
+    Retrieves the image thumbnail corresponding to the handle and store it in
+    a local file.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
-- 
2.34.1

