Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41D2C2349
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383214; cv=pass; b=bCUMNfb1TTHTK+VactGJPicuszF8iTbo4CnOKh+hkovMBVZG0GWZK4CHiCGJu9mU5DMSzvV2Ya8Thbum4tL3h4LpLO2LFXV1cgYszRaNCoTmKoY1EuHxIsCW37x/rCA2KI7WEKLdZDcQlBbZCLgsCuqQvaaLjAZsrOpxMqkwIz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383214; c=relaxed/simple;
	bh=aeog+6PLXNmGbhLNu7i7EGWyHvCrjz0EodWyA0y1TUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE2BxX1NpAnwwN6xu25kIVaDLNd4QC3VM1DzbTiVtuGpGcDpcxi5/67zFKiE6aorLIboWsz16SoUxBVw5Lkec7dOlMUZJnrqF8+1o0kaJuf7q+MBU8tD8mcSELw5/m2Zr90agQaMtHf/r8UNrXBbMQCWR72JPd4RfdBI874YDJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nLZrgqL/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nLZrgqL/"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dRLP22KTvz108n;
	Wed, 10 Dec 2025 18:13:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765383206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LnqALAKocDHdaUaCb8sMgnvU6pb7SZqtIOeHda+FgY=;
	b=nLZrgqL/zjrXPOi8g3m56jPptXfqJBOa0afrzdBh7aQeocjv3F3kcVp0TOSCpZiJJsCT52
	m6N+8dm1iSBWg11bNtNcuMpxfbBP3qp0ccV7VX6nWq2uFnKcRzHeLKWn4sHiaIV7a48JX1
	i/l9EMiUI9bnI6K5Q5xD0Dm+bv4FNBY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765383206;
	b=NlZalZkunobCTU3+SMj+DQAxQ8/iaUmldvcAhGkjdbr4Rnt7iFK3rgS7Sa6CY1k/2/fIEV
	2zygZeZBi8SXFi9zxu1wl6CIGZvbshnt1+hLZl99MejhI+uqEi4eJhC7HLiFJ/KbL/5Kjg
	7NiY/v347d1Thxeuke1xA/CWcHbUQfY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765383206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LnqALAKocDHdaUaCb8sMgnvU6pb7SZqtIOeHda+FgY=;
	b=bJi6SzPhycLWpFweeiaUnN7xJR+/Xg8t0tGTj9CWRlxSrFzlfreKhuj/dyHq8TrkqMyvSx
	xS1KON9enGTLWdWqnIj9ML/L8WMNCWYdEgdeTjdcOT4hfMAkS0+HZj11Z095/BCLYkEcBw
	gw/DsfTtk/kztVvPVx3c8ZRJ6MCpCJ0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 7/7] shared/gatt-client: fix notify_data leak in notify_data_write_ccc
Date: Wed, 10 Dec 2025 18:13:15 +0200
Message-ID: <f36b58ec12cc360d8da537a07a54d3a39797d4d4.1765383173.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765383173.git.pav@iki.fi>
References: <cover.1765383173.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling bt_gatt_client_unregister_notify() when ATT has disconnected
leaks the reference to notify_data: in notify_data_write_ccc() the
bt_gatt_client_write_value() fails, the destroy is never called, and
notify_data_ref() is leaked.

Fix by balancing unref notify_data on write failure.

Log (unit/test-mcp):
Direct leak of 5760 byte(s) in 90 object(s) allocated from:
    #0 0x7fd7e2ce6f2b in malloc
    #1 0x0000004227e5 in util_malloc src/shared/util.c:46
    #2 0x00000044a81c in register_notify src/shared/gatt-client.c:1782
    #3 0x000000458367 in bt_gatt_client_register_notify src/shared/gatt-client.c:3685
    #4 0x00000049f9f5 in foreach_mcs_char src/shared/mcp.c:1834
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f6d5dc4b7..f8ebab3fa 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1691,6 +1691,9 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 						callback,
 						notify_data_ref(notify_data),
 						notify_data_unref);
+	if (!att_id)
+		notify_data_unref(notify_data);
+
 	notify_data->chrc->ccc_write_id = notify_data->att_id = att_id;
 
 	return !!att_id;
-- 
2.51.1

