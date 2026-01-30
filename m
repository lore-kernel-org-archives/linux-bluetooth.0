Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDAD3542C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810590; cv=none; b=g5sGa4OwmS0qNuo/3Zwh9G9X1XgrfAO5wMj0kqIImsypFSR4UhqkeXztpkX75N4q3A7LeQyfb4OqYz0VF5Dn1gEzke1Fjmx5SxVNSL0N5+oZrTjmKctC9UGG1Jv8iBxKIT8uzJFdoHAi8IpTzC7ojOuDwTWiH54qvKJwONUa5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810590; c=relaxed/simple;
	bh=BSgnFGS72HGvic933JJo1JvmBfFo38ewSpGi8NqFzv4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nge+aG5chcXHamQaIk1wpO36DN6V6ZUjUBPZoQO24ljlPuZAovR6U97ekyDPBn7HYnDIrAEvI9a6s3l5gt6By2VjodivGHp+0CBQgGpKVlLN0fyRHohGPCHtvcaPdk/+IQ4zzb4eirGAM/zays+YudXfryAysMPa2/Ng5p2LDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFTAk71f; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFTAk71f"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5f178c83a3dso759643137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810588; x=1770415388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyhQdSfoulExYxfXRCKcjdrwSfBSqZU1fYWwDsMPPc4=;
        b=TFTAk71fVN4CPJkc+1rPe2hPP6Rex4vXIN3mKFNas0Mm2J0rVZK3wmwvk+imTdmzxw
         zU1aakXFukozcDYofDKjN6vKG6Re4fsDWl7kTInfvJ8tkQuuVOUqi/8BYhNjhgM/Jh2u
         p/YrgnPZnNUHFTmkT494/tkGDzejwfXbW0K3uc9CDtqobsCVg7XWkgRcZ7IywXTZ9bqF
         E7P9shEifxBnfE6sfJeQp9yQa6p27eVeXVJooKaeSoURZlQCZm/a3dBU1glIU0VsVHFj
         nHSGUkk+E2hj7IlGl6Q38ZvurklLsqMOZ4h1Lffwn2UytljJKozBFA5dE7rIVq7Dzp+t
         MeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810588; x=1770415388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IyhQdSfoulExYxfXRCKcjdrwSfBSqZU1fYWwDsMPPc4=;
        b=cWmUrebuufaQs8sOD0xKb7CH2dtsDZJZSDttn4a5u/4mpIBZvMRDh7FTn1kvFySWBm
         MUiXhyN+4R+KfOyu4HdrP3K4LxegmJNm7YzK4F60sYOgnl37PcOzkHA61gBQNE49mSHd
         20j5cbCe72B8OTnNG7v82wDyI3J0ushXm+PenA8cG5MtEqkHY2BqJK15ghdFXiwUARJl
         KtVi0zTdu+Gu3aAh2OPQlXVeaCqSeDTaRS90xNXy+fvpJ6mzi0xGt2JQVZCHaU+zuy0u
         XYYCHwIhM5BIWOfcOXGwG2YGyGUiTkZzxtWHA2EPsFaXP7HAoXr/cdeFbMhRVnRaWmC4
         8qQg==
X-Gm-Message-State: AOJu0Yz2sGKozV7+CHc7LDxs6gxVS4IoH+OxQI9zsCK5UQzgfTLQCnK9
	Jjf2tIlZUrYpMmsnsdPb8bu1d93PM8S9bZT3YDAOxYhkehKI7JjyqHiWlpmwlw==
X-Gm-Gg: AZuq6aJZa8PF42NRasgHRbhdk1GVzcitoV1ki75CLnaXW1zNfB2d5p4r/kV1sMhWpS9
	ri4B8jhMkuYA2ouMPJ0qVA1a5hZvt/3R1o357Aq8x3HULC8bn/stZm+IbpfIqcgYW2gzqC8B8D2
	2rpKeMUj7wxUAEcotB2yY2f034IsL6KNeFGfdbsk9Axfyck/SCSvcO10Vt2gvOg2hpFbVevlQU2
	xPYDIWfHlxRFyqjQPd0dw4QzzNquexN8/zvjFdR87Zsf3UyyWb4nxuKI31uAtNg0z1wCE8jblde
	z+BhrRl5tt3YaO6Fh9JRI8s79J7hImqjHhLZXjxFJLjBEoIQfzZZFAOVvXxGMkBpnJ9+UsdyyyA
	mFVd/s/6N10tqXUWKnqUJUxy/Y9mwNn76GRfUcxESBag5jdOwpeO8uvswQNLFwR+6dHuj13O7sS
	lMIHVFmFiqG7P27Hky6KG67vcFiLqO3G/+tY8r2ZKcrmFFwUPK4Z6cZWDbThp6Sf+YtOnjg2rUK
	svlgg==
X-Received: by 2002:a05:6102:3a0d:b0:5f5:33e4:12ea with SMTP id ada2fe7eead31-5f8e25b8bb5mr1217413137.31.1769810586104;
        Fri, 30 Jan 2026 14:03:06 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 21/37] doc/org.bluez.AgentManager: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:12 -0500
Message-ID: <20260130220229.1346261-22-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for agent methods.
---
 doc/org.bluez.AgentManager.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.AgentManager.rst b/doc/org.bluez.AgentManager.rst
index 77373c0153fd..23e4229adaf1 100644
--- a/doc/org.bluez.AgentManager.rst
+++ b/doc/org.bluez.AgentManager.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.AgentManager1
 :Object path:	/org/bluez
+:Used by:	**bluetoothctl(1)**
 
 Methods
 -------
@@ -57,6 +58,10 @@ Possible errors:
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.AlreadyExists:
 
+Examples:
+
+:bluetoothctl: > agent <on/off/auto/capability>
+
 void UnregisterAgent(object agent)
 ``````````````````````````````````
 
@@ -79,3 +84,7 @@ Special permission might be required to become the default agent.
 Possible errors:
 
 :org.bluez.Error.DoesNotExist:
+
+Examples:
+
+:bluetoothctl: > default-agent
-- 
2.52.0

