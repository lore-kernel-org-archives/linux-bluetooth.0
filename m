Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E8425CF0
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328519; cv=none; b=nnydP1EyPUbJIKEMui/62jUMaVjqQ/26cNYPSvi9ByVrTo78CNHCGTkf7NMpmHiYZ8dtUve3fO5Ch6/IDRTKovYzd7PZ1Q4XQM5np8vpGTCAfG7Ucv4seCAXiA/cI5GlL1FQp9KmQ7UVD57Ov42gf2+FQwhu/XNCtbH+Y0nDEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328519; c=relaxed/simple;
	bh=fHa+Qh0tZuEBxQOujxQsVtCdcROzNffDDKhi8iy4DqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqjibPS1ot27fICyzfGnfaBu2r1PAkiiv+kww/b0goF4ROPSt2q8wv4YlJnYbmmSO1ag/KUx5PRFWnXyIfO/ROn7Em5WfNC+cNcUkb+F0OXbHDoOKwJTdn/q2mbCb0+wi8OaBPXiLeWD8WRKVK38qxzGNWItrBRy6oH1W5ilZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=sUOL+jKE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="sUOL+jKE"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15c42a45adso376120466b.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1787328516; x=1787933316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iuMMHjbKJJyWMZllW2/YDxgqwLDnv65cDL/gLe0ScWk=;
        b=sUOL+jKEkW75xmf4IN906YwE2NhinRrCtzS/Olq9o/a1rlPVPFLWDtLggNNUEdDlJE
         9tLio6hiWlykrH4iPLF4HS5iJ3dhkR+mHmH8js19/+LtgmmH97S8+8YrWiR7UQYHmOuJ
         UH1fK3yu5plNt6NE8eyjKXUklxx6FOAJY42pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328516; x=1787933316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iuMMHjbKJJyWMZllW2/YDxgqwLDnv65cDL/gLe0ScWk=;
        b=HAqUQU7gHKmIyQt47lytsoV5wmAAJocqXbwp4fEHkorjS6+u/9lvf/aExZxKNQncuP
         /dPArt2CeI9ITBKrFJxeOWpgGUmbbqFwBM874ljGnPmXQ+FC6VN1UA+RYKcoAWKZTavU
         PBIa/WZmFvu2STIGe1uhyiHAKT0oAZe/BBaXpvuk6tbqo1CY66oQ4OxyXbWpfNCEnY6i
         DzkHFq1x2gLZBhKHUNgnQ5aAci5xTSxn/zgQ54N/VtwmPbIfiUg7DGSm5gu7l1etyUIf
         kO4CA1EqCQVNGJt3SkTHUIVtc1mgi6lY9Gep+w0GBuBBfehjHyHH9kPJ0KQ9mbs+E8c5
         +8hA==
X-Gm-Message-State: AFuF++kTs9IG102fEC0w1/WPadQubv2g67+TpmCU9yU04Q+4CdW36B6/
	gs41j3iXQbAKFCISpA5KCGVFjrO6hRIP/dkqtr4v1kKd78+3TZDnGZpTzeRJ4MeymeQgq14MNfZ
	XEg/hwc0=
X-Gm-Gg: AR+sD10dIcpUG38HUMRMKcxiVpKZyH/FCZB/ofoqVwqTh6NdOH2L5QBFTLiaiA1eEN3
	MLI09baereDuPPcqW3Bby2ZDumOLynqQC63Nnv1aQ5TI22ZCpwNyi1WhNi6I/2sO/HM+IOrdhNI
	zK6jVhENbEhIAyTMm02upsXrYntzAzhKSdw3YxPEIjBUAQZ3fRtV0D7EDRtx/enP6hF02xlLnr7
	oaRlPzklOvbscVEjAmjglb9jw7wUV5htSxluEnDnIzLWVkqIAi2GEflcBS1xHatf58qf92XVrd8
	eHu9CytCOkrAsmlv0GmkuvQWfssGj4mhTfNHixoKv8B+yMWOuKfuF7svKqJhGvA81G+iL5GyjJQ
	Tc+mWNvqKoCPFlTmr3l2MiawSI1xvI1v0DB/5g/a+SPVQIBDmtle/NZo7xKKOMNm/4gWKAu15pJ
	VlJ4wzEW1QQDZlH+7uYQXnQWNLNfx9Od7K2jtcG5nUYyft53zH47KDTkCMLtcLbHM8dvUlC9GiB
	NN8uoeSWpeqPlortZSHSref8QqHEPHu9smElHWB+zK3o5CC5/SJJUralMfL/1y9CWiQ7eR48O10
	oe6IZcdn2QTDiPlJoBqFZzMFYaEeAA6r2eJZ7LNPr5M01I4avpTdDaCPepET1W9+6wvILyGxHWs
	h7armdPdR/ABItNIBeg7jbairh0RFqUbYNdeZ
