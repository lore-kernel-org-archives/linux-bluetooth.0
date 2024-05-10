Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6401635C9
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332707; cv=none; b=cUWmF8UUZ4qtuLJDoC4/bfcACmb1MseQNH9Lw/OIec6k0ThK5GnHzySXCdR4pH5DDyahFSYYj1WIDT5IaWxjELIdp1xiTMPst5z7eUNbonaQHVIijlvblFal9kvQus+cfULp7tKM6rjQHLDVObzVOk0tqkyeJJadgM137BaxRto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332707; c=relaxed/simple;
	bh=XL/7SxkDVsEMuouDDcQaTT4AwMz/tx8Nfzhai1nup08=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbbIVtntTw8wmCvxKyvFQSYAAWg4gyjff5M/lia/zQAVRwIkUVwtABQXMR826hPkJMbEpC7NzrJLqz0LWJdz3RcbY/7uOHW792X6Rl9gjHX2fYKYJYW2VMuxoJHKxzpPByCRJU8OeeCngmaDMz+93nieziqpJxecsJWSpLSw3b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E9FB1BF211
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:17 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 09/14] media: Fix memory leak
Date: Fri, 10 May 2024 11:11:07 +0200
Message-ID: <20240510091814.3172988-10-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510091814.3172988-1-hadess@hadess.net>
References: <20240510091814.3172988-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def47] [important]
bluez-5.75/profiles/audio/media.c:1278:2: alloc_arg: "asprintf" allocates memory that is stored into "name". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/media.c:1291:2: noescape: Resource "name" is not freed or pointed-to in "bt_bap_add_vendor_pac".
bluez-5.75/profiles/audio/media.c:1297:3: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
1295|			error("Unable to create PAC");
1296|			free(metadata);
1297|->			return false;
1298|		}
1299|
---
 profiles/audio/media.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 07147a25d532..4bbd584deaba 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1293,6 +1293,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 				&data, metadata);
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
+		free(name);
 		free(metadata);
 		return false;
 	}
-- 
2.44.0

