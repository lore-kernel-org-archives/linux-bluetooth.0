Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE0426693
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 04:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792383016; cv=none; b=gwU2nVtNQEgqm3Qf6xToUMfIsvYl4VwQGWVLVpJH0mG2gK9Cw+Oru8GsRWgkYR1oJPJayPNX2g+FGxJnn7xETWeOTbqWYR4hOxj2L3EDF56dr2SIADS9ovZpn2h5ErqLHslP/FWhBLFF01On9UHwSVRBnDQRzHj1PG+adyAqamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792383016; c=relaxed/simple;
	bh=q1+R4B1Bf9eHmEu/osfiFGXiDNwFhfxbuw8N3QCFqE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlYARpy0ezFKLKZzrOhK3xTOzJWWU8yJgs25YxHDR0fhyQkWNrAvk2p1gnqTpzqoJd9Ac69zVznyLhEmlFvLXM8jttcR792ClFS98xsbtv3cnEY6fcdmx55mCiq3y5k6l3yLaTNoMXbYCadIxplS9N+m1dJqVN1jBLdmri+bniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=xKE5TlUA; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="xKE5TlUA"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso4145998eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 21:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1792383014; x=1792987814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mbTNE+i3B1TRFh0r6uZ7rxhhowuzkjnLz5nLjcm+fYo=;
        b=xKE5TlUAeLZyg6Ilsd41IfQ+A5WaBl4o4PQB2CWqGCkLphPbIZ0l8Vx0G/p/F2V2IC
         fCosNGHKSrAx/xMHqKEF2Som6kEKCDVojt+/F8naFK0Be3FQXpdSPvKh6Z7LnDHErnT4
         p4biQzYNtE8u9f0eVJE8AnSfZkljlAUcRg48E20BAvnZCs1PfuO4cJZLrFHTBDcmNiAQ
         U7Td7JXNuOUa6sWjTekKpcV5oVqe4GbOJRCQZe8r7ZuLLqnC4wUizeihfomJ/GzuqWkA
         DBVeFEKSD/NnDyK2XXJHv+xCmpOEo+Bj3SCuqdV81h4c1SwoORwCYtfDnm4fteurYoEL
         VIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792383014; x=1792987814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mbTNE+i3B1TRFh0r6uZ7rxhhowuzkjnLz5nLjcm+fYo=;
        b=HZwiO9+altSsddF/Ine6zGBW3FZuSrHfnFoPhDoVYILJKQnKZJ7UaMmIi13bivHXG8
         9ZCAsKNTLJN0ODE7+lxxsKpYqbk1o3qD8HqNmenL6Z0HZKbiq2i1S8HdCvKvwMfVUpbf
         oJSyA7+GkUKQuwqMBgwPKyFjs4/ZkMY7ESqh6jLq9mlfP5T2M691mn5OigaV+Kor4Ohb
         zU8xKtW4UKqIem47482L/u918hNhB1y+hy2YxwAGyhG4w2BFwmJLnrcjUNWeqmcYC0Wg
         JaKcU8L4DTyDfN8/4J0YJN4Ay9EJ/4eIp4bRTlKlIF26gkOIVd3t+FiH8qfxRf9aa5MC
         +yBg==
X-Gm-Message-State: AFq9FYINTB0iCsJTYFAU1y5h7BPzH6ogR3+9DT5zuVo2mv3KgyiYArmK
	sl5waz+FEJGSNTrID+PB1/vYQIxmyhCUqLfJV1fnclXEFMg+z8CcLjLKCRgpDX15Bu0cWjncm3Y
	9esi32C0=
X-Gm-Gg: AYBFou3k7N1IWDMSIytto5jK8OQCf8ijZ7gm4J5k3N1L1mGrcDCeGdmwyDPBnSr6Bd+
	k1ceI55EnvuCIoWzaj6hN68hbiAdwkRzgmylGz8Yh0CoP2vOLL1t2g7UN2jN3lfDw+ISxruXd2i
	mjFGFIsftSPGtd45omAlMIB1ySyzqgslNaR4guvrRf6I4tMqDOb305sMP2FpFF08T65BTPQgTUm
	8dP/SwZQnbKEwfKT2V0K3ibNLzQ/rlc0lg6huMveE7ESpfAwE091rpXVRmeFNyR5iB2TLxeGimE
	C4UZp3mTG612rReeQsYBh88f0kaspKAZPeQvvXfmmQtmU4Z673Q6ARTGS2mIbgXD1s6hjrPMHIO
	ewkOQN3n0tBKNZaXLdGGFkukSJYLnJvUjMZFTL2Fca6yMwiAXW1KIfbs3GVfsrZl5vfgcTDutwo
	2EUT0MgTcEpuswGRCRdjB5S/t4jOPYpwKt8TPLbFm/uYtC4NhVTO7GI9np4DjEQclbYsU1S7TAw
	LfUdVEgtVx7zxbHgNT9urWsP4NfObR9mvH4OnL4/sSGrwydIBuQPYOIOJT9b9IFa5uwxFYbsDtn
	5sfe2njHvo4+Q8AslSwm9OryDYBPgER6sAr0iOHn
X-Received: by 2002:a05:7300:dd0b:b0:353:812a:f43b with SMTP id 5a478bee46e88-361a264cc41mr8463277eec.26.1792383014183;
        Sun, 18 Oct 2026 21:10:14 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm31999401eec.6.2026.10.18.21.10.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 21:10:13 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ RESEND] monitor: Fix legacy SCAN_RSP PDU type names
Date: Sun, 18 Oct 2026 21:10:09 -0700
Message-ID: <20261019041009.9720-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The names of the two legacy scan response event types are swapped. A
scan response keeps the properties of the advertisement it answers, so
0x1b, which has the connectable bit set, is the response to ADV_IND and
0x1a is the response to ADV_SCAN_IND, as listed in Core Specification
Vol 4, Part E, 7.7.65.13, Table 7.1.

Fixes: e29ef3b85116 ("monitor: Add LE Extended Scan commands decoding")
Assisted-by: Claude:claude-opus-5.5
---
 monitor/packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index fe7b054dd..a301e1ae7 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13076,10 +13076,10 @@ static void print_legacy_adv_report_pdu(uint16_t flags)
 		str = "ADV_DIRECT_IND";
 		break;
 	case 0x1a:
-		str = "SCAN_RSP to an ADV_IND";
+		str = "SCAN_RSP to an ADV_SCAN_IND";
 		break;
 	case 0x1b:
-		str = "SCAN_RSP to an ADV_SCAN_IND";
+		str = "SCAN_RSP to an ADV_IND";
 		break;
 	default:
 		str = "Reserved";

base-commit: fa6ba55020dee3c3183041c854c347b4582448be
-- 
2.54.0 (Apple Git-157)

