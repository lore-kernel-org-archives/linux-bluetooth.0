Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845514E2C2
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910155; cv=none; b=NEaV+iYtzjzJakaxqG0zt7aEP6/qTzeMRNhj34LiUcRWTiaIQUFAqghZ595gXebfXXbkFsZo9hFvQIXwP+U4Bh7sHtz8GKQNhnB1cI86UImWrawbsUvI4P2XJMoztAX5PQG1llAooc69U5KUNh82E7dLPjXpcVBFdx7BRdkxJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910155; c=relaxed/simple;
	bh=sIwc6ePtSzw560EK6jNHzIqsaPWzGQU3M10lm6e07TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6ahbjIUTYbBcyWAA+arGojDoMWTvZ4eNL44MKGq37AVdwoMa3uwoeiSfFdFGD3K5AqPNBYVJTTgyVaQhvsaP2BuQqv++dlaDLa+OHKGJmPqT8OoPv+I8/zmu3gHuS1QE+UHMmWsiajyGoOQrW7XB3Q5QXkr7MGDdjKn+lqa9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3AA6FE000F;
	Tue,  2 Jul 2024 08:49:03 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 8/9] sdp: Fix memory leak in sdp_data_alloc*()
Date: Tue,  2 Jul 2024 10:47:23 +0200
Message-ID: <20240702084900.773620-9-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702084900.773620-1-hadess@hadess.net>
References: <20240702084900.773620-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Make sure to free already allocated memory if we run out of memory
before the end of the loop.

Error: RESOURCE_LEAK (CWE-772): [#def8] [important]
bluez-5.76/lib/sdp.c:542:4: alloc_fn: Storage is returned from allocation function "sdp_data_alloc".
bluez-5.76/lib/sdp.c:542:4: var_assign: Assigning: "data" = storage returned from "sdp_data_alloc(dtd, values[i])".
bluez-5.76/lib/sdp.c:550:4: var_assign: Assigning: "seq" = "data".
bluez-5.76/lib/sdp.c:552:3: var_assign: Assigning: "curr" = "data".
bluez-5.76/lib/sdp.c:553:2: out_of_scope: Variable "data" goes out of scope.
bluez-5.76/lib/sdp.c:552:3: overwrite_var: Overwriting "curr" in "curr = data".
bluez-5.76/lib/sdp.c:545:4: leaked_storage: Variable "seq" going out of scope leaks the storage it points to.
543|
544|		if (!data)
545|->			return NULL;
546|
547|		if (curr)
---
 lib/sdp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 2e66505b21b8..b87951b007a3 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -513,8 +513,10 @@ sdp_data_t *sdp_seq_alloc_with_length(void **dtds, void **values, int *length,
 		else
 			data = sdp_data_alloc_with_length(dtd, values[i], length[i]);
 
-		if (!data)
+		if (!data) {
+			sdp_data_free(seq);
 			return NULL;
+		}
 
 		if (curr)
 			curr->next = data;
@@ -541,8 +543,10 @@ sdp_data_t *sdp_seq_alloc(void **dtds, void **values, int len)
 		else
 			data = sdp_data_alloc(dtd, values[i]);
 
-		if (!data)
+		if (!data) {
+			sdp_data_free(seq);
 			return NULL;
+		}
 
 		if (curr)
 			curr->next = data;
-- 
2.45.2

