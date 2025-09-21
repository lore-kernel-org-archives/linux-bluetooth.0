Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F171F4289
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482095; cv=pass; b=iULr0omVgWO+vTLBl5CUR5sVYigeiGmdCsndAxkRQkiVq8BiZefxHi1ZMkU4l7u08eMSPUYTlLNxUAS67Cw1NGk/8syDtFZ4lGHpK6pB6ycd97tTnUxsBUeojUnuo4cN42VnaDwztGM1WNTKjn/tkv+K2rR0kDhTk+wMnZxo7NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482095; c=relaxed/simple;
	bh=jpuw9iX+EZA6yUHJBZ7CjZaRSuZSqm+frEdEJA5XKVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/83n0TvV+b+oAgWG+WCb0sRY4BRGZgBVuXSNyb18w+FY7jtvXSKCdQemnbFtsR4ddFDcSCPBmp9TYh7u45K/Mxll1KZtCGTaG8T0bcL+Al7txF4p5KUKC4K69vni3MnHkO/WaDT/pMxU3k+sOTBIztfa7+xafFndAExXQL/Nw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JoVFs1i/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JoVFs1i/"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCB0cSyz106X;
	Sun, 21 Sep 2025 22:14:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnyqrQQVB17l3OF2vl7cQZzHv6Zj/EhQElE0vYlv0AQ=;
	b=JoVFs1i/Fkw8p0QNarOV1Ryisf9a3zbphEe9HTJna74GbolT9xUV+pVz3HQg0kPZpESyuJ
	5b3Cu5MJBQlTbrMF6p7OCf8FbJ/Jk9SK9nGZYd349SmbDhn029Azm4YnsIzdryndBteHli
	Sy5xpWw+EgCpGQI/bg8fBGValfwXWtQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnyqrQQVB17l3OF2vl7cQZzHv6Zj/EhQElE0vYlv0AQ=;
	b=AVeFfBh/Z/u7CZ/xrxulmEXYxvzQTK5Dt3WqtW72F9spP4ZiDa8JMefi+U5ccTiiY9RB8j
	zLnf1HkGu+A6eNQSsaSf6JZmvUDf0Af1eM2yENk42GptLxMdeMajLasN7wtYY+T6TrvDdm
	mBDQpRCySXqsTFljpYsCD1gffQJTgnk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482086; a=rsa-sha256; cv=none;
	b=FEpYKm2ah/aHA6MMYwLsIObWqh8ADNXXbHrGSAAwD4P+ui8qNO+9Kb/WepD4ReoLJFvUW2
	MMIuBOYplKZmg+0CnQsXt/vXxBQPt+pI0t1X7b9VX5hfc9bhdYHk9mj32/8QyhvpyxDv8O
	UGncl2Vuz600N/IeP0KZvhks6bnfMTM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 01/24] Bluetooth: ISO: free rx_skb if not consumed
Date: Sun, 21 Sep 2025 22:14:16 +0300
Message-ID: <0c01df0dbdda659b4b75e5422f6f54bb8cf7f169.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If iso_conn is freed when RX is incomplete, free any leftover skb piece.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5c68c0ea7d97..d63d4d6f874c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -111,6 +111,8 @@ static void iso_conn_free(struct kref *ref)
 	/* Ensure no more work items will run since hci_conn has been dropped */
 	disable_delayed_work_sync(&conn->timeout_work);
 
+	kfree_skb(conn->rx_skb);
+
 	kfree(conn);
 }
 
-- 
2.51.0