X-Received: by 2002:a17:907:c30f:b0:c20:367d:f8b8 with SMTP id a640c23a62f3a-c244d4f05efmr1284347966b.4.1787328515996;
        Fri, 21 Aug 2026 09:08:35 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-5231-6791-f21f-fc93.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:5231:6791:f21f:fc93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df29esm471299366b.47.2026.08.21.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:08:35 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ v2 2/4] doc: Document component battery objects
Date: Fri, 21 Aug 2026 18:08:01 +0200
Message-ID: <fa01e7967b8952a64e28a4eddbc8b1b51b8b38ec.1787327795.git.m.kurz@irregular.at>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787327795.git.m.kurz@irregular.at>
References: <cover.1787327795.git.m.kurz@irregular.at>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the experimental component Battery1 properties, their opaque
object paths, and how BatteryProvider1 implementations publish several
batteries for one device.

Assisted-by: Codex:gpt-5.6-sol
---
 doc/org.bluez.Battery.rst         | 35 +++++++++++++++++++++++++++++--
 doc/org.bluez.BatteryProvider.rst | 16 ++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/doc/org.bluez.Battery.rst b/doc/org.bluez.Battery.rst
index 5f9c6e7c6..e68c5d260 100644
--- a/doc/org.bluez.Battery.rst
+++ b/doc/org.bluez.Battery.rst
@@ -17,15 +17,27 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.Battery1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
+		[/battery_{identifier}]
+
+Component battery objects are experimental. Their object paths are
+implementation details and shall be treated as opaque. Clients shall use the
+``Device`` and ``Identifier`` properties to associate a component with its
+parent device and its stable identity.
+
+For diagnostic purposes, ASCII letters and digits in the identifier are kept
+in the object path. Every other byte is encoded as an underscore followed by
+two lowercase hexadecimal digits.
 
 Properties
 ----------
 
-byte Percentage [readonly]
-``````````````````````````
+byte Percentage [readonly, optional]
+````````````````````````````````````
 
 The percentage of battery left as an unsigned 8-bit integer.
 
+The property is absent while the battery level is unknown.
+
 string Source [readonly, optional]
 ``````````````````````````````````
 
@@ -36,3 +48,22 @@ This property is informational only and may be useful for debugging purposes.
 Providers from **org.bluez.BatteryProvider(5)** may make use of this property to
 indicate where the battery report comes from (e.g. "HFP 1.7", "HID", or the
 profile UUID).
+
+object Device [readonly, optional, experimental]
+````````````````````````````````````````````````````````````
+
+The object path of the device containing this battery.
+
+This property is present on component battery objects below the device object.
+
+string Identifier [readonly, optional, experimental]
+````````````````````````````````````````````````````````````
+
+A stable identifier for this battery within the device, such as ``left``,
+``right``, or ``case``.
+
+boolean Charging [readonly, optional, experimental]
+````````````````````````````````````````````````````````````
+
+Indicates whether this battery is currently charging. The property is absent
+while the charging state is unknown.
diff --git a/doc/org.bluez.BatteryProvider.rst b/doc/org.bluez.BatteryProvider.rst
index 2373cebf9..b79cbe6f5 100644
--- a/doc/org.bluez.BatteryProvider.rst
+++ b/doc/org.bluez.BatteryProvider.rst
@@ -30,3 +30,19 @@ object Device [readonly]
 ````````````````````````
 
 The object path of the device that has this battery.
+
+string Identifier [readonly, optional, experimental]
+````````````````````````````````````````````````````````````
+
+A non-empty identifier that is unique among the batteries for this device.
+Multiple batteries may refer to the same device when each provides a unique
+identifier. They are reflected as component **org.bluez.Battery1** objects.
+
+A provider object without this property represents the legacy aggregate
+battery and is reflected directly on the device object.
+
+boolean Charging [readonly, optional, experimental]
+````````````````````````````````````````````````````````````
+
+Indicates whether this battery is currently charging. The property is absent
+while the charging state is unknown.
-- 
2.55.0

