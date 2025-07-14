Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827B231A32
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525335; cv=none; b=XLUl7+NpV8e4Qt9Qe2CH3tjVf1WZoEdvWPpW/C1bD74V9KinllFKtjCpuL34H8/L/hA3UOUoYsLYLIzZk66HwAgR8jX6hT/FfHe6QL0WdGQHSDSIx/IeZz6Hl1KSy20V2Qsb7SGW41nIj1SY9C02ioUj5e6Eszv98MAjr0CscMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525335; c=relaxed/simple;
	bh=ka34F85oaOsniEltT86W3/M4ehIhTyhDMp+jdu+4niY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTtw59N73YLKQlOTG44/9Ga1NNQedkhKnYbt3VxIDzi/j3CNTZn9K517iP7dITw+piELh0oC0f9pZGiovUyuhrWk/v8zGBJyZIF8HJ3gyvABmFGXDastik1upgxrA3wbU4qpxL08pU9sftw1Go/e+SW5nkpQhJ9nstNhEt1XuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6Q+Sd5X; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6Q+Sd5X"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-88150e9fba7so4110372241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752525332; x=1753130132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPAJ1J/iGPQmJ/KL3FDDL+8Wc0Ce1S8YKwQ95FUB+Uk=;
        b=V6Q+Sd5XplT/seFZyHXDxiQU1JNcTSmUkyLUY2jpUAzy5GCP4ELUtRZnyT+NIlaj0+
         N+51idMvTDAWljc1rfVE0B5XnbNzUQqazmtWbR7WHKMytKqoaOogY+m1NzGMc3H471gL
         VEG1eG99nleSkkEgz1qWsOmbzAqk+9mMQxP+47EyG5c/DIQ/skePnDHAXWErUyr0y5Xd
         HENcFnFAZj/zdR17I628SYmR/2iz7vZIF2XVJn0tHGiQooJOA+s9uxXz3xzYhFu9hUma
         bvyhjdiCSM1w+JaNn1Q+dREG2WuzelZnHGePqQVZkHDfAgLHL+qWcxCoYhi0baQ8foi/
         8J5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752525332; x=1753130132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPAJ1J/iGPQmJ/KL3FDDL+8Wc0Ce1S8YKwQ95FUB+Uk=;
        b=xK+QzVcYv0uvasJlFG99KEhz80lpNT8I5IXKszbMFMA7oWyXgAJgoIUaiOhZJhqswA
         GgAE8bxyQpj3tqp+nOvYNipXH+JaoRuwcWMpXKzF0QOsm85/r3IA0GAkSojCfK+v9WBU
         XrBZhv8ic1cqvipirNQZL27HsdAHZ634FnbGRbZweX4SkFciDDjXErIDLRZdf2uC0QRl
         Xa4HMtzchnnj76/Z0lw6oK9ZIveWHazVmGXR3MfhJljSYDQeoVxP0IaIr16rGAlj0Yxu
         2y/I4cS0dN790+qPVahHVkyV0OIXVah9aVxO/TFPCqrB1U8kA0/HIQF6WjPfXjqn6RV6
         6f6A==
X-Gm-Message-State: AOJu0YzPUEm+QbwPmWzqOdXPedhhU7MkzvzF5jU2U3YT8aUwZMyGi/ux
	V1iMsDcdBeiEREsgB7JIOoC4hB60+GCuZgfrEJDQT2aMGmetpNNXfxSkxn+4++LZ
X-Gm-Gg: ASbGncteWpZOyPBZXniu4xDkX+elAcGyTcIVEVgrNCJkaxbCLqyhjOuesGV2VbMxVdL
	6tGcnTmugd070jsME+rf7EOI5hOanJ28iL1pNjT4oBdOEbW6kkgJoR/9TYbH8TEKtoG5mgYsK3M
	WmoubBTA1JGT99K/A+yWJ3Zgb+kpQCoUDWdxLN9oV3nBXzL8+TDCAdtXUG1cVknvHsat0IW4D3L
	9Gs243l4WFoX0JBO/7Ki+7ANxVrpzo0wPVTdr5EiYnSlYBb1ZTGpMu5K4MKy5KoNH3rPY0csroY
	bBXxR4lCDZclFyqMc/glUHz7zjhAFI8ltvtzte0YcapdiOiA4URHiXdoLZM62urF7F0+KDl7IYc
	Ld+i2MPmWJoupe0cjnu5EQOLOiCcQVYggCleLhhD9gkynYmBYLt7TC4muib8olYHh
