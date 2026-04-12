Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE7D19067C
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992311; cv=pass; b=YDLMrpKKnT0cAEwHBKLnlTKQosf4ejzOSy2dD5kIH9dIxk7rWdsRKLdch3oR3twpymtxh1O+TysFdKb1I+VEcQo3lA/9SogOMrfZ24Op7aZ1qzrPg/9EtHBDQkiKcYe9RWfS90aHX840fQCpN+ogk963lySWaVggGy93jx9r1R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992311; c=relaxed/simple;
	bh=J4tXzbD7oeIOa0srcW0jdM7DEMrw3aV7z3iz/DmID2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tCQq4a6ABen7KVw8ri6zSGRQmZmADbwafKhZPyeEUVDqfcLBYFfk3K1PbdEPSw0SqEumd92a7QxbdpS3YQbBuihILT1y+gPAHGGd3k6E1tmiCfKp+AerfbLufCGvN01X/ORx8cIKBgVEtOdVvCWhEreM5bcj5qwiM5xs+qkeo6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=gaxO4qNK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="gaxO4qNK"
Received: from monolith.lan (mobile-access-2e844b-114.dhcp.inet.fi [46.132.75.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ftnt12zM9z49Q4q;
	Sun, 12 Apr 2026 14:11:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1775992297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n4BgAIqogNPGyUoPY7O2RbyYQmAcy5algnXKVV++r2k=;
	b=gaxO4qNKTHmiZpBrPbC0Foq344q7OSW9yXe1yaRNFX1F+dePgKWJA9LD0eqnZBYufuFsrj
	tMKgOrAukReSCNbihS8nufPkMSRO2VMoOiMellAG6YrLPpUZGohg+t7pRNW2m34CWqwi6U
	H5eqf3v5ygSizxGTgPN/ms809M3QvI/PMF7rtaKzThSqbMZfzNqV0rNB//4vTA98Ejw+Vi
	6OaGlmYkor2W6I9J3gPmYMfomK0KG2yOc9KkSXo94J4WqVcVNVE0n9trqwQxweaLNgXZry
	yuGBT0bXPK7zhJg/q1Uc1M+mpPyk7rC54QsRQKwVMXazXMU8mmqm9n4BkYWjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1775992297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n4BgAIqogNPGyUoPY7O2RbyYQmAcy5algnXKVV++r2k=;
	b=DITQoZ226a1wWAhZB9BBpTofHbRu6434jsSJ/waiJRL+Y842lJjSKfCfJANBnT9t0GQSmz
	Mte78E6oJh/LqVovoU9mN7ycGEn5dr71Oc2z9w+ThIkavutRxnP3uQQHHf+to7H2a63h+p
	u1EbbdKPnOtJwHnq0lNoOauiAKP5BEtHshlx9HYVK9LfJfODuj3cUuXjpuZSAi0mjJBqB8
	V6UdfpXrib4o8S6SRk4HnkB1DQXPovacxVDvWScnUVURX+mWU8cDqqbosnBTNYQTmu+AWc
	qiD3wtAaTQ+YSrkzz6uH3I7qpVwjQJ8zzK7QdqPxkjQbOdCPlnalfr57pbn0yA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1775992297;
	b=V+k7lpzmtAGkOkz1Cw4ZY1D0XuuWqWNuhdEYEejn4LTynklXLtuTGrGPWanQ4k70hFG9jc
	JY7iTFVGY/WjcIhKVV5HSlABgukKNELE0tbwd9BcQ68eZJUUxMVIXbmz6cz56f26PvwmM9
	Ex/QSYop6pmrivXpWuclJpmjdOLp853oxYxmXkZLO1QGeZC5AkZ7qisV5ssCMKe+9nf3/v
	ZmPNIVpk8TqlucS//zxQ4+73TeK5fd/ih/+M+Xx+9gkAQgXnwC2JrJppGjkWSWOqGi8HT6
	+ldSCyhWqZzZI0r0AQGnnnAjmhIIRvbQQD0uBwDb8nVsGu0tC0iILFzof4Cm9w==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] gatt-database: remove database from dbs list when destroyed
Date: Sun, 12 Apr 2026 14:11:30 +0300
Message-ID: <3806351a2fbd1b5e463c9530203f7d121f673f61.1775992233.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btd_gatt_database_new() adds btd_gatt_database to the dbs lookup queue,
but nothing removes it from there even when destroying.

Fix by removing databases from the lookup queue before destroy.

Fixes crash on adapter removal in some cases:

ERROR: AddressSanitizer: heap-use-after-free on address 0x7bd476be1308
READ of size 8 at 0x7bd476be1308 thread T0
    #0 0x00000064562a in match_db
    #1 0x000000865410 in queue_find
    #2 0x000000645671 in btd_gatt_database_get
0x7bd476be1308 is located 8 bytes inside of 128-byte region [0x7bd476be1300,0x7bd476be>
freed by thread T0 here:
    #0 0x7f1478cee4cf in free.part.0
    #1 0x000000621625 in gatt_database_free
    #2 0x000000645582 in btd_gatt_database_destroy
---
 src/gatt-database.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 5819c2529..39e6a2593 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -4147,6 +4147,8 @@ void btd_gatt_database_destroy(struct btd_gatt_database *database)
 					adapter_get_path(database->adapter),
 					GATT_MANAGER_IFACE);
 
+	queue_remove(dbs, database);
+
 	gatt_database_free(database);
 }
 
-- 
2.53.0

