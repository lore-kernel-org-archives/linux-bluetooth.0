Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC052FE071
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801990; cv=none; b=dz2pwObyRYLevZCPHfKfa50L7A0wgaIWy/LREmmrXrf+6pUxZ9C5iQS1LJ3dh1eWaNzCmf4DujWVrxXo7RT7rD0EzoeGiG0uCyLwrVWiZvN/0VznGnniLiU+rdREpjPMMpUhYOlwGxvZNYOTAq84+4PZDj+HZqRh61+GGwoYCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801990; c=relaxed/simple;
	bh=2xahQCYEAK31jKna2E/00bEjRQkYM36H6E/pKOVLxfk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/XZ37B9rt5qukp8TFbrxvnDR1NrtNkqbuXzc4n/wNfI96CQamSY//CCDP1ut6hIrnzgsDZeREsoHJr92Jjpkg/VRDqrsEGD4ChF2R+dSXnh+KdrjASKGWSZnGriRAaiY8tk1PNdjNUxa1aFZgzzwVyaf/PceyZXHau6ZTjli5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5mVH7Ii; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5mVH7Ii"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56643f72af5so874935e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801988; x=1770406788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTWxGSeQ5fQ1ZA7puYa2CwLbvLHzcPPUflto3Oq+s9k=;
        b=T5mVH7Ii54+dvrIgsyZyhDVSs2Fq6U22cRCjlepN8A8DxMvHSjXhjTWHUJMiUGh2mQ
         pOpX4hpaSL3edALJBvNBZArtFSdBqkRzxwwdn35viSnSbkOpSmpPdgXBkwujPPPs0ytC
         LnyvV+unzTxTXj3n4zFzqK/hc3fr37JZAV4K+Ph7r65X0QLS2IN88rKerEafTjXWDPuP
         fsNOsgFXFZekiAifNMkm9oaoCMA34ROeX/XLzkY1YDldr/kEPiorwRGQy0zRcStZkIWR
         NfdYmz/qpWWh7tUpY3up0gfvDnODVpzmHXyzbCTKre6dad6jZlxTp5jGKMAKCYNFkSrT
         xk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801988; x=1770406788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UTWxGSeQ5fQ1ZA7puYa2CwLbvLHzcPPUflto3Oq+s9k=;
        b=O/J2sMdAzGU5amhHN36/jXaGEj9Bf5aZST9v+k+taw2BC2lF/2qBNnvGGq01HRDdDa
         wSnULGKcQZjC+kc9JKx35iOntH/K743aCSb/lFJ/dC9GSIV9hDMFqxomY9Hq1V3g6DZn
         uzFYLZF6/np2ZN6oTWDVG7iUqEfNbd3Giz4eu2pC8KnmodjkAY8toOvneJKKWtCEikS7
         Jx1zX6e5Ihk8SpakF6XBfvI/gFbJFo4fHHvwvFsBoygiLj2un1f+wp45Vf8SD22GmCAc
         bv3jTz0OX0HsbW7/zTkRiHHygZFNOu8OKO0dWsYi/+pmI4LxfRAJCyPYADMljU9yyyaE
         ygRA==
X-Gm-Message-State: AOJu0Yx3c66W1kKujY1OMZ8/BTRy/aNDcifB6nXnqyLlljkIQGXKgHWw
	BDbBuKd7lXkaupO09P9X1VJGBMODHWrNL+AjnoJnGgVZzkaWfDXcFMWuKuO2jw==
X-Gm-Gg: AZuq6aKLb73wR2P/AoySx0zZ3CDHEHUWrtp96/ycZcvwxWXPlnEpM0+WXv2RUEhsiP4
	1GzmQibLzGWcs8SaoXaR1YmWGJmpsy3jILuqTbR/xLoMO72QwRYmXE6kKtAUZbvnnT2ocTgkQIJ
	SQba5APxnkyh60PSZ+bsQPcul22yGHT9thqApxJea6dTBCNjysHqJTl4Yxia/reSREh2j9t4jsr
	xDZizeev8rINHkZ2/8TBLq51uau79W2V9/nFprEldWJgx4Awzk3UBzZ2frYmk3jKdUrCBIDJh9k
	KD0uRhxGDn9vxf06/i7Dm7bMwOBRR+XHHjTaWHYC3hjsIbbnzEFskKgG9B1Wg3PYJrcHfh6Ycei
	XmgEAifEL00eyvkW7Bc7s+1z377BoP8Yz/m7eEwzwBIbX6TQSANLM7RwsV99wyoDaxXGje6R5tt
	cLbAz3zH+mf6dKEXcpw55/mfpYlTJaq4pywIIFjfoWRRzuIGcH7BToUsjxZy4CddsgM/AJmj1S0
	wQqRw==
X-Received: by 2002:a05:6122:1692:b0:55b:305b:4e45 with SMTP id 71dfb90a1353d-566a0143c31mr1087988e0c.17.1769801988179;
        Fri, 30 Jan 2026 11:39:48 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 18/35] doc/org.bluez.AdminPolicyStatus: Add Used by reference
Date: Fri, 30 Jan 2026 14:39:00 -0500
Message-ID: <20260130193921.1273263-19-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-admin for this interface
which exposes properties read by admin policy commands.
---
 doc/org.bluez.AdminPolicyStatus.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/org.bluez.AdminPolicyStatus.rst b/doc/org.bluez.AdminPolicyStatus.rst
index 18008a2b07af..702e020aa601 100644
--- a/doc/org.bluez.AdminPolicyStatus.rst
+++ b/doc/org.bluez.AdminPolicyStatus.rst
@@ -26,6 +26,7 @@ Adapter
 :Service:	org.bluez
 :Interface:	org.bluez.AdminPolicyStatus1 [experimental]
 :Object path:	[variable prefix]/{hci0,hci1,...}
+:Used by:	**bluetoothctl-admin(1)**
 
 Device
 ------
-- 
2.52.0

