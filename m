Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3917085C
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343257; cv=none; b=A9+v5zZWdEwCOkej3iiILkrCGm84KB87jljajRrKZ3TfkjD+lgiMCML76WOKWy7PV+LAmAyD8isv5gXYJUvDK/3gbGucnJwsSk3ALmtq9lyqb4mrBY88Juv+KHCBX939wAzCdBAOr+Y1qWLac/vvStxv955KYb7KwHo/xvRs9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343257; c=relaxed/simple;
	bh=Z3oDkp2d1HpjpI0Xro2LA2pKxiRZBZKIF2k7SUbqM2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVo/0tKzro4j0c0Nck3nA2xiDPQ7HvkpkaZ1uhwQuB9Sc/WVQbtaG+Tyo8N+f+YONyVCkcXUKVldrRat6gapvVDuYNMIbSxYOw/UUswN9GyS3CR2jp0AnlP4Kj2aYptGPGvDkafQWw/zbVB4u05GkVM/Jjzjve/aTgusPsiBIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8424360016;
	Fri, 10 May 2024 12:14:00 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 16/20] iso-tester: Fix fd leak
Date: Fri, 10 May 2024 14:10:26 +0200
Message-ID: <20240510121355.3241456-17-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
References: <20240510121355.3241456-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def63] [important]
bluez-5.75/tools/iso-tester.c:1796:2: open_fn: Returning handle opened by "socket".
bluez-5.75/tools/iso-tester.c:1796:2: var_assign: Assigning: "sk" = handle returned from "socket(31, 2053, 8)".
bluez-5.75/tools/iso-tester.c:1807:3: leaked_handle: Handle variable "sk" going out of scope leaks the handle.
1805|		if (!master_bdaddr) {
1806|			tester_warn("No master bdaddr");
1807|->			return -ENODEV;
1808|		}
1809|
---
 tools/iso-tester.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 046606068206..d54fa56ecd44 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1804,6 +1804,7 @@ static int create_iso_sock(struct test_data *data)
 	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
+		close(sk);
 		return -ENODEV;
 	}
 
-- 
2.44.0

