Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891082FDC27
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802004; cv=none; b=JtjiLljDDcaws7Yoj6GWT6bk6129U68j/nsdVnrWXpqYSIcsBSkf68eMnn8LgU60sVAln2yLIxzg+lT+MKdijmvWDP4O7cm1nYWmVmCoGcDguZKWjp6YsMXbK5fV0NnrUNcqCjoy9CKI5ojuBMA2lsKGCL7869MJCnapFx/6WYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802004; c=relaxed/simple;
	bh=QA8BDO2GoPbqDI4eOlzoKJjtUgFvjk5aTg3E9yQwtOo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1OQv5uuLjYGQ9y+odRD8IHp2JNt3xTO+LczViTWG4W8txdoZF4fl7R+HSzuoYA48u0XOHWEZuPWLr455Tr1AJcaqaAphKSoT67n1DsLARmd31YMYyT5T0qPMB9AH83M7psHQvAlFuZ7BeR+Q+Bj3VKm0HlYjuUG4kQy6EQD9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxnIKElt; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxnIKElt"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5663724e4daso1751036e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769802002; x=1770406802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zq8oqXo0xwwDrMCEVO4HEXeuXKP1i6Hd6UOCp7jvBSg=;
        b=PxnIKElt/11S8rjZ3qNuB2K+2Rztbpku8Vk0Vfhg48fbtjmCKgXRnVX5dpi2FDEI3h
         Lf4hQQlIoH9I1a07/IfejbMng1ddlKCabRLHqpVd1QMo8CHztY92z8TIfK9MpAW20HTM
         BYZ9gooJDLufbDFwtWv9llbDycsv5RnhdNlHcO0PshCPFi/jqY7RmKpI3O6UW4AJUMwE
         xfGrifLN9gvQO/ZNCnRGSJ1c5zeHPaqaHbyQFKLUqoWzP3t6FBt6Kwj4smKqrDEoXih5
         WE1ujITpc55WZ0J4tjPvRfdEa5actKglF4lAlCRdoLVo0l9D20kTLPQ68pAVHmkA7v7B
         RqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769802002; x=1770406802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zq8oqXo0xwwDrMCEVO4HEXeuXKP1i6Hd6UOCp7jvBSg=;
        b=bg5CJiIFwJg1QsdMmcddmINTTJV/BJCpgUzSshXxw/3PdlJKTLLWt3fv/ukelFI+bv
         vO1bMO2Yg6Mneimhrovv8wOgxwlT86D6OaN1kD3KYjgLHbsDcqg0DZIzShFTIap8JFuc
         rwirRcVwsuSMYe0L1fjOULmMuGhYRm2sbYAbdP2iXeVIurhnuSPuyY3VAUW6qWt9VV5h
         fnTz5BBTA3RNtUcXNcoJqcKf/f+kEFofk0Xb6Q/Iaob9A53wiVU/ClfTL+W26hFFeVRv
         QGtT3d+NfOBY4X1R68v5jHTrxdAYQmFf6/Xh3KZ2ZV3bV+6ZYloaZ3Tg6iT4el5zzJQZ
         ouLw==
X-Gm-Message-State: AOJu0YwBU2hsrRklsFTu86UEuvMU77+dn0iUp6kpFsKgbZF42JF6+UB+
	/ek9iGIiklyxl0UelvYR8T8ZClBjusuCrabsMp3Ja77+v7xGNCT32oFc7rKg+g==
X-Gm-Gg: AZuq6aJVMZ5tXbH8j3AjgmaaIpT+Mq2BTVBcM9fJcXl06nMBOzdKkXM6bSbJs5pxPnK
	86uZT5GmtPTXdvV6ZV2WDp5CGwJo9giApRSBfIIvddcd3uls5IURqjTzPUP2mSB9omnYUB/5nL2
	WyQWdu5oc9cyulB6K0JwmBo7l+3kpcpHEpD1G16xwRmgZF21lMPhDIXoiio4AFpVAENHb1WteAV
	N3rCOFj7Khg6qqhKUpAtWRv/Q8FXthEAZ7AIM8ReM4kCvlaXsYBZ4O8WDJcvVvtDSVe5UKXq122
	76g6nNWkV+oY0VMHSBiqNgLX/XVLjW24uhRI/bUR9LvdEkR+DGEazqA/SiotLAYxB00dmC654ro
	knavtvoFbEJCyy/VNe6nZBw5CIw15mEY7swqCfLYOLSOzT+A7KDZlrKGxNoB/lP2Q0BQasRYVV6
	X2PL73zffvnxSehVSb6jtxHq2yEzz9+DqUdFC9hoM46XMMOLXKKRZJUSBgZHb3xl+VZKauUg7c6
	JagcQ==
X-Received: by 2002:a05:6122:1b8c:b0:54a:992c:815e with SMTP id 71dfb90a1353d-566a0015d3fmr1071643e0c.8.1769802002313;
        Fri, 30 Jan 2026 11:40:02 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.40.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:40:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 33/35] doc/org.bluez.MediaPlayer: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:39:15 -0500
Message-ID: <20260130193921.1273263-34-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-player and Examples sections
showing corresponding bluetoothctl player commands.
---
 doc/org.bluez.MediaPlayer.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/org.bluez.MediaPlayer.rst b/doc/org.bluez.MediaPlayer.rst
index 14768cf433ac..03513842a880 100644
--- a/doc/org.bluez.MediaPlayer.rst
+++ b/doc/org.bluez.MediaPlayer.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez (Controller role)
 :Interface:	org.bluez.MediaPlayer1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/player#
+:Used by:	**bluetoothctl-player(1)**
 
 Methods
 -------
@@ -31,6 +32,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.play [item]
+
 void Pause()
 ````````````
 
@@ -41,6 +46,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.pause
+
 void Stop()
 ```````````
 
@@ -51,6 +60,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.stop
+
 void Next()
 ```````````
 
@@ -61,6 +74,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.next
+
 void Previous()
 ```````````````
 
@@ -71,6 +88,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.previous
+
 void FastForward()
 ``````````````````
 
@@ -82,6 +103,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.fast-forward
+
 void Rewind()
 `````````````
 
@@ -93,6 +118,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.rewind
+
 void Press(byte avc_key)
 ````````````````````````
 
-- 
2.52.0

