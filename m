Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CDF2E888A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801989; cv=none; b=UuIJt90szZolsVbHkUdt2J9SoSymyzUJDSjYKDnmEONbhcB19QIzjH1GxYrYyd6nMFI5x9X8Q6oD3pEMy0MKvv3pnDfLiJeLLyS5QGErIrgwmQqAM9I5a3NySbc2GCpVeKRCI+VIPDXCRT0FyVnP6hL67moPxYio4iWp051/FME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801989; c=relaxed/simple;
	bh=ruarxG+rVtB4kweK873mf+e92+ENv9uALVrCA0+y1Ow=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+pwOvb5Fxd2K+ZMvhQyX+lSDaDRqLsw3CfgrhpNjYK+4phPt6uDZNPMB28hw+vE+J6YcjnGBQTntA0CS9wXiFCZEGRUpqcWIwS1APVHo2H0y7M8W+8fdQXshYWli/VETRLE0v91DgjwqRFNrBewG7borvM1YkXbxMwquTpLPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG+yL5Gt; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG+yL5Gt"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-566390e7db3so1920998e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801986; x=1770406786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sImh1VF/9ZDlXNU3f+r2qx4okd1j0aO5OOE2JcuyPe0=;
        b=GG+yL5GtetCwKB/z4pAaUBHA8N1EfzDOiwrHaGgkXlSSM78WXIPsiMHelxSDUzlDi+
         n0+HNFmA+Its61P1DbCy41DwYql4uvetLjRtBygg8Uk7n80JRLZsEookcOvWnHrL6z/E
         /PfUkOZd4KIz3z6HXkERA7Qx2lbK06isqz4Ecg2xJHtTAqqQVi+EN2jxWYbwApvW2ZTZ
         kOfnLDmudtFKPUExQ1XqOXqbAlYjvei6CmgInfXPpXlTOYfo/PLAn19SluL2RUTpT2RI
         cfzDdxCixf1bOBQaNXGvK8PjvLlSVYqPYpbFP6jG8zM9EoPmSSLT+4oO+pbFFqe3FBH/
         KEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801986; x=1770406786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sImh1VF/9ZDlXNU3f+r2qx4okd1j0aO5OOE2JcuyPe0=;
        b=KIP+fch1CzZLo7rXrqAtCV37vm5DjdwWnSFPFnjmsAOOu5xrAVzdOEnlL1XKinW5Rf
         IJzSAa/gwnUdqNEIuIRqKnLkMK7HOIsyzWUOuUa2X+q5a6cxREqn/zYc+g8q0QTC17n+
         oiCu2bWJgByF8hLFcbyTw5vh5oXxOnxX8O5hsaK09nOcI4u4xkYPmx7w0EASAhjBTrzu
         FKEIOYTicG+eniNdUO7DEBV73/dbagX7BJ1pYOPExDc/MNz9soSQh8SLVP6w6n5ltZ+E
         oLEFThvI4pL3JCFN3YRCpdYFxWQh9IWR2QXzDt/IHYW0ujGLRvk5tQiA5/QOERFQy9aq
         6lQA==
X-Gm-Message-State: AOJu0YwkVRnTNkdmhjabQ+wxR3N9hEx3J7hG8Z4ycOzuVNpUToK/3kyw
	FX1qitvws32lz4U0Iw+77654b1PHTqJozT2iqz3t+tjV9kG3AhVWZeFAyJFoaQ==
X-Gm-Gg: AZuq6aLJsUygu3Yn7jgLMso2kpBHoES3tQtu/v7IDTdiZeEEGiGogJzb+nPvbHjzdqP
	c/EqrdtHMyuAmx2TkhKEFj7YzfL2/OIwG3ukvwERw2atMcNjxdMsBrCTUv3faZh3NSjad0U1L97
	wBeKMD3rQBSBhXgLJUuXOj9zLYL9h/wSbkeJyv8Bj1eIq47QNhtnjgt8ctZBZCtRI2atzeDabC7
	vVsdOotjRqoO10PKXPzvNzsv4+LAcr7/TMa3reYO1Dit8mzAxmGa4F3g0fD4e1nxoQ6KYfT/r40
	a5zQIhDwaTkS2QyVDXkruUPB05NnucYCUqlhQK5H+r9On/0oEvohRiPtYXP4EPAv7WBZ7G2LT84
	sH6QUlWzNvsS5tntEAymF+99YulyMAnu+mDYKw7po0U5v/Nkdj7r7xwaOrx/0lCJLp93/M7UzDJ
	G9BhbJQtwztc8bQNxEYcJ7HkFMWDioPT7PVLHWvb96d35e/ocP48XldUieKJ2SZz4BNkfkQZB2r
	YCFsw==
X-Received: by 2002:a05:6122:3103:b0:563:60ce:9d53 with SMTP id 71dfb90a1353d-566a0041dbamr1301599e0c.9.1769801986453;
        Fri, 30 Jan 2026 11:39:46 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 16/35] doc/org.bluez.Adapter: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:38:58 -0500
Message-ID: <20260130193921.1273263-17-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for D-Bus methods.
---
 doc/org.bluez.Adapter.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.Adapter.rst b/doc/org.bluez.Adapter.rst
index 41d6517b512e..bef7a387512c 100644
--- a/doc/org.bluez.Adapter.rst
+++ b/doc/org.bluez.Adapter.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.Adapter1
 :Object path:	[variable prefix]/{hci0,hci1,...}
+:Used by:	**bluetoothctl(1)**
 
 Methods
 -------
@@ -41,6 +42,10 @@ Possible errors:
 :org.bluez.Error.Failed:
 :org.bluez.Error.InProgress:
 
+Examples:
+
+:bluetoothctl: > scan <on/off/bredr/le>
+
 void StopDiscovery()
 ````````````````````
 
@@ -67,6 +72,10 @@ Possible errors:
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > remove <dev>
+
 void SetDiscoveryFilter(dict filter)
 ````````````````````````````````````
 
-- 
2.52.0

