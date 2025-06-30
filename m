Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0761E25E8
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270574; cv=none; b=LEyLTpWXWdu5WnrKZBUL3wwUhkrfaRfSmjOHc4Z0M/eV4lov3Olr13jvpAqN6RUrKQAxYwiVTpe9SsYDIQs80IsuCTzuPa3ifLOFjbs5hYtLiwnDzjJ8pKlCy/YQz8BI/+lI1yfwxnmgw5AgufFWoP/9kaRPKamcGYgEXn1sC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270574; c=relaxed/simple;
	bh=w2txqyRAz5KR3vgsQ1KRfKg8HVIvY/59iF7EsnKQAzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FWhdkLYNAsKk9F99neGz9iwB2hwQMHdC3mXuD4FluQ4Tu8CdtSgOOXhbA6tQ7hbccwY8wZodvM9Ax4eIe0XwiPqydVnuW1PBtngLQXjB8UGtyjhpW2sbT3CUbziHFWIptaOho/z0ZxtdMURoz2ADbmajpO16menY9L+0IJeald4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi/kHanB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi/kHanB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE10BC4CEEB;
	Mon, 30 Jun 2025 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751270573;
	bh=w2txqyRAz5KR3vgsQ1KRfKg8HVIvY/59iF7EsnKQAzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Xi/kHanB8hMtst8R740dYNIQXdyW5uVrGK1Iz2TJciCMkiAi5X7slIarLyu/ZFOpf
	 Pswacs54xWvRfM4/YcKzqhNZPJpQUBWms4N1edaKuYSqEBkRDF0JGGtqlxDqbVCvT2
	 QzZpMI334qrlWrlx4WOWYIZv/cNv0+eZv1/K7WpL2f+BNncGKABHWgsxpiKVz+DnA0
	 EuDilAgHmSVAERhzSgHmbpmztWc9WommKIg2ewmD89h0YSgNoxkzt4cjpnO8iGJfee
	 yw6aayyLjKXVIlPYYVSaLabYgABhnMcOPOYApDc4sJTrFmuAOK539C6IxPnPQbA8rs
	 Nzj+DvSXuJAbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC9C8302D;
	Mon, 30 Jun 2025 08:02:53 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Mon, 30 Jun 2025 16:02:40 +0800
Subject: [PATCH BlueZ bluez v2 2/2] shared/bap: Add stream state check in
 stream_disable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-bap_for_big_sync_lost-v2-2-1491b608cda5@amlogic.com>
References: <20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com>
In-Reply-To: <20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751270571; l=1241;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=UsgM1iZe4i9C7+GtPzdOMqpUoV1Gz3JjDhaDIde++68=;
 b=jUwskwxo1rLOAtX497vQB88w0zi40z26kj93Bo6nB3ogM6tIQQ8eecS27jPf61iFS8Gr4TKal
 rsUr1rRUMsFCLkKDs+bLc8C5+NpWVqV2klzA6J3oNfol13JaNMD/ea/
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add a state check so that stream_disable() is a no-op when the stream
is not in ENABLING or STREAMING state. This prevents unexpected state
transitions or redundant operations during cleanup.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 src/shared/bap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 984ae782d..5445ddd14 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2134,10 +2134,14 @@ static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
 	/* Sink can autonomously transit to QOS while source needs to go to
 	 * Disabling until BT_ASCS_STOP is received.
 	 */
-	if (stream->ep->dir == BT_BAP_SINK)
+	if (stream->ep->dir == BT_BAP_SINK &&
+	   (stream->ep->state == BT_ASCS_ASE_STATE_ENABLING ||
+	    stream->ep->state == BT_ASCS_ASE_STATE_STREAMING))
 		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
 
-	if (stream->ep->dir == BT_BAP_SOURCE)
+	if (stream->ep->dir == BT_BAP_SOURCE &&
+	   (stream->ep->state == BT_ASCS_ASE_STATE_ENABLING ||
+	    stream->ep->state == BT_ASCS_ASE_STATE_STREAMING))
 		stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
 
 	return 0;

-- 
2.42.0


