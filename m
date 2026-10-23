Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795034;
	b=p+hVXjNRsENar3Q/KiM88uSjyzt5+XVn/TMZd5PEsO56BxSrfjkgoaifaYmcAE4gFSzC
	 ptFpJ3t53ysnWrtePncAaumznO3wMG28EugAP7/uocwOUGM2KSuADno/7ebWrlu2w1x6d
	 ACm9I29IIk6QN185fLlLN3if8nRTE2WXWa4u9oUVZMVaixxfp9ACaZ0K5bUvhSy0va110
	 OxRY9SgpgonPhRrY4WV6LXyXLfUd02HFtuduuEdpqlkWZs8Lj7natgyQrGDX5kXRse2Lb
	 8YqNGrHMyYuAVJuEnG9kbLMpoZQ650Gd1aGA3OM8TboPBqKPAZGu/tAKynoKv+ot2AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8kzsO0hpA2jMbRRo1muZBqU7WzP0e/UwAj0ZXCR0TGc=;
	b=VdIXXjlux4g7zFBKQhB2r/mmnETJbJ3Oi0WbtC2LyulAQeNEgcUFJEB17Giy6taQjJ3x
	 eUjf8jU1MVzpQftzUOGy5s/Do1/CjD8BkmgCwTCDyDL13kCnYUlcXlkQj+SzsxGLk8NEv
	 +9TZteeoVjqpnFw+9Erso1/23b1jYRQBcyhrFccbNpycziUZV9H7ShA3tKQJ94KU7Fh8m
	 nrhJa28n+WPVwO8IQmctP4i61Xn+hk1Trk8vMJybgyy4HnJ787Ud7XtzXJ6BuwpBWq8zA
	 Z4S3g8F/MZQkRGucFFWieXzFQhIKgKjVuV6/wEjUNwwIOg6H54cRbBa2+dFHEWq0Zkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=jjDKFJyv;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD315606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 22:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD315606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=jjDKFJyv
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35c76e9614aso2082230eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1792795033; x=1793399833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kzsO0hpA2jMbRRo1muZBqU7WzP0e/UwAj0ZXCR0TGc=;
        b=jjDKFJyv1buV0PanZ+i1/1kUvWHAMSyeTym1hkAN2zovazjb350S3LTY50opFimQsy
         J8c5SaVEJv8wyo1ve9Woxml4NJcic+EZJ3pyKUTEmzCBsUN6fT1nwiBaETQxPW+aNY+G
         CMhlWhmZh36oo2CW2AYo0KeN5TBHuv5jvca5+KZGPmVvr/bXt/9vadDjTfliKzQQYbbq
         4OrJTbLhTh57EnOQS0Mfv5DRL4WVqsnqyo2SYeipzR6ki8Fz986gmHqQahOCyoeEvwvu
         Rf0NXMW9AEulp0AVWwni8R1bOjHL/Hnl5EP3e81Dtnw+ELNT3XFNMcZy9YZ4EJlLKpLU
         QPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795033; x=1793399833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kzsO0hpA2jMbRRo1muZBqU7WzP0e/UwAj0ZXCR0TGc=;
        b=AOyB6sd6FUciZQLDm3bpYX7ugVBSI/j/TFljSYiEuR2ArrKOQmQhZ2N1gcMbiuS1V/
         WvNJE0a3UQOwpMTDJ2Q7tq6GRcXDiP2TXI20pxn0OeH8ar3HLQdM45wB+1cGL8KXy5Ah
         CXgvsB8xDy+PO7q5lhj8MoSRWAY8aTz6rkJtlVSweMT4wFcMOKw0O1uPebXKJL7u0bDR
         OKIOTszhyv9uW3BRBgbLQTFTF2dWsfnhl6OC47ELb9JpHUpUT//X5Q+26xtTc//tGExx
         PeJku64+EdnglKh5cPFHnOvissTuOm178+H3CUJcnOfn1ijGgf1h9cPAY5nsxt3p/F9Z
         DFlg==
X-Gm-Message-State: AFq9FYJK3Ba5mKhldhyeo03Nt6gIHQWT6khERawIqeV2JJcVhlcOANv5
	J3iQNZK/DKy2NbynXdOj6YdIDbfmFjUDxmnquCw2ZIxt3tXsmdn5i8zxoN7zSM9wSFkRpRR81Kd
	Fcl5JowY=
