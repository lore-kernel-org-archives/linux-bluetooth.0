Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA4194094
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918015; cv=none; b=DsNGXW1wMHBA+ZschQo4fOd4PW4mEYRIV3Xvjq45HaJJnDRE64Rvb6mVxows+MMtzFWvGT8cOv7qZIG5/AWi8qYOkW9LZtiSZs/s6r5MRD4ILKpeCCQ0xC2c+/GSoUBp/UxHQD/YlJMyPKpsVQWL6DezlvfsGkEy8EA6Oku4YYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918015; c=relaxed/simple;
	bh=S/tjsQBr9leYAKPE1nH7q9li1LTGI671QC+SQpsdYFE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=M6R5jlQhZjg5BPVRJKKp1lXtvlz2c/Xe8ogP2CxteRg7s350onx6+ofzUFTkPmFcTqWssPiJujGAw4tP2L9tFUoKvpRQ1a9EKwlGRPO0dJ3nHFwuSFfIz+pSLPgqd+0zhLhTW379ibJzIeXx/+odEvt+i5z+77jAwKrJ6lv4/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAzxrWcK; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAzxrWcK"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-87ed3b792a2so724225241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751918011; x=1752522811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BL3fql8G0KsDfjFnAqFxd9UgceBi0B/Qdqgep9AXpF0=;
        b=IAzxrWcKwNumFy6Sf4jta1Cpcam63FupZdbtWt3wefD4WXLrdvNRED//sRzXRx+hcW
         NqDfBzFmDYAYf4Es4y71i3+JsmiDJ8BGQKrLatlK40FCFto7v3Pz5yKiBT6Ff8v9SQhH
         7+ar+AsR3Psu/Ix1gu/65bZPSIwVeYtruis5lGYxRHTReDT8rrP+KXUROzQaR7p6iowO
         hp/oVZfOfA4O9aWNg5pdNwLiyFesZbEZXRB+HQJzeZNOKkiYkWHetqMusvSj29XHOBkq
         Mf4liEgnFblZCTvGuIgtHFnCAtrby+1xf36sU9STg5Esy+w9TNzTlf7bPi598Ab1Y6KS
         282Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751918011; x=1752522811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BL3fql8G0KsDfjFnAqFxd9UgceBi0B/Qdqgep9AXpF0=;
        b=h0YpQCO2Banl1tD/GLDpiVueyFk7pbrv45E7khttYsnjDKqo01g/+VED8roPdYoZbt
         mVWZp+4i0yCy5eI1Owbv5HNgZpgeX4TvCNk6X6D/uAKaTEn6apKWyoot5BjLijTRsfA2
         az+J1VUQCFmfqnT1x7lmCBoSUJKrn55evCdxAButTHDJ10g+DVl46lESsFwFLNn4DblF
         LQuS7ol/FdT6t1reMySo1fFeWxXzvL/GqI8xI4+hHYfZDA+r/Yp5/s8fvmTlj8clcbUv
         QwrV5KGzAXoVXeFDKiW3bYgvBBUXs+UYVirnnYB4eRKy+JZ+Y+Pzj7CYAeCGE8xG1ejS
         azKQ==
X-Gm-Message-State: AOJu0YxvWxsO1hK4/kNZwEOOAb1kTVs28YnAENiOSUpsA3UWt2x0nTzu
	hcTxTJ/YGjqGSTfCXEVAEmq7QrsSxpbeIgdY8P10xDCl4sBkWbihGYvjJJRKfs7l
X-Gm-Gg: ASbGncsL9MLdY5NHYKz7XHBPuutczNAGGwcpyKLA0qHx6GVDQ2Lj3I1zsB1XiX1k/+o
	IRPPmwQ0OFchrELgbS36jX9r1qqw6YOffaz6jjVcQPWqZXr2wEcfB4gWA4krxuX5pznTpThqJhz
	F2m5+205DVD4G1XwzOPkIbI1/s2Yi3Gsq1I9BkxngM7dsoREhtN30dVmOndR/3Sxzk9jIwqpNkl
	WTAzxvJKcKnPYS6XCHga3+mJPNYf8eFiplMgYqpIYNVaufYhsEneihF7VVwj2fn2JFiES3cPgqc
	7JIS7zC5HReidDMpZQqKO/scY4O/wcv2emLTLESNA6I4J5INF+9TELQ0fBf3jHW/Yq0naijsZMs
	rKQ68icJQg1ZpoQaRM7Xw7ptM7HLcci6F910lVhQ=
