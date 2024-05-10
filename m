Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290C1635CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332708; cv=none; b=gu1m5yVB7BsreN576lCMnzSyFExfqh7F+5rSHuttapbQIee6rVv31EdQDKcBkXQCrzhBZSlz5XY2Qt195pTeJl7aCzA/A7CnoMROxXqMd9gDHQSNNmSUhFOWjfHNp2KZxSAUi3h1yublKvMQtx9jx8YtbCljZzgoKLeEXFsKjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332708; c=relaxed/simple;
	bh=KfzM9M9j5GTuPghCb5LA3rp6JbWwmqCc2mF+vpZC2oQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgpuaMIFnC6m+qPeVlgFhw0De4gTWiRP51v68DRLh/yQ3JVkFU1/Ssjp479rpqVzYVIvo5/L4OpSxgyniS7MWjvUuzBu0fDO0PtVvq570zKUtXCshnpy+ik0ulS13Ic5ypvthOiWtqlV0PfuOGD7Cov3qwAksebL6QoRRl36fdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D3561BF20E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:17 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 10/14] main: Fix memory leaks
Date: Fri, 10 May 2024 11:11:08 +0200
Message-ID: <20240510091814.3172988-11-hadess@hadess.net>
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

Error: RESOURCE_LEAK (CWE-772): [#def51] [important]
bluez-5.75/src/main.c:451:2: alloc_arg: "parse_config_string" allocates memory that is stored into "str".
bluez-5.75/src/main.c:454:2: identity_transfer: Passing "str" as argument 1 to function "strtol", which sets "endptr" to that argument.
bluez-5.75/src/main.c:456:3: noescape: Assuming resource "str" is not freed or pointed-to as ellipsis argument to "btd_error".
bluez-5.75/src/main.c:457:3: leaked_storage: Variable "endptr" going out of scope leaks the storage it points to.
bluez-5.75/src/main.c:457:3: leaked_storage: Variable "str" going out of scope leaks the storage it points to.
455|	if (!endptr || *endptr != '\0') {
456|		error("%s.%s = %s is not integer", group, key, str);
457|->		return false;
458|	}
459|

Error: RESOURCE_LEAK (CWE-772): [#def52] [important]
bluez-5.75/src/main.c:451:2: alloc_arg: "parse_config_string" allocates memory that is stored into "str".
bluez-5.75/src/main.c:454:2: identity_transfer: Passing "str" as argument 1 to function "strtol", which sets "endptr" to that argument.
bluez-5.75/src/main.c:463:3: leaked_storage: Variable "endptr" going out of scope leaks the storage it points to.
bluez-5.75/src/main.c:463:3: leaked_storage: Variable "str" going out of scope leaks the storage it points to.
461|		warn("%s.%s = %zu is out of range (< %zu)", group, key, tmp,
462|									min);
463|->		return false;
464|	}
465|

Error: RESOURCE_LEAK (CWE-772): [#def53] [important]
bluez-5.75/src/main.c:451:2: alloc_arg: "parse_config_string" allocates memory that is stored into "str".
bluez-5.75/src/main.c:454:2: identity_transfer: Passing "str" as argument 1 to function "strtol", which sets "endptr" to that argument.
bluez-5.75/src/main.c:475:2: leaked_storage: Variable "endptr" going out of scope leaks the storage it points to.
bluez-5.75/src/main.c:475:2: leaked_storage: Variable "str" going out of scope leaks the storage it points to.
473|		*val = tmp;
474|
475|->	return true;
476|   }
477|
---
 src/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/main.c b/src/main.c
index 23af6781d931..ac840d684f6d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -454,21 +454,25 @@ static bool parse_config_int(GKeyFile *config, const char *group,
 	tmp = strtol(str, &endptr, 0);
 	if (!endptr || *endptr != '\0') {
 		error("%s.%s = %s is not integer", group, key, str);
+		g_free(str);
 		return false;
 	}
 
 	if (tmp < min) {
+		g_free(str);
 		warn("%s.%s = %zu is out of range (< %zu)", group, key, tmp,
 									min);
 		return false;
 	}
 
 	if (tmp > max) {
+		g_free(str);
 		warn("%s.%s = %zu is out of range (> %zu)", group, key, tmp,
 									max);
 		return false;
 	}
 
+	g_free(str);
 	if (val)
 		*val = tmp;
 
-- 
2.44.0

