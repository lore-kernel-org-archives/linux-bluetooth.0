Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E91FCCFE
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572924; cv=none; b=r7y9i3cmyxuwAr845Ez+y+o9r7NW5ux/94VjYTgab+LBYGjQRY4ZnXJYW7nYLCj9Tk4Gr5vz0+1oPzGSpai/czK+/JEBTwjbuRuRMthvDYRO4p+8YmTA7FqVAwDSrEomCYTTvUudYRFhA21pmhhIZf9TrNRIGo0IqUTy3WasMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572924; c=relaxed/simple;
	bh=UussoHn+ga9geu3I0Q9P4VpTl0oZizRbVPry3DfE/JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpY0jtTxTN8A/D3QCVM8YI4Y7Gde6CPL2CLoXbonbsesNUTyWUNT2ENpze6jT6EMgMd7rLwkJg6xkYSUXNfTJn0KzZRZtu6JBK8F2kObrwZfZ7+mnef2azaA7aCDoyw2/s9F3ADYjv4cpclRedSP8thgo1LVFxa6S2AwXpCwVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrxWybLL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrxWybLL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43963935585so24070145e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 14:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572920; x=1740177720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Spw4PakIybEJj+BmEGkP4kFq6DWKtU/upOakBE4PnBQ=;
        b=RrxWybLLtqS5+oL3VfxugK4ek4ix05i2TpZNbdn726flRMSXqcmag0oCkH/gn98oSv
         WeXVNKYu6Yc0Tj3zcCW6jVSDZhAX8/sUyLVn1+8qhtq2Nmge/vrO9eWur4G8Af/UfZ00
         jy0rzOZEtSUXd0WRcxVf1EEne+4spqkWONQg6DP8Iuiuw9tU254kn4SNkVlmW08RyPWV
         tkkXyiMC7HmNVgBKk/NUto5Z73XTlU2OJRm5SVlIp4XrBsGa98M6tVGZnS2vkZlCoYI/
         /z+t8aPLgyMsymR4EGSJVFRH/uW5I7RBJkAiO3Fl1U0ewoZbACoNbDZ1JGDyFucBr9zR
         N7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572920; x=1740177720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Spw4PakIybEJj+BmEGkP4kFq6DWKtU/upOakBE4PnBQ=;
        b=pMhJ6tyxyQVifMShykhP+hhOLhyr4y0eIOcLbiDeByQIt6JcQrUuT4idSyEfMMFqub
         mffF9ZdQfWHhTlwHNVDKSrK/hWtcBNOgzh4PDVna42iEgAyG47tiLHWLXSyUHLo/jCbA
         ZN0mbJ++5aABLtlp4yZGMp7kKGn0iPs7dJuV8xJg67ig/By1/kpxQfUep+O3DfMSqZ8Q
         z58RM6hNfI1XN/p+liwLr78HMhuzxdIq77Q5QZ8BgZAnfMJfw7sUvKyOBLjTHMT/Szj1
         5wGFVubNSoE2sj0/p4Nys/awZ0JYEqiTZO84vx3Nx/Gm7GxeLg0UKBEOm8zzfGHnmI9n
         hDtg==
X-Gm-Message-State: AOJu0YxvDaaCN+/phJOPvPrX+PsodYSGsd/T2dckQjr+Y8u1YctDl0+k
	4an+NbkPW90wxr5+/Gc7lvpn2FMdVUA8LZ4VruQQ/lymB0/MU25EWfD2GjYR
X-Gm-Gg: ASbGncv3GNTCLTwk8nokGgoqtVHY2DonD9BRJzjX7zDV89FuSz2NdEh+6Zq0+tUeFXq
	i4AN2/TOUOvKmxLbt6yNAe14J5YaG3ryRPwqGbPyXgv7zCFirFQF1rjK1x5tC4r/h142u7fA3k5
	ktOewpmsqZc4EJLkSGquBwR9B3zbGXcH3AQTVGt0A6upIz5RCvDBzf2uAwaNTUwbT0+dq83b4eH
	0t6Ga/bz9YZqeNP5BhEAp2Ppc52yezCL2f+xYW50qeqUhZhDON2cOHrEM6d8B+rjCVy5kd7/x59
	8RCLLczfO/Vk4gFdWOLiBNr6
X-Google-Smtp-Source: AGHT+IGLg5BIt9lkjWOsfJi8wegy2XsnlBkZv/Ziz73cmDy4U5bDlpO23l0UNpvV9FkGr1GQxCrd8g==
X-Received: by 2002:a05:600c:5103:b0:439:65f0:c9ce with SMTP id 5b1f17b1804b1-4396e72a6d5mr9728825e9.25.1739572919663;
        Fri, 14 Feb 2025 14:41:59 -0800 (PST)
Received: from vibhavp-an515-58.lan ([122.161.77.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961645422sm34358555e9.2.2025.02.14.14.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:41:58 -0800 (PST)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 0/1] adapter: Fix unnecessarily enabling the connectable property.
Date: Sat, 15 Feb 2025 04:11:48 +0530
Message-ID: <20250214224149.135458-1-vibhavp@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
As the Connectable and Discoverable properties for an adapter can now be set independently, this creates an issue where if Connectable is set to true before setting Discoverable to true as well, property_set_mode will still try to set connectability to true, resulting in any future attempts to set Connectable failing with org.bluez.Error.Busy, as the adapter's pending_setting bitmask (specifically, MGMT_SETTING_CONNECTABLE) never gets cleared.
This can be reproduced by the following commands:

busctl set-property org.bluez /org/bluez/hci0 org.bluez.Adapter1 Connectable b true
busctl set-property org.bluez /org/bluez/hci0 org.bluez.Adapter1 Discoverable b true
busctl set-property org.bluez /org/bluez/hci0 org.bluez.Adapter1 Connectable b false

This patch fixes property_set_mode to only set connectable while enabling discoverability if it is currently disabled for the adapter.

Thanks,
Vibhav

Vibhav Pant (1):
  adapter: Fix unnecessarily enabling the connectable property.

 src/adapter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.48.1

