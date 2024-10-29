Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AACC1DC06B
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237401; cv=none; b=QcfvT/OtwHHMtASE0sxf0zLKyZi16XLopxFPYmVeYkSlFQxiJsrksDI2w7/mKHjt5nsqpbArK9FOfhHn6ozVMOZD9hnTNj2eLguX+RQnNEd1F/gv+tVmUeJVzy+LriXR8x8zFg6vje/bPVBeyDrF+ioq4g6usnhnWlowL33aaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237401; c=relaxed/simple;
	bh=1PnA0w3XlMLN8uKQicaObEFYzRCXyKqyG82G9hWijpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRq9ZbKDWyqC1RXKYqX+6dpKI0XfcZ1eMu3AntzP1FBoTSGddY/4l56hkTjv5z98czaY1eboor0oSmVZUeogd7sTPDLAnZvG4wulMkaoM0lbqtJSlHRKdJBBapUQpEBnkPX4U/mEv92muEIX1OK546K5+b9sk4gVlJOi+uVxglk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8xygQ1a; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8xygQ1a"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d4a6ef70aso1841707e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730237398; x=1730842198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQdmJdVaD4iwo01ECNB5NhPh1GLPEqdHS/zldhXimRE=;
        b=K8xygQ1aiLwRU+CzaMikTYf1w7pqmjMxR/WUTMiXEEz5jLfoCRIwbtR8SU72YQN+Uw
         f02qWOnJIOrsZ14Mc3D+4MNHfLXVYaU0SKXGZ/c2zsmAAbnraH1tOp1vpei6ZbLnNpJu
         +WdSPDUI+edzAwrwngLnVdvMnz9MXd9n5yvA/Rw7FYm3+EkkjM7bpObwdKXwvFdikavU
         bEcIwoOh+Up5gGfMAbAY+dZUd3wIeMsJV3op8t+ZeqELYbOte22HmV33XPANCRmeMREp
         iJDP34h7MSdhA6iP+ULw/bYmAmRzQhgz7RC58YtX3dRd38eow1RnjTpurs/GGrLwRdxC
         zXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237398; x=1730842198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQdmJdVaD4iwo01ECNB5NhPh1GLPEqdHS/zldhXimRE=;
        b=VYRnMBhEQe6L3EaUzHBtKWDgHqC+yiJ8coCvDKwE1SWDl8YH/7Pt9GXpDxpG+tDvLt
         hs9fJncLu2AMkSRsQYMAOj2IKx+4p0WiUymh6rGwvt2mLTqWCsXsuXuIRx1xaIxpmcyL
         pZ4CEI9tZuDBl8N7TR3riU6I6yZEv/z8MLTySTZzten1A8+QqNqm/JpBKJREQSvV1Xy9
         1b0gnLkSlqOJA8d4i28j2pFAj5uLOqXEAVYR+5sw+2jF447US3K/ZcoT3AULekQp5DO7
         p7pQXsjy16HUvYn9IQX9klq+GesYv7GMKkFNmPX7SgI3CiDyV1KHY09v0Scl1DIjK6ZF
         hDug==
X-Gm-Message-State: AOJu0Yw6o52W1TTx67zzBex64fyMtkCUWxT5i1eBDTmhe4yrJ4xK/4Gf
	1M7iwPQpgPKCc4s2fhuJ74dC491aQWFzDiyrVSBibAEGEHgrVY+ucbBjKQ==
X-Google-Smtp-Source: AGHT+IHj3dc5WMf385DsuvWJzecwmIrV/5y42G0vKAqN0yPCIc/cu+sIkGJSBl1qCI2lhaUs3MaJhQ==
X-Received: by 2002:a05:6122:20a2:b0:4f5:22cc:71b9 with SMTP id 71dfb90a1353d-51015035003mr10108317e0c.5.1730237397640;
        Tue, 29 Oct 2024 14:29:57 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51004777927sm1283579e0c.36.2024.10.29.14.29.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:29:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] main: Add call to g_dbus_set_debug
Date: Tue, 29 Oct 2024 17:29:49 -0400
Message-ID: <20241029212949.3674826-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029212949.3674826-1-luiz.dentz@gmail.com>
References: <20241029212949.3674826-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a call to g_dbus_set_debug which enabled debugging of D-Bus
messages when dynamic debug is enabled for main.c:

bluetoothd[3672799]: [:1.38799:method_call] > org.bluez.Device1.Connect [#761]
bluetoothd[3672799]: [:1.38799:error] < org.bluez.Error.Failed [#761]
---
 src/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/main.c b/src/main.c
index 89ee6897c293..41c3271a7457 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1322,6 +1322,11 @@ static void disconnected_dbus(DBusConnection *conn, void *data)
 	mainloop_quit();
 }
 
+static void dbus_debug(const char *str, void *data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
 static int connect_dbus(void)
 {
 	DBusConnection *conn;
@@ -1343,6 +1348,7 @@ static int connect_dbus(void)
 
 	g_dbus_set_disconnect_function(conn, disconnected_dbus, NULL, NULL);
 	g_dbus_attach_object_manager(conn);
+	g_dbus_set_debug(dbus_debug, NULL, NULL);
 
 	return 0;
 }
-- 
2.47.0

