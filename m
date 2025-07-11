Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6D2F2376
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263458; cv=none; b=D3uDDPG/ZDyxBpxw9OHpkoTyrg1myrdbRCK/Lv7t7p1GxPYgbla6oHBWfERvo5vK508brJ+w56Ts54Jbsl1w2kcFPkHU0amtMN5firQ0ZSHiJ/Xf9EfiCU3OQNDGBw1OreibBEv0AYuqMHHkNL7lLjYa4eEeZ5QI2AMY+yWnLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263458; c=relaxed/simple;
	bh=bustsq3sImDWxizuWurg326GBWzxFqqjZS/TXpS+qI4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZihAok+VtC2IzvP76U/TuRrznJ6d3DPd2pEXbd2yYJMbWE678ZRWBfJIOw4VDdsW/TklrUEikkTVpgyFtQ2V9xnJcFcTMGEJQg2FNQcOuegolq+xOfhHEKLj6vMoso4VJJgPylcDFBbOTMg1b4aSuEdsw7cpHuD+ZFhcH3t7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDLNNudn; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDLNNudn"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5347686c12cso927516e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752263454; x=1752868254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eidTCqMF//BUbYcsx9+X9+vJfzx1Z/LTzrEskJGT8M=;
        b=VDLNNudnknArijgqKmGVBdnCpF71J+hhWPCVjjSmSdaLWV/xi9jWb2BFu8XbE+fNrf
         UUYr8ao/HN1jjQTfSH3ayFxBTwB5Gl4+ecIebhU2ot7v3cZgphfMrZbYv/+6Mw8w8Jqg
         8Szu4fhn1MPC+lUCoeVPK3vR8N3onit/EmeSSbtZY40Hms6yNvYXDhXBSuvBu1LyPadL
         O5/kkelvd41C6KAA+/f2uqq/s2uSvowrtcRjbR+J1sQIJqlM9OlAQyzrumfNaBeykjr6
         EkSL22HjBfKznOdtSweDrxyjjmvBivP8kzPqcDjXj1nrOFNssGzN9xfkXobB6uvLru1I
         +13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263454; x=1752868254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eidTCqMF//BUbYcsx9+X9+vJfzx1Z/LTzrEskJGT8M=;
        b=QDhrDJwTDYhnEw1kNAV2MvOyjcGDVdvNJnSzI7Y869u1N3YyYh7wSZ+jG9mohMcIrl
         nAd6W4KUMC1OkHLwrfxf9LxdIo6Ae+kgaKiBd44MCV7bX1C3TFdwO7DJHeXleGSpxNlw
         5I729eAocp+fKmoqafMsxZysd0TI/cju4J1WdNZDVONlC82pozartf4xuhi44mq7TPlX
         cHkPh11JPL47+OI2ScGe6caLJ4G/3nuEvSEPcCYQZbax/M/JGp8Vjvuwq093dElYSsjz
         p9JWbbU0KKKMYMD28emc4JqWrA1lmcdaaHXhWZw1vD31HaBen/9sqTztWrRqZJLxMrgn
         imNg==
X-Gm-Message-State: AOJu0YzwChLwY1JlxQTNQeyKI6FNLjh9ZMIL1dVmS2emfeshhoNsYuIP
	sHSl4Fy0B/A/VGjYjnXrg26WzVU9YhZ33wo2OE9UkrjVDWxm4uLVxMjsxFy3Rg==
X-Gm-Gg: ASbGnctdVUN38SSqSvE7NJyExzsrprSplOfAaycR6xLFIOp8yWVntXpETZalvKsyvJP
	iPMbNqWQ2LpMF6BSB3FmCknsDG8FztxhjK9n24JTfejZdXwSOVJok44TSCLWi88g6D+qVbEY1Hh
	ASul7ds1vpE5ARTxEwyRldnYlXDPYW/BrtWdQ5OeuIAvCIQYCK7YbdW6oNoZYIy8V9WMLaLOPoE
	KDKCw7/HBZYEH3r2I64K3GPTUCFccxbglaBWLX/KKzlxeaItGAIsxjhnb70CTjHLV6t4FMGC1vR
	8F/M6QSQGbQ0EgbuQ0iLHPA8+vOeC3o5TywzEOc8BmRqn5rABAreElhk6NbMpi3i/s6+Al19PbW
	9q4+Cpfej+0BW/QHgn6zdibkzQwisN9VLZYtfWJswb8wbEDy22v8w0GLlBjlKcJtB
X-Google-Smtp-Source: AGHT+IG3Lr+Vj44b6qMN2PIVIjZdbNQaipnVcG6jJKbU7pRTfEaBvitknhjEM/HzWrizsp9ZFKQe5g==
X-Received: by 2002:a05:6122:1683:b0:531:312c:a715 with SMTP id 71dfb90a1353d-535f6ed62a0mr3467748e0c.2.1752263453999;
        Fri, 11 Jul 2025 12:50:53 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-535e72192ebsm867100e0c.1.2025.07.11.12.50.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:50:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 2/3] doc: Add org.bluez.Bearer.LE and org.bluez.Bearer.BREDR
Date: Fri, 11 Jul 2025 15:50:42 -0400
Message-ID: <20250711195043.3875400-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711195043.3875400-1-luiz.dentz@gmail.com>
References: <20250711195043.3875400-1-luiz.dentz@gmail.com>
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
 doc/org.bluez.Bearer.BREDR.rst | 137 ++++++++++++++++++++++++++++++++
 doc/org.bluez.Bearer.LE.rst    | 138 +++++++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)
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
index 000000000000..83fbcf8b00dc
--- /dev/null
+++ b/doc/org.bluez.Bearer.BREDR.rst
@@ -0,0 +1,137 @@
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
index 000000000000..6e53e230fa60
--- /dev/null
+++ b/doc/org.bluez.Bearer.LE.rst
@@ -0,0 +1,138 @@
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

