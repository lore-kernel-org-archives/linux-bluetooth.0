Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EFC2FBE0A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802003; cv=none; b=ksuk6QIUv+WlUrDawxOh8o4qZOL++rKtyyfia04lJbTYefaV6CwgaJ24fkwclimbBUcWoQE5qdRiI9iu+/RzRRiDdr8Gi8xrvImBooAq0aDjiBhyqhhmL3/vfyF3b0nFmaoRfbYPfZgOj4oWsc6g2RuYtB+jMrBx1ayX2QR8TN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802003; c=relaxed/simple;
	bh=cdtxns0AAbk/X7fluIwMEY/JGpxVcQgeMwogGDuITec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An6svp25VUuE8+IH03S3WZnS1kxFS/L0PNlKSuvKW6qV+dQUUn27UxxTIBXtamZz1PZU9YlDTv81JGtNf4ZfhE/HwQJjmOdJ5q4h4YaRC6YUG41uP4RwNyZG78T9wNu988HComF4L3r8T6UYdFbFwNcSgNbD/N3jt0bDXDGCI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwIWA66C; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwIWA66C"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-5664848545fso892594e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769802000; x=1770406800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl/LGTPwiwxL//5coSNOB620xUnclD+MBHY4V0vXxv0=;
        b=EwIWA66Cf2c64kRxCScNmGbrHonzW6SEpvvFABX9e3aX2m0jw7vD8PysBItwfOo+xd
         zfl80x6nGkRUMTbiOlQOc+aUOLccG2OoNz2ZNa8zTERyfkSDM4CVCAp8avu/zsST0szs
         YEIaBn64GqlKzL6p9yMIcSJiiBoon4P43nkixKDzy7NWK/24Huv4IjVW8U8xbLUji/YB
         J3UYtee6P4Siav3zZ8fCRSPFnkhgjZsP92o+nRSTvmz4qGNqFQ+17H42TnKpmZUO568p
         nm9RrALyPCX2UUNKs3izFF/IOP5J5iTGafHygWgJO5Cg4+GengpPgyQzWlwsLZrmEd+h
         /9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769802000; x=1770406800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dl/LGTPwiwxL//5coSNOB620xUnclD+MBHY4V0vXxv0=;
        b=vqm9eXPzH2c2+9n0DlZ93EOEyBVHItzCPoxT2q73v3vmWMkL+6ZWYl6SayDoSVRW0o
         ExsXNG57H1cwol58630LIh6VqcDbCEqMkbl7F3YTB9fERRMxCi97ES90T8I8P6oJRVSP
         JE9LGocTuykxnlmpEJXIGepeadX7vfetsJWN6xhZMP/pHbd0seb1QvR/TJmOZPjKaB9h
         tZVptS+n9LcXKPmTAX2wHl/N5uYPw46MrF2PFncFkD+R8mJOdMCwDA9dPTqNtIXor8/t
         XUdHzWCsiYKdzKjExbSHvpgT16PW0FwsCIPhLxb84dLtL2XvydnuPjSYpyhwxIasUAGs
         4ncA==
X-Gm-Message-State: AOJu0YzllWDk9ecyIigLmQbtctvrVLy5yHotE4G+nOU2WiHurys+sh5u
	zCGp6BjE2R7j9NFrLt4TiUYOGyqoDMKwOFWhg7xm3IjPqdGFy7l64bd+dsTrXC9Y
X-Gm-Gg: AZuq6aJ7osOch6n4BIyHseMGmXkksQmvAQlM1+5laHdqRVip2e7qwnfZBwCmW2YdgAE
	40SGgVsWAguirOqK+Sf1E+QukhROxxHKHojJ9Ho9KfGk4WyLDt91mGspG7vdTSyLdcZxKQB432D
	aDHqCsv59j9RHM8aGIKXgJ20rLExbP+q2OXGwUKxTj2rdU1gaRJyCh3Bc4wQfprGj7nonJMrhJH
	BxPolBi2zqPnIXEjErvKZxmZzo+I+Br3vfo5/ZCxvhseElxXZdzUDNpO/1QUcSWSaIEOYYXguDg
	OjY7XjFyV1NWQMP4LvPO3Y7Mkr2CwAk8VqG1VkNLJ4l7ZThm+nyoiITg0KaFy19fOWfMBFDvkoD
	QLymbFHvePPh1hAZAgL/h3aMHnIu7E7IIRYCr1MXYpGY2Fbp/e7UiwP+DyCb6wMnNYUVjuV3A95
	OywsGh1pLrjcpS75+J+T5/uINZadvfp1r0x/wxvuhPdtn+uMdn8+ezll1yhtOdFFjMlOuZKqmuS
	4eppzfgsKO/7jSL
X-Received: by 2002:a05:6122:1692:b0:55b:305b:4e45 with SMTP id 71dfb90a1353d-566a0143c31mr1088115e0c.17.1769802000363;
        Fri, 30 Jan 2026 11:40:00 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 31/35] doc/org.bluez.MediaAssistant: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:39:13 -0500
Message-ID: <20260130193921.1273263-32-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-assistant and Examples
sections showing corresponding bluetoothctl assistant commands.
---
 doc/org.bluez.MediaAssistant.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/org.bluez.MediaAssistant.rst b/doc/org.bluez.MediaAssistant.rst
index 8650d8abb379..45143cee8dbf 100644
--- a/doc/org.bluez.MediaAssistant.rst
+++ b/doc/org.bluez.MediaAssistant.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.MediaAssistant1
 :Object path:	/org/bluez/{hci0,hci1,...}/dev_{BDADDR}/src_{BDADDR}/sid#/bis#
+:Used by:	**bluetoothctl-assistant(1)**
 
 Methods
 -------
@@ -45,6 +46,10 @@ Values:
 		Push to a specific device. Device must be connected and with
 		an active BASS session.
 
+Examples:
+
+:bluetoothctl: > assistant.push <assistant>
+
 Properties
 ----------
 
-- 
2.52.0