X-Google-Smtp-Source: AGHT+IGicGdfp9/j7XkMJc8O2nOtW1NEZ/2ZVqj1y0GYU55xVJhUBBGQQ0FD6Awzg3lW75Odjje0sA==
X-Received: by 2002:a05:6102:304e:b0:4e5:8d83:c50e with SMTP id ada2fe7eead31-4f7ecce54d9mr673195137.10.1752525331413;
        Mon, 14 Jul 2025 13:35:31 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-888ec44a6f6sm1887177241.24.2025.07.14.13.35.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 13:35:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] doc: Add org.bluez.Bearer.LE and org.bluez.Bearer.BREDR
Date: Mon, 14 Jul 2025 16:35:16 -0400
Message-ID: <20250714203519.345226-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714203519.345226-1-luiz.dentz@gmail.com>
References: <20250714203519.345226-1-luiz.dentz@gmail.com>
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
 doc/org.bluez.Bearer.BREDR.rst | 143 +++++++++++++++++++++++++++++++++
 doc/org.bluez.Bearer.LE.rst    | 143 +++++++++++++++++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 doc/org.bluez.Bearer.BREDR.rst
 create mode 100644 doc/org.bluez.Bearer.LE.rst

diff --git a/Makefile.am b/Makefile.am
index c4b88d83c962..b75125e8887f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -358,6 +358,7 @@ if MANPAGES
 man_MANS += src/bluetoothd.8
 man_MANS += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
+		doc/org.bluez.Bearer.LE.5 doc/org.bluez.Bearer.BREDR.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
 		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
@@ -392,6 +393,7 @@ endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
+		doc/org.bluez.Bearer.LE.5 doc/org.bluez.Bearer.BREDR.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
 		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
@@ -470,6 +472,7 @@ EXTRA_DIST += doc/health-api.txt \
 EXTRA_DIST += doc/hci.rst doc/mgmt.rst doc/l2cap.rst doc/rfcomm.rst doc/sco.rst
 
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
+		doc/org.bluez.Bearer.LE.rst doc/org.bluez.Bearer.BREDR.rst \
 		doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
 		doc/org.bluez.Agent.rst doc/org.bluez.ProfileManager.rst \
 		doc/org.bluez.Profile.rst doc/org.bluez.NetworkServer.rst \
diff --git a/doc/org.bluez.Bearer.BREDR.rst b/doc/org.bluez.Bearer.BREDR.rst
new file mode 100644
index 000000000000..779490728872
--- /dev/null
+++ b/doc/org.bluez.Bearer.BREDR.rst
@@ -0,0 +1,143 @@
+======================
+org.bluez.Bearer.BREDR
+======================
+
+------------------------------------------
+BlueZ D-Bus Bearer BREDR API documentation
+------------------------------------------
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
+:Interface:	org.bluez.Bearer.BREDR1
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
+object Adapter [readonly, experimental]
+```````````````````````````````````````
+
+The object path of the adapter the set belongs to.
+
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
diff --git a/doc/org.bluez.Bearer.LE.rst b/doc/org.bluez.Bearer.LE.rst
new file mode 100644
index 000000000000..a4657755d119
--- /dev/null
+++ b/doc/org.bluez.Bearer.LE.rst
@@ -0,0 +1,143 @@
+===================
+org.bluez.Bearer.LE
+===================
+
+---------------------------------------
+BlueZ D-Bus Bearer LE API documentation
+---------------------------------------
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
+:Interface:	org.bluez.Bearer.LE1
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
+object Adapter [readonly, experimental]
+```````````````````````````````````````
+
+The object path of the adapter the set belongs to.
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

