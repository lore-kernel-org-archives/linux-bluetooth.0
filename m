Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9A2749E6
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187516; cv=none; b=mucOfHwHAXTX2wEpf6oeA0v7ZWVHKyIaGwQmrt61MELuE55DmhdmeByZ6jk80mlkgjk9Vttqb7E9L/xtQCCUv02Y3OWL0new35BR+V+lvLCUG26Oql98Wrq8iv4hnfr1Bc0k9tCV/epqFlgG0/Pbi5zlkUVxaMxIQMsEiA0gCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187516; c=relaxed/simple;
	bh=hF82pxPtbBBfmou6OsViUgNYhsR2iFcrfoOW1PNaRN8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i3vH/bD9mMKwb9NpK/jSaf/+zAk4wHWAWp9tQUntuPY/eAZa8Ktj/PxCnRlcsavflyrdA13/TMkpa3J+zu6zR4OLTiHIyBlUzMVHBJ5DfjQF6VIAgDH0lqujH3bsJbuPg7smJKa+8j5lDXgrMIAeSRLKsaAfTkJMa586nOZ9ziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qT9dPXL+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qT9dPXL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788187512;
	bh=hF82pxPtbBBfmou6OsViUgNYhsR2iFcrfoOW1PNaRN8=;
	h=From:To:Subject:Date:From;
	b=qT9dPXL+d53C5BhaRuGlYTmfZmYocWuzVd5KnyFAH1f4LOcFlDMEo838zHEF5BSto
	 uuVEjyaee1k1zQrFG6WNqWwED0Vw4HJX4rg+Hcgd8jMoW8x09s/7eiI7QplcVIuyef
	 awZLNYI21S/NlKMB3sPhzgpDEJdLb90M4Polb75KLKcid4egoHzjHUqz3uPx9KqHLV
	 R4rInhmxBVAZ3cA5mZhhoqWunvA2XWz1s5cY7/0U0xm3lZ8IZT5bRqsoLIhCXuCWpB
	 Aa0dTpOHdrPkzSVyDON13IT75n9AuZVnUj7FT2KzO3Cs4/juWJe3uPj9CInAf85Xmx
	 v6XBhSJ6VJx4g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 90F6517E0069
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 16:45:12 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/bap: Fix use-after-free in bt_bap_detach
Date: Mon, 31 Aug 2026 16:44:37 +0200
Message-ID: <20260831144437.127711-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

bt_bap_detach() invoked the pending request's completion callback via
bap_req_detach(bap->req) before clearing bap->req. Since the completion
callback (req->func) can trigger synchronous cleanup that re-enters
bt_bap_stream_cancel() for the same stream, and bt_bap_stream_cancel()
frees bap->req whenever it still matches the request being canceled,
the request could be freed while bap_req_complete() was still executing
on it, causing bap_req_complete() to dereference the now-freed request
once the callback returned.

Clear bap->req before invoking the completion callback, matching the
pattern already used by bap_abort_stream_req(), the ASE IDLE state
handler and bap_cp_notify(), so a reentrant cancel no longer finds a
stale bap->req to free.

Assisted-by: Claude:claude-sonnet-5
---
 src/shared/bap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index da3e265e2..891a2f4fd 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5958,8 +5958,10 @@ void bt_bap_detach(struct bt_bap *bap)
 
 	/* Cancel ongoing request */
 	if (bap->req) {
-		bap_req_detach(bap->req);
+		struct bt_bap_req *req = bap->req;
+
 		bap->req = NULL;
+		bap_req_detach(req);
 	}
 
 	bt_gatt_client_idle_unregister(bap->client, bap->idle_id);
-- 
2.43.0