X-Google-Smtp-Source: AGHT+IF0GyIVojIE8R+m+hhwwBU47VqAeLaOnyoxIa2EEGEbH1cNIxTiqI61KtsC439H+2Fnc+A8jQ==
X-Received: by 2002:a05:6102:30c7:10b0:4ea:d7bf:8b32 with SMTP id ada2fe7eead31-4f2ee257735mr6796364137.21.1751918011019;
        Mon, 07 Jul 2025 12:53:31 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f2ea543116sm1190662137.9.2025.07.07.12.53.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 12:53:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc: Add org.bluez.Device.LE and org.bluez.Device.BREDR
Date: Mon,  7 Jul 2025 15:53:24 -0400
Message-ID: <20250707195324.2615368-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bearer specific interfaces so they can properly be operated
separately.

Fixes: https://github.com/bluez/bluez/issues/1350
---
 Makefile.am                    |   3 +
 doc/org.bluez.Device.BREDR.rst | 137 ++++++++++++++++++++++++++++++++
 doc/org.bluez.Device.LE.rst    | 138 +++++++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 doc/org.bluez.Device.BREDR.rst
 create mode 100644 doc/org.bluez.Device.LE.rst

diff --git a/Makefile.am b/Makefile.am
index c4b88d83c962..6d5c6b9eebfc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -358,6 +358,7 @@ if MANPAGES
 man_MANS += src/bluetoothd.8
 man_MANS += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
+		doc/org.bluez.Device.LE.5 doc/org.bluez.Device.BREDR.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
 		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
@@ -392,6 +393,7 @@ endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
+		doc/org.bluez.Device.LE.5 doc/org.bluez.Device.BREDR.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
 		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
@@ -470,6 +472,7 @@ EXTRA_DIST += doc/health-api.txt \
 EXTRA_DIST += doc/hci.rst doc/mgmt.rst doc/l2cap.rst doc/rfcomm.rst doc/sco.rst
 
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
+		doc/org.bluez.Device.LE.rst doc/org.bluez.Device.BREDR.rst \
 		doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
 		doc/org.bluez.Agent.rst doc/org.bluez.ProfileManager.rst \
 		doc/org.bluez.Profile.rst doc/org.bluez.NetworkServer.rst \