X-Gm-Gg: AYBFou0bmbIYPGm3vfp/SbnYAH5PuaIaKTEMeN1RQuNHOEYeDJtlqdch6O2Qv9vQGkW
	ToDhs09oJ+vhW9xjylYu5ZOzY3JZAYOjFHkC0TpuxxytuVVOblzJIjJ7Xu9pndWlpkvedzihS5o
	DM6bgKdDi1Hm0224yD9wHXq22xIBV1fuiViZio5yNYj+8pTG2twxfur/Z342Twa0zA6IGjVoG/q
	yCJLLnv87+1AS7LCeaFO6F0oAMlSmvrU47UXUjAgTUU0d6Nwdn+7VzhMs6maPOzaF2ir0FgDC7o
	HqyYoYBm37bx6kZYjyNH9Cww0O5RLhU/zXYhhu6hlrumtpSfTK8CFHww7nQWCELxEb6PSpPHoiC
	M9r/pMdb41/b+/bfDj7biiK4V3ohwwptvlqKCTBcgjpHHOL4bx6U9RT02nt87FAvUbiZTdzpBTd
	TKHqDfVhFv25HwSW0YDy0Iv/4AlH4fsImr7rs9kB8f116h3BZ4pxD8h83lBBvsFXbx1ofcWnlq8
	21iVcEn/VQVF3HbrRtvhNO1rAU6vsgL2xvRiRRi0ammqiWNYVPzzg2ABlZ/a3GI8mcURlPTeE2o
	EubaYTmpmgq8Y/8K9dv7auVmrcXHGeLppZEjruAtsy54LdTmmvGSW2oyTkEiQfse741Cqe2U0Cs
	a58VSqI0Mv2rhW75aPd/iMQ==
X-Received: by 2002:a05:7301:c011:b0:358:ec5c:bef1 with SMTP id 5a478bee46e88-369e8620428mr819134eec.39.1792795032677;
        Fri, 23 Oct 2026 15:37:12 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d9307bsm1327484eec.14.2026.10.23.15.37.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 15:37:12 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 1/3] org.bluez.Bearer: Promote to stable
Date: Fri, 23 Oct 2026 15:37:06 -0700
Message-ID: <20261023223708.76232-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023223708.76232-1-kevin@simpleble.org>
References: <20261023223708.76232-1-kevin@simpleble.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Promote the methods, signal and properties of org.bluez.Bearer.LE1 and
org.bluez.Bearer.BREDR1 to stable, so they can be used by upper layers
without having to enable experimental. They are now covered by the
bearer functional tests.

Assisted-by: Claude:claude-opus-5.5
---
 doc/org.bluez.Bearer.BREDR.rst | 32 +++++++++++++++---------------
 doc/org.bluez.Bearer.LE.rst    | 36 +++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/doc/org.bluez.Bearer.BREDR.rst b/doc/org.bluez.Bearer.BREDR.rst
index a1477a2d2..370ea6e6c 100644
--- a/doc/org.bluez.Bearer.BREDR.rst
+++ b/doc/org.bluez.Bearer.BREDR.rst
@@ -21,8 +21,8 @@ Interface
 Methods
 -------
 
-void Connect() [experimental]
-`````````````````````````````
+void Connect()
+``````````````
 
 Connects all BREDR profiles the remote device supports that can be connected to
 and have been flagged as auto-connectable. If only subset of profiles is already
@@ -38,8 +38,8 @@ Possible errors:
 :org.bluez.Error.InProgress:
 :org.bluez.Error.AlreadyConnected:
 
-void Disconnect() [experimental]
-````````````````````````````````
+void Disconnect()
+`````````````````
 
 Disconnects all connected profiles and then terminates low-level ACL connection.
 
@@ -59,8 +59,8 @@ Possible errors:
 Signals
 -------
 
