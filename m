Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C5417A309
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778109743; cv=none; b=ZJMjBRnAYkowEKK+djObwPKxHl9It3Gk60EeLIN72pyO52uvTg8vIe0L4tC4+jMxMKZBR8Zd7HTghzCgeNnsBqkwnHUHytNa0rPifMa5OpJlxRyYExZvPOrd0N2qoo1GHLh8Gbf0N/PCPXEXKR7/ze2akdsg/Gmk4Vi3J+i5F6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778109743; c=relaxed/simple;
	bh=cDw2eoeVzDm3fzJQaH/bIBhQlsXpKNmTmu3OoTScq/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=ouZanHCnWsiXrm/HCSjOPd9SY2gispW1jbhkQIJsV+t94NVJFdjOzFs45X1JtY44uGDf78otcASiiFiCKw/B7XK14PShG4wkN1SYJap1dW29KP676M8klb3CJOHsSkAY6hiwZ81n2HnJGAODagEUNSKOks0HeRE01ECOsZq0Yx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=F58XZa6+; arc=none smtp.client-ip=87.248.110.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="F58XZa6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1778109739; bh=ATilFgPSABKWyqRG1MhxRbVmr+UW++ItKIfVBetw9T4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=F58XZa6+IypGOrffDAwBpy4/XjuPR24w2Y1AdyMnD2sIA0d79ZN7+NP9vXR1lYvY9F0oiAvJkTQ7I0t+Ig5eMYGdDnrSYhi7g1oklIpSE4UnTs4pnc0OoCovtgarW2kveIJn7qXtTwWXjxiUd87zh1BXfNx40fcTC9/+PhPk2iKmTIkbmXLPwRtoNLS6/2pPLVYOLNS37juFp9BkNkZmfEh65M5ES5UwtuZ2cV3X6a08MVWYKZkg8vbECHOXB5H0wy10pRocf9kPJ0pSwxUQPXJpS6QBm5nCW+K45ig7EKBMAV/PzNqXAjXcwxZXD2NLJU5oLrm0Y+sztaPFDDksOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778109739; bh=ltfdItBoJAniq1F4YvW4d7Gtly8p7IeUJGY/swBjRaV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FnAud9TO+cLGpHKYp9RxwNK0p8D6fSatoXlsGNJ3DMAAYg/5gns5s+T1r4TVmSrDVv2Ww0OYgyuBm+dV91/gduo5GNyDFqBWpHbvqCO+PuiNwJabfdweI8ifv0ONsPA7r6Oo3uh+bVXYYl9gJSsb3l+ZBik1rhsJ5orGcQsW8hKm07WKH36FkqNpVQYUFdtOSJ3hgkbrJ18UtKJVcu0WS6vD27yc711bObgRdnAptaGWiFM9iGnxOWLvwnvDkKGQVXptU6a+natwBhikv7ClAnY/3Obq75HdvLUiAkejE83in9mKZYye7qZC2QVNvpAor1MH4ndbvc1A3Ql2Moz4aA==
