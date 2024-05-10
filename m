Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED917088E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343259; cv=none; b=D8OaXV7Gk/luv3m41CZpT9brAy8JVddDbf27UqZ/Svqj6bIR+mwWgH7CGPjMACUan2TbJoQ6quXMeNWgH7TqzDMty+tqoLECOC9KiesOWH0g+3pQlq4fzT8Q7V9fFvpwhQLEk+QWh0I0BHXbc5aQItHHDRnN2Y/YNWwSmtXQdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343259; c=relaxed/simple;
	bh=RBs/pTECN0ac63rTo4HqmGiHw5K+O2RiHGc5wsLMjOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW75hBGoa3wpo4alHms87rLdQh4V2YmYGModMbkS5KRFPQXoHmjoq90AZS2LnzI20W2J95hOu7wMexeqR89Km72pWG6Bhhx3S109k2B9cNUWeGwxBkMzLZPCa1KdwDfDI+MVKaostyXMI6AWqbG4ai2698SGxbJJAd45IfPKJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD71060017;
	Fri, 10 May 2024 12:14:00 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 17/20] sdp: Fix use of uninitialised memory
Date: Fri, 10 May 2024 14:10:27 +0200
Message-ID: <20240510121355.3241456-18-hadess@hadess.net>
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

Error: UNINIT (CWE-457): [#def10] [important]
bluez-5.75/lib/sdp.c:2302:2: alloc_fn: Calling "malloc" which returns uninitialized memory.
bluez-5.75/lib/sdp.c:2302:2: assign: Assigning: "seqDTDs" = "malloc(seqlen * 8UL)", which points to uninitialized data.
bluez-5.75/lib/sdp.c:2355:2: uninit_use_in_call: Using uninitialized value "*seqDTDs" when calling "sdp_seq_alloc".
2353|			}
2354|		}
2355|->		seq = sdp_seq_alloc(seqDTDs, seqs, seqlen);
2356|		free(seqDTDs);
2357|		free(seqs);
---
 lib/sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 34b0dbb94eb0..d43bbbd2de05 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2299,7 +2299,7 @@ static sdp_data_t *access_proto_to_dataseq(sdp_record_t *rec, sdp_list_t *proto)
 	sdp_list_t *p;
 
 	seqlen = sdp_list_len(proto);
-	seqDTDs = malloc(seqlen * sizeof(void *));
+	seqDTDs = bt_malloc0(seqlen * sizeof(void *));
 	if (!seqDTDs)
 		return NULL;
 
-- 
2.44.0

