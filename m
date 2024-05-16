Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8518143759
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850234; cv=none; b=BBJABcQJ5HzcLh49cvA11ipDvYcLFNq2hUg/Wj5yUmYkjj3aSODI6y3Z+1YbHXPoWqGFlFOmak5NSsui5wguzaJfldb9gRpfNd9oJvCQII9KzU9BuRGuJB3B1mN0PovzKWlRvTwj3bITnfB11XBx9RVB1BeUCkB0byuGuLnCohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850234; c=relaxed/simple;
	bh=rOEszmPbnYyS77rY0Dsii53mLdACyh6/1Nz812y6sT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBvlcW0FL78q42dCgcTwy4an0SThVURZBHgEA7DiSMG2D6NuJAZ27J0Q12N37sZSStkkMTPcxvk/hUNFicYSW59CaWyvSBa5qGgFTlvA02kJzjuGT18zXQG2utxudzvmkEACn25XhTtX+dGWeY37BfbtAaecgm+A6fgGJvhMR0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B8571C001E;
	Thu, 16 May 2024 09:03:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 14/15] shared/bap: Fix memory leak in error path
Date: Thu, 16 May 2024 11:03:18 +0200
Message-ID: <20240516090340.61417-15-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def38] [important]
bluez-5.75/src/shared/bap.c:6066:27: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/src/shared/bap.c:6066:27: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/src/shared/bap.c:6066:27: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/src/shared/bap.c:6066:27: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/src/shared/bap.c:6066:2: var_assign: Assigning: "base_iov" = "({...; __p;})".
bluez-5.75/src/shared/bap.c:6070:2: noescape: Resource "base_iov" is not freed or pointed-to in "util_iov_push_le24".
bluez-5.75/src/shared/bap.c:6071:3: leaked_storage: Variable "base_iov" going out of scope leaks the storage it points to.
6069|
6070|		if (!util_iov_push_le24(base_iov, base->pres_delay))
6071|->		return NULL;
6072|
6073|		if (!util_iov_push_u8(base_iov,

Error: RESOURCE_LEAK (CWE-772): [#def39] [important]
bluez-5.75/src/shared/bap.c:6066:27: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/src/shared/bap.c:6066:27: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/src/shared/bap.c:6066:27: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/src/shared/bap.c:6066:27: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/src/shared/bap.c:6066:2: var_assign: Assigning: "base_iov" = "({...; __p;})".
bluez-5.75/src/shared/bap.c:6070:2: noescape: Resource "base_iov" is not freed or pointed-to in "util_iov_push_le24".
bluez-5.75/src/shared/bap.c:6073:2: noescape: Resource "base_iov" is not freed or pointed-to in "util_iov_push_u8".
bluez-5.75/src/shared/bap.c:6075:3: leaked_storage: Variable "base_iov" going out of scope leaks the storage it points to.
6073|		if (!util_iov_push_u8(base_iov,
6074|				queue_length(base->subgroups)))
6075|->			return NULL;
6076|
6077|		queue_foreach(base->subgroups, generate_subgroup_base,
---
 src/shared/bap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0026bc8dc989..48b6d7f4ea85 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6067,12 +6067,18 @@ static struct iovec *generate_base(struct bt_base *base)
 
 	base_iov->iov_base = util_malloc(BASE_MAX_LENGTH);
 
-	if (!util_iov_push_le24(base_iov, base->pres_delay))
+	if (!util_iov_push_le24(base_iov, base->pres_delay)) {
+		free(base_iov->iov_base);
+		free(base_iov);
 		return NULL;
+	}
 
 	if (!util_iov_push_u8(base_iov,
-			queue_length(base->subgroups)))
+			queue_length(base->subgroups))) {
+		free(base_iov->iov_base);
+		free(base_iov);
 		return NULL;
+	}
 
 	queue_foreach(base->subgroups, generate_subgroup_base,
 				base_iov);
-- 
2.44.0