X-YMail-OSG: yXpjhtoVM1l..0zGPeud68HQKrM3Q9YqI7IBdmwixP8Nv0u8Y9dIYdjgCMknGKl
 SJHZ3n4Cb9UtMI7MZuGGRRag06gq0Lo2lyqT3UT0ayQoVKTvedCXEpYXvZhCZcWB_NF7bwHvKHcG
 K4n34bY2MPKYZ5EAUgXGGDWPSfsX_.9la8.l28PeGsVPxQZbco7ShFkwryrHsU9cA2HHKU41kSLC
 uYj43_ko90DUrb8m0gNZYVHLnFFGVt2Uae9ahjAWGnS.P_rsjuIZUDxZA3rRzIPHysMqLgH2eHjp
 Ah2.zpJe.xKohzX1n0s2hzFJf_4t1h1mBeuRts1V_w5len5QN5PSkRG.aWc0.v8PfkcI4Uc.hokX
 i1wZTLbBiz2IYzGalbDyF_9a50ktTPZ6Buj4CST65xW8BbkwU4VM9LQim3lPLviyApfJ9LGxm1JX
 WrOGQwTBpVEThgbQhNsBkO7hN1f767uOgsvUZUeNlk6u.MT4QHUSSDcztztdLmzwnMQ9R2qix4hP
 R4o4Pzi71bELJ9oG1at6IENLPKxEGznNCrXScXAK13dnmIm3Aj69.5guFHC0qT2ItutPJFCE.EPV
 Dsfim6DFwbNCxzi67G2szCMI8pq3AvBrbLMd.KnMuNJh7_ZBBxIip1brDFqXAp13n23ekBheZiAq
 .OBaUnoEolzvBwA0kp0OwoTi7YcuDGGp1ztGwXxXIu99WptCeALwfQAkMt_XjdSWoADQob27BceY
 xFua9xCB631G4r9ohNu93pEenip0cYtBDkiVH3FenwEXrFECYB0QZipd3Uf_KV28xoPKyJiJe2Dv
 pE.1eJ9J0XCL3dEy7YjoVySEEe4.1SZKtOAdiY5xedD02.SPjTX6vQcmlmN4T2iqu.nIdJGCjtym
 YkLUJ7l2KNY15nEc9mOBp3AvR7wSnWW6K7J2q3OyRhXWXJaHxWrUSnhn1lMl8DUg5HE.ouXpQg64
 xZqJbLeg7XCwWXdnqLy08tqZVhQYx9yWBHmzXmxJKyQLpQrrXFF99zYDLySaDeykvbmweAnDCjOe
 XWfCahuXHPQ8p2TLZn89WUwiG.ezQZQr2T4r0RrxTzQ7SP79t3pWwe7sTSKhSDZVkU2So1nA1oIN
 dFcfCcIXuSanFdx_URLYDY5RJ.5FoxjqxX7VaFMdpuF4fLQ.P2IBGKKi.q0_PUEUBmhFgZXjEWZV
 h2KW1gyEiHn8HwWIeGTDtMWbAFicKHc.Ro2KwTfpYb3w8le9jpP0p7eGAJAN0w8mcq8i7.CBmIdB
 ojU1hkVv0kIsb_KtJgn._NKV58pSRfAgC.LD_qPjUpISxBAJ8rxPU3uiZgflwKUbQLmOPps0TyLE
 6OTyZsxmzM3.dk4K8ntikWpScS0HXkJWsv3xl.yonYWrnyUClD.p0THd3UOSALD48VYeT.SdYaaf
 htosd8jUPnJFH2mDXddmus4ET13f57J8JUTb3b4p.bpJcIhXtnkVypq.zJI9vkrNnB.ppM12Eqr4
 Ohi_LoAjjbfyYVgXrtgEZI8U7QnGh4mBDN9Jk.AkXVPZermaYdCNlZTeuEX8ULiFsemCLCLRNjD7
 7dkrXEnyJBOcF4yyHsd37nD4Mt3qg62WbAABHgAE.2i1UleHOZiGMJaFEyCyWk9nbQm0f9_QC0s1
 I6kCKlJW_jHUsroDHcNOP6Z5xlI.ZWy0NcQLqOwqqvj1ldTyV0DyMtMMVN7ntiVWxIgRic6QNAtt
 gx93kS6oDchOj6dID74RHDj0EzmN8pFYhI9HVHFFHFTUrQyhf285SmhZkdVD7pABSgYPzQhC5TW8
 NH4Evil2BkrVfG1tZRYHPLrq.TMpYgGe2z8F_v.3q_yLmqQ.9dcH0gZtzmc..c.S_5mwRuMiPWfU
 ZYASlISUi23HZlB0BWxzos1gUwblydW5OTe3kLqn2ae1DJJg2U5IxAk3yErE2VDHhcWVJMnJfUvw
 NiJZ13Yc5vPG71PdtOO8OFt.0XQRgFo6aC6.2ID86LmnzMEcAetvXPUbYp67cs4czIRgU7tUNi7q
 KekvN3d8rXw_MQ0.ldgRtgwn8EqbSZyaRe7_OPdpzGreol4Mp4AdLaXi0aw139mdT6_J9FcA7fCQ
 .YUC0GNr._SQgCsGgYvG5IAZBqRfzKkt5R.qwcAP6fGPPtecaCHOZ_OBKhY.6w8QjY0g3RlOlfzM
 D4dklCzRb13R3DJfKxJ2ifJPpK1I64yQIEdRmUmlR4otX2nhXleZpd7jK_HcMYqFt_0BzVjS3jH3
 .y9dnqgaJcbZH7phuDLTdGOu_EQrRuxmA5RYWB1Y90vDeNkgevPvF9_L42wLIFGDkK_D6tN4UpVM
 XlNBmqsk-
X-Sonic-MF: <thomaskirschner85@yahoo.de>
X-Sonic-ID: 10141319-6458-4f60-b4d0-c146c8c904e0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Wed, 6 May 2026 23:22:19 +0000
Received: by hermes--production-ir2-89844b765-g2tnm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ac19bc41bc5b6dbc8cecffcdea7c2ee8;
          Wed, 06 May 2026 23:01:40 +0000 (UTC)
From: Thomas Kirschner <thomaskirschner85@yahoo.de>
To: linux-bluetooth@vger.kernel.org
Cc: Thomas Kirschner <thomaskirschner85@yahoo.de>
Subject: [PATCH BlueZ] bap: Fix typo in QoS D-Bus dictionary entry names
Date: Thu,  7 May 2026 01:00:51 +0200
Message-ID: <20260506230051.27436-1-thomaskirschner85@yahoo.de>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260506230051.27436-1-thomaskirschner85.ref@yahoo.de>

MinimumDelay and PreferredMinimumDelay had wrong spelling, causing
them to be exposed incorrectly over D-Bus. Any client relying on
the correct spelling would fail to find these entries, breaking
LE Audio QoS negotiation.
---
 profiles/audio/bap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 5333267f7..b35542488 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -432,11 +432,11 @@ static gboolean get_qos(const GDBusPropertyTable *property,
 	dict_append_entry(&dict, "Retransmissions", DBUS_TYPE_BYTE, &qos->rtn);
 	dict_append_entry(&dict, "MaximumLatency", DBUS_TYPE_UINT16,
 					&qos->latency);
-	dict_append_entry(&dict, "MimimumDelay", DBUS_TYPE_UINT32,
+	dict_append_entry(&dict, "MinimumDelay", DBUS_TYPE_UINT32,
 					&qos->pd_min);
 	dict_append_entry(&dict, "MaximumDelay", DBUS_TYPE_UINT32,
 					&qos->pd_max);
-	dict_append_entry(&dict, "PreferredMimimumDelay", DBUS_TYPE_UINT32,
+	dict_append_entry(&dict, "PreferredMinimumDelay", DBUS_TYPE_UINT32,
 					&qos->ppd_min);
 	dict_append_entry(&dict, "PreferredMaximumDelay", DBUS_TYPE_UINT32,
 					&qos->ppd_max);
-- 
2.51.2