diff --git a/doc/org.bluez.Device.BREDR.rst b/doc/org.bluez.Device.BREDR.rst
new file mode 100644
index 000000000000..e1aa883b8342
--- /dev/null
+++ b/doc/org.bluez.Device.BREDR.rst
@@ -0,0 +1,137 @@
+======================
+org.bluez.Device.BREDR
+======================
+
+-------------------------------------------------
+BlueZ D-Bus Device BREDR bearer API documentation
+-------------------------------------------------
+
+:Version: BlueZ
+:Date: July 2025
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.Device1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
+
+Methods
+-------
+
+void Connect() [experimental]
+`````````````````````````````
+
+Connects all BREDR profiles the remote device supports that can be connected to
+and have been flagged as auto-connectable. If only subset of profiles is already
+connected it will try to connect currently disconnected ones.
+
+If at least one profile was connected successfully this method will indicate
+success.
+
+Possible errors:
+
+:org.bluez.Error.NotReady:
+:org.bluez.Error.Failed:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.AlreadyConnected:
+
+void Disconnect() [experimental]
+````````````````````````````````
+
+Disconnects all connected profiles and then terminates low-level ACL connection.
+
+ACL connection will be terminated even if some profiles were not disconnected
+properly e.g. due to misbehaving device.
+
+This method can be also used to cancel a preceding Connect call before a reply
+to it has been received.
+
+For non-trusted devices connected calling this method will disable incoming
+connections until Connect method is called again.
+
+Possible errors:
+
+:org.bluez.Error.NotConnected:
+
+Signals
+-------
+
+void Disconnected(string reason, string message) [experimental]
+```````````````````````````````````````````````````````````````
+
+This signal is launched when a device is disconnected, with the reason of the
+disconnection.
+
+This could be used by client application, depending on internal policy, to try
+to reconnect to the device in case of timeout or unknown disconnection, or to
+try to connect to another device.
+
+Possible reasons:
+
+:org.bluez.Reason.Unknown:
+
+:org.bluez.Reason.Timeout:
+
+	Connection timeout.
+
+	The link supervision timeout has expired for a connection or the
+	synchronization timeout has expired for a broadcast.
+
+:org.bluez.Reason.Local:
+
+	Connection terminated by local host.
+
+	The local device terminated the connection, terminated synchronization
+	with a broadcaster, or terminated broadcasting packets.
+
+:org.bluez.Reason.Remote:
+
+	Connection terminated by remote host.
+
+	This disconnection can be due to:
+
+	- the user on the remote device either terminated the connection or
+	  stopped broadcasting packets,
+
+	- the remote device terminated the connection because of low
+	  resources,
+
+	- the remote device terminated the connection because the device is
+	  about to power off.
+
+:org.bluez.Reason.Authentication:
+
+	Connection terminated due to an authentication failure.
+
+:org.bluez.Reason.Suspend:
+
+	Connection terminated by local host for suspend.
+
+Properties
+----------
+
+boolean Paired [readonly, experimental]
+```````````````````````````````````````
+
+Indicates if the remote device is paired to BREDR bearer.
+
+Paired means the pairing process where devices exchange the information to
+establish an encrypted connection has been completed.
+
+boolean Bonded [readonly, experimental]
+```````````````````````````````````````
+
+Indicates if the remote device is bonded to BREDR bearer.
+
+Bonded means the information exchanged on pairing process has been stored and
+will be persisted.
+
+boolean Connected [readonly, experimental]
+``````````````````````````````````````````
+
+Indicates if the remote device is currently connected to BREDR bearer.
+
+A PropertiesChanged signal indicate changes to this status.
diff --git a/doc/org.bluez.Device.LE.rst b/doc/org.bluez.Device.LE.rst
new file mode 100644
index 000000000000..dceec59f565a
--- /dev/null
+++ b/doc/org.bluez.Device.LE.rst
@@ -0,0 +1,138 @@
+===================
+org.bluez.Device.LE
+===================
+
+----------------------------------------------
+BlueZ D-Bus Device LE bearer API documentation
+----------------------------------------------
+
+:Version: BlueZ
+:Date: July 2025
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.Device1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
+
+Methods
+-------
+
+void Connect() [experimental]
+`````````````````````````````
+
+Connects all LE profiles the remote device supports that can be connected to and
+have been flagged as auto-connectable. If only subset of profiles is already
+connected it will try to connect currently disconnected ones.
+
+If at least one profile was connected successfully this method will indicate
+success.
+
+Possible errors:
+
+:org.bluez.Error.NotReady:
+:org.bluez.Error.Failed:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.AlreadyConnected:
+
+void Disconnect() [experimental]
+````````````````````````````````
+
+Disconnects all connected profiles and then terminates low-level ACL-LE
+connection.
+
+ACL-LE connection will be terminated even if some profiles were not disconnected
+properly e.g. due to misbehaving device.
+
+This method can be also used to cancel a preceding Connect call before a reply
+to it has been received.
+
+For non-trusted devices connected calling this method will disable incoming
+connections until Connect method is called again.
+
+Possible errors:
+
+:org.bluez.Error.NotConnected:
+
+Signals
+-------
+
+void Disconnected(string reason, string message) [experimental]
+```````````````````````````````````````````````````````````````
+
+This signal is launched when a device is disconnected, with the reason of the
+disconnection.
+
+This could be used by client application, depending on internal policy, to try
+to reconnect to the device in case of timeout or unknown disconnection, or to
+try to connect to another device.
+
+Possible reasons:
+
+:org.bluez.Reason.Unknown:
+
+:org.bluez.Reason.Timeout:
+
+	Connection timeout.
+
+	The link supervision timeout has expired for a connection or the
+	synchronization timeout has expired for a broadcast.
+
+:org.bluez.Reason.Local:
+
+	Connection terminated by local host.
+
+	The local device terminated the connection, terminated synchronization
+	with a broadcaster, or terminated broadcasting packets.
+
+:org.bluez.Reason.Remote:
+
+	Connection terminated by remote host.
+
+	This disconnection can be due to:
+
+	- the user on the remote device either terminated the connection or
+	  stopped broadcasting packets,
+
+	- the remote device terminated the connection because of low
+	  resources,
+
+	- the remote device terminated the connection because the device is
+	  about to power off.
+
+:org.bluez.Reason.Authentication:
+
+	Connection terminated due to an authentication failure.
+
+:org.bluez.Reason.Suspend:
+
+	Connection terminated by local host for suspend.
+
+Properties
+----------
+
+boolean Paired [readonly, experimental]
+```````````````````````````````````````
+
+Indicates if the remote device is paired to LE bearer.
+
+Paired means the pairing process where devices exchange the information to
+establish an encrypted connection has been completed.
+
+boolean Bonded [readonly, experimental]
+```````````````````````````````````````
+
+Indicates if the remote device is bonded to LE bearer.
+
+Bonded means the information exchanged on pairing process has been stored and
+will be persisted.
+
+boolean Connected [readonly, experimental]
+``````````````````````````````````````````
+
+Indicates if the remote device is currently connected to LE bearer.
+
+A PropertiesChanged signal indicate changes to this status.
-- 
2.50.0