-void Disconnected(string reason, string message) [experimental]
-```````````````````````````````````````````````````````````````
+void Disconnected(string reason, string message)
+````````````````````````````````````````````````
 
 This signal is launched when a device is disconnected, with the reason of the
 disconnection.
@@ -113,37 +113,37 @@ Possible reasons:
 Properties
 ----------
 
-object Adapter [readonly, experimental]
-```````````````````````````````````````
+object Adapter [readonly]
+`````````````````````````
 
 The object path of the adapter the set belongs to.
 
 
-boolean Paired [readonly, experimental]
-```````````````````````````````````````
+boolean Paired [readonly]
+`````````````````````````
 
 Indicates if the remote device is paired to BREDR bearer.
 
 Paired means the pairing process where devices exchange the information to
 establish an encrypted connection has been completed.
 
-boolean Bonded [readonly, experimental]
-```````````````````````````````````````
+boolean Bonded [readonly]
+`````````````````````````
 
 Indicates if the remote device is bonded to BREDR bearer.
 
 Bonded means the information exchanged on pairing process has been stored and
 will be persisted.
 
-boolean Connected [readonly, experimental]
-``````````````````````````````````````````
+boolean Connected [readonly]
+````````````````````````````
 
 Indicates if the remote device is currently connected to BREDR bearer.
 
 A PropertiesChanged signal indicate changes to this status.
 
-boolean Connectable [readonly, experimental]
-````````````````````````````````````````````
+boolean Connectable [readonly]
+``````````````````````````````
 
 Indicates if the remote device accepts connections on BREDR bearer. BREDR
 devices are always considered connectable.
diff --git a/doc/org.bluez.Bearer.LE.rst b/doc/org.bluez.Bearer.LE.rst
index dfd809739..6d3df3fcf 100644
--- a/doc/org.bluez.Bearer.LE.rst
+++ b/doc/org.bluez.Bearer.LE.rst
@@ -21,8 +21,8 @@ Interface
 Methods
 -------
 
-void Connect() [experimental]
-`````````````````````````````
+void Connect()
+``````````````
 
 Connects all LE profiles the remote device supports that can be connected to and
 have been flagged as auto-connectable. If only subset of profiles is already
@@ -38,8 +38,8 @@ Possible errors:
 :org.bluez.Error.InProgress:
 :org.bluez.Error.AlreadyConnected:
 
-void Disconnect() [experimental]
-````````````````````````````````
+void Disconnect()
+`````````````````
 
 Disconnects all connected profiles and then terminates low-level ACL-LE
 connection.
@@ -60,8 +60,8 @@ Possible errors:
 Signals
 -------
 
-void Disconnected(string reason, string message) [experimental]
-```````````````````````````````````````````````````````````````
+void Disconnected(string reason, string message)
+````````````````````````````````````````````````
 
 This signal is launched when a device is disconnected, with the reason of the
 disconnection.
@@ -114,36 +114,36 @@ Possible reasons:
 Properties
 ----------
 
-object Adapter [readonly, experimental]
-```````````````````````````````````````
+object Adapter [readonly]
+`````````````````````````
 
 The object path of the adapter the set belongs to.
 
-boolean Paired [readonly, experimental]
-```````````````````````````````````````
+boolean Paired [readonly]
+`````````````````````````
 
 Indicates if the remote device is paired to LE bearer.
 
 Paired means the pairing process where devices exchange the information to
 establish an encrypted connection has been completed.
 
-boolean Bonded [readonly, experimental]
-```````````````````````````````````````
+boolean Bonded [readonly]
+`````````````````````````
 
 Indicates if the remote device is bonded to LE bearer.
 
 Bonded means the information exchanged on pairing process has been stored and
 will be persisted.
 
-boolean Connected [readonly, experimental]
-``````````````````````````````````````````
+boolean Connected [readonly]
+````````````````````````````
 
 Indicates if the remote device is currently connected to LE bearer.
 
 A PropertiesChanged signal indicate changes to this status.
 
-boolean Connectable [readonly, optional, experimental]
-``````````````````````````````````````````````````````
+boolean Connectable [readonly, optional]
+````````````````````````````````````````
 
 Indicates if the remote device accepts connections on LE bearer, based on the
 most recent advertising report. It is false when the last advertising report
@@ -154,8 +154,8 @@ over LE bearer.
 
 A PropertiesChanged signal indicate changes to this status.
 
-string Role [readonly, optional, experimental]
-``````````````````````````````````````````````
+string Role [readonly, optional]
+````````````````````````````````
 
 Indicates the role of the remote device in the current connection on LE bearer.
 It is only present while the remote device is connected over LE bearer.
-- 
2.54.0 (Apple Git-157)

