Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C81A8412
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374540; cv=pass; b=mnoY0aJ3JI+qGsykHZAyV/VkGCYbS+XREaJGcomFYcZg/RwY/MI7FpOmRK4h0svErKkyf5KdARUH11dgGSEfUqlym/GBt4wUmBPAvpJ18gCbd0VRgePFMVfVuYOLIWHFu4hzldHqt6Rlnqh/vEsXyPiIXrjPDShOGPMKyDEmS8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374540; c=relaxed/simple;
	bh=hcp94CFS3/8Y26XHqPdYir6yRbyHVLuaUd0ntDZZuHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9oKu6lL9R72D2ghi51BktcIQar2hTPamoKJZJsbLySx20c9tQldWiyfDk9iQVPWdstSVOataVPzfsBMCgn/Zd56qplsvEfKc2WDUAz+0tkOvY5Msz91KO0YNlAlsjuPvuPr5gpKyw6NbZqgMHuvqpuor455uZ7KKUQ5GC1rZpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=pURK+tuJ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="pURK+tuJ"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8YZ4GhZzyhM;
	Sun,  4 May 2025 19:02:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C19BSes2JmticcW4n62vIpebJ0mXQTimRvohvx3fSkY=;
	b=pURK+tuJq3UrKsZ5VpgPLbVn7GZvyAKlo9wOLd1YCs9YgMCLvXqHnIIcZbaK/sQ6EZB3Ep
	ogZciKGH1DJLv1wHFWtsg9alqY1kGOikwJMLgWicg1Yvwr8069WJUSIqIkU33AFA/EC7LR
	Y2EZJpL/yJMIiFxlSriQQPLg54FO6lk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C19BSes2JmticcW4n62vIpebJ0mXQTimRvohvx3fSkY=;
	b=Q98m2IAp5Y76OxycX3iZgFMczrKwSlMljvQAZr80DFSz50nDKVl316WVWu+mZJmxcAFh4W
	7NZyLA71UeZqFG9bJIqwu8O2xex2NrMuxja4mz1sZcGTLIndhQHDMVnneBC3BJC2F5Xucj
	28w7HQZSvMV0Nl7veWfCFmGCWLRB9Ok=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374530; a=rsa-sha256; cv=none;
	b=IaTfLoC71E4aj8yoNtyq7u0CCTzl+Gu02ZOeokQnDYE4P4aeuu973x4OWHQ8WAR4nFFc3E
	qWvHfRlXJ+EJVzAKacXxc4QbF7oqWShoD+ktyWRUJF3CCErukmziuu6E0DEAbHdl4W8DAo
	rxM8I2Wmfs5Cj6AAdcOrwg2Roa5GYpk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 03/11] shared/bap: bap_abort_stream_req() should cancel also current req
Date: Sun,  4 May 2025 19:01:55 +0300
Message-ID: <4c8142e02e4b63d181e05baf7f0e849ec9a19b90.1746374514.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After bap_abort_stream_req() no req callbacks for stream shall be
called, so it has to fail also the currently in-flight request.
---
 src/shared/bap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 2a08f3eea..976e3c0b1 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1298,6 +1298,13 @@ static void bap_abort_stream_req(struct bt_bap *bap,
 						struct bt_bap_stream *stream)
 {
 	queue_remove_all(bap->reqs, match_req_stream, stream, bap_req_abort);
+
+	if (bap->req && bap->req->stream == stream) {
+		struct bt_bap_req *req = bap->req;
+
+		bap->req = NULL;
+		bap_req_complete(req, NULL);
+	}
 }
 
 static void bt_bap_stream_unref(void *data)
-- 
2.49.0

