Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FD217F3F
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937638; cv=pass; b=T89W69kXKtTsfM29TmfqOR3NIgN9nI/kX8ePm4Kr8Porxd6CHwv90EjXoHbhRhJudyEtL9pE5ZLhRY7E2LLoUg2iEovuR6G7ikJbERgd4w5DLrLyqAz2hFIlwPt9pO6iMl+MV4eZgTDjzWnSXT8eQGXgSZm+FVCKotXTtr6vMAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937638; c=relaxed/simple;
	bh=dM+rci0j5uyvmDcdVxUWmLY0OzgYOAisgBYUx9/5jH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csmCyyrqvHivYr6Y/pTyQlRDUQqbZ45IQNV3QfwHulRSe3JtyMVxEnUGzcXa2++JUGyuLycmPxtJazX7xPh20tNhsNP+1B3HTbHvDCjDbCxuh9q00UopXBpG3FvJc3xfHhV8Z0+DQdzjB22BfOOMTt8Uif3/CNNDAVzSa9gcUeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=KznpLjn3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="KznpLjn3"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4XbFqD6yWwz49Q0G;
	Sat, 26 Oct 2024 13:13:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1729937625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mJ9urVXaIOp+bFVO7VVgQy/ihb/ArmoNmQYBRI6dgZY=;
	b=KznpLjn3eZNd8Ce0Kyy+q1a59WwoyqaTYFpT5kjZClPWed/DBiQZFz1TxoSR1zNM8wAXmF
	8/xEyrMgksONFcb6qRDftHOcqxO1k5EXjINqAcIaQFGjlGOxsgxDmvcU8GRTf2uyWUzKbF
	f9AwlpjfClL5TJ7pDTo4mS7L6lieeRDpLgWrTKTfwFVnn/EleSTOtptrpoW9M/F5RaKSI4
	RsM9lxPqlGQdfIAClxSwvGY56kHGGV0W/qAvYtedoFFxnKddtZApevGSfy4fGGexb3lSTt
	OqnOBiRBodjRrdwbBW8QKuwWt5hopTMIjCtsEKAshMVdw5kh3Z8PcESdq2XLRQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1729937625; a=rsa-sha256;
	cv=none;
	b=l5RvtAcR5vnk7AX3rQTOMvQOAKZNT5k309YG2//t885owEaNfjjNV3oxRXXtLpLh9afvRL
	lKhPCB0XYn3vux2wDlafpNW+SYMGBDic69GuWy4xHFzNTY5ldArkujv82pTNK/ZAuM4Mzl
	lTUFC5jFN7C0prqMIdiNUgqsBI9C78v57hRlhxXsWJedV7EF7ajjuKnDB1QRMI2+jy5X0b
	77WaPujgj0Lwd0e/tYDaev6zPHewOC2R3tqU+uzeZwI9gfPw3iz1NR+Hp2M+yNaPNqOhCS
	zatRoV0DAMHMIERaEM+i0mlCRz89wS4oFUgyEQ8ljmBG90C8/ThDGSSdNkbUXA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1729937625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mJ9urVXaIOp+bFVO7VVgQy/ihb/ArmoNmQYBRI6dgZY=;
	b=eVEcg8L4VXohpYjbgIugWeIaOCo2KC/F6PYLIBFyXf+2RHCIKZygeFTtbUMt+3buUK9eJk
	DWT+ZsW9uiQM7qpVGoeM6FtQ2Cq01TzWfl9bEnCX21EA9VjCbQ3P1TdvIypr+Zcy7oMotY
	2PPekBe2WIY3B3qU6ldrHOouEWawuR1CxalNqJj8TPVE92r7mcohkbRU34/0AZr0Z2TSm3
	Jfp2jlB9lGVv4g/51+wyRcLUZSUoGi1lR34oWt/hZNUxV7o2RMKKDPPMzXTkenH6cX/9h6
	xIwlFVFTlfUdO7BUBom/i4EktX5ULFbdhbvgfL8Ygf5nB+GSp/zXwoVLPd1GKQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: ucast streams can only have one link
Date: Sat, 26 Oct 2024 13:13:39 +0300
Message-ID: <b0eeb28d794adca98f4a246cb368e68022e06e0e.1729937570.git.pav@iki.fi>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In unicast, linked streams mean bidirectional CIS.  Ucast stream can
have at most one linked stream.

Fix ucast streams to have only single link. This fixes eg. configuring
for AC 11(i).
---
 src/shared/bap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index dad510aec..658ee1370 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2422,8 +2422,7 @@ static int bap_ucast_io_link(struct bt_bap_stream *stream,
 
 	bap = stream->bap;
 
-	if (queue_find(stream->links, NULL, link) ||
-		queue_find(link->links, NULL, stream))
+	if (!queue_isempty(stream->links) || !queue_isempty(link->links))
 		return -EALREADY;
 
 	if (stream->client != link->client ||
-- 
2.47.0

