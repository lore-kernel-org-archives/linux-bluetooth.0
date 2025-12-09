Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28258313272
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314949; cv=pass; b=u5GwQWCJmW3qpndcAvXrRuhn0C8gdWGq6sqC633b9qf2g7ShBxOYmlTuLhrclZn8suMW3TyXsVa7hWs0PCOOjcxCvW2tgkosviaipFO8H3DzIYgq+NHAymLQBRF8x3rW3XZbBeRU/F0lPIkcaZ3edcNCF7eaxDxW9XxNFr5cQG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314949; c=relaxed/simple;
	bh=aeog+6PLXNmGbhLNu7i7EGWyHvCrjz0EodWyA0y1TUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyWeVmDJu0UN2bVKTfmHd8QvYtKW73lFg1WwHKr2aKUFiLK+q56T2EYf94as2BcH5J6LIXDvei+gqTy8FHttbl/Ve+M3pw+eWJMKncl3+DVPLvPIUe5RoAyp9eVbEh0c2n1bJkLy2NXLjchD9HwpP2HfneNY0hSoqzH89aIrAVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GA9kmueL; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GA9kmueL"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dQs8J1DQwzyTs;
	Tue,  9 Dec 2025 23:15:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765314944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LnqALAKocDHdaUaCb8sMgnvU6pb7SZqtIOeHda+FgY=;
	b=GA9kmueL9j0M4SPE0J2AU5wWtx58fPMh7/1CZLyRkjm2C7cvwkCu1TW3SmvofxDgqJwqQz
	CMsDsHI4XoQtyh3B9CpvUeqxM+yWDBHy6P5CH3jyL5tN+Gpsb9nr3AaHvRfHuYO2uzNNDJ
	X/JPpxQxKWf2bnAsbFC8q1CKwd6cg5M=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765314944;
	b=G04IppXSrnQPfF39KWXYM2AUoq8hO6x9We+f6BWqI5Pg17qGl93zqaRHkYb8LGyae+Exqn
	93AGPkFpdIV51t4fVrDp5AM7bZ5lGTx2De2FCKksCZfU20FmsANMa+Zfnm5DmJjqk6XX7p
	H6LGhhbYiqrU0kdcHbskN1R+kbppido=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765314944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LnqALAKocDHdaUaCb8sMgnvU6pb7SZqtIOeHda+FgY=;
	b=B/VVkkKvvp3h3N/1sE0lhA63+MabjUNtSgaOxqbR9xsrzI5pjkge6eLs/379ISfKDXX5cj
	J//JRZ0r7Z9sU3LTvc1kuScT+cy+srSIOd7qyOa5n+Dei7yVWT3fRk5gwtIwC8KpQUjPjE
	PptyoBgqvrA2KwF7DxJVLyIlsoOQFM8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 6/6] shared/gatt-client: fix notify_data leak in notify_data_write_ccc
Date: Tue,  9 Dec 2025 23:15:23 +0200
Message-ID: <4e23d70301077f50d37e71502c4a27f9ae8f31fd.1765314903.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765314903.git.pav@iki.fi>
References: <cover.1765314903.git.pav@iki.fi>
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

