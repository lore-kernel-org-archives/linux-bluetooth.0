Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020AC14F9CA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910152; cv=none; b=VMRdDHEdBHV8YUKCiha2WzrwB31LcGIY+R0PVYns7yfWWrJ+tWMYv0H41GCH33Adev8VvOWxY2gJM4B3xE4XYlE++EntyG1v9UXPizUbeGzm/8B3+4CX2CZnXPCPCIVUMZOnlEAHzjYstBMl9VkX68mk+KlhKgUwLBXrFGNEUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910152; c=relaxed/simple;
	bh=AMs8ychV2P29ai3YR75bpglgCf2JFXuMVDB5Yw5686M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk6DEJjAxRB6rA2r0qoSxyf1Mfzf5oW/5YfO475HkkOYc2letAMlc3RviRK6yxmfxK++uFlYJBbDQPdO6oKK5msAx+3dAwCdW+Gve1DuiptseW4dW3YLScAOD0+AdCyIHjyELfx97YS2Pze4n7ljdUchghk9KTopMg/K1gsrBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83C8BE0010;
	Tue,  2 Jul 2024 08:49:03 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 9/9] sdp: Check memory allocation in sdp_copy_seq()
Date: Tue,  2 Jul 2024 10:47:24 +0200
Message-ID: <20240702084900.773620-10-hadess@hadess.net>
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

Fix a potential null-dereference if sdp_data_alloc_with_length() fails,
as is done in other similar functions.
---
 lib/sdp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index b87951b007a3..b64245f668d3 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1538,6 +1538,11 @@ static sdp_data_t *sdp_copy_seq(sdp_data_t *data)
 		value = sdp_data_value(tmp, &len);
 		datatmp = sdp_data_alloc_with_length(tmp->dtd, value, len);
 
+		if (!datatmp) {
+			sdp_data_free(seq);
+			return NULL;
+		}
+
 		if (cur)
 			cur->next = datatmp;
 		else
-- 
2.45.2

