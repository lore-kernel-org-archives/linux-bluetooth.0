Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5D3B3C1B;
	Sun, 30 Aug 2026 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788091463; cv=pass; b=bu8dKP1aDJzoC5nwil4BXV4c9XU1mhn2ruYt2+Q+1yt2lNF+G9dj1SqE1+D/100NnsK+GXju1JqiPRtbWi4l4PVLTnPph8iE93FMjy7Zf54fnBoqYi/Rv9GSGtxalb+oBgyPn+V5+lpJuP4VX0y+f+Dsb+pkGxlR9fBaJQAa1yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788091463; c=relaxed/simple;
	bh=lLhZbbtiV8hEAQiF+bEbJUf2OM2pK3goNBCr2gqPLMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsdTfqYV8wBCC6stZFgKH4zLK678c9tFuelZZGL0zFAaKhhqK1nHwFKNbPB7OzvMw9Y2zz8B08421lCUTOsWdqlGcmLezu1lJrpmm1iu9GiIRmFWmVZ9QDpk9E0Tp4Rom+0g56hk+2x8fOYj7dQEi19M1wFBUMVbvHuGTzgSCmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=UAdQ85PC; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="UAdQ85PC"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXrQ71XdSzyhS;
	Sun, 30 Aug 2026 15:04:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788091455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoYiIAZuq1kr37Fh6E9rSxq6Tb5PuIoxwS+uHDUUfVk=;
	b=UAdQ85PC5tBaUpNpKh7NqV8AVgI6/g4hBa5CiCgaZGIApH45ipzxbBjzxhXHCcX9TyJM3m
	NwuZDOaWIiz9fWDGPF8gtl5KO7UhtI3BuNVN2x60yg4ULudPG5t/9rp68IPvk1KD4oJgqX
	HYxJ57f5mcf95D9vEE7grz82Zcefiuk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788091455;
	b=k4bm+aLQ4mCQTTyceWnCLUSWYS5BLuUMwOYUMJTJIyavihYx+umlX+x7C+h6eAo1w1CXVe
	jWp0mIpOsRG3BFXn6uJ5y3n0Z6LcDOKKwA67IlBb+x3mabtT/7X2eSsD/FxC3sgZLVMPRd
	ahvFbxSYcpLW/PGggDhssZMA/N/jfGA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788091455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoYiIAZuq1kr37Fh6E9rSxq6Tb5PuIoxwS+uHDUUfVk=;
	b=SGbZLuFiwq4g0ZqGsyrFygjiM933k0lsYUVyvTkaDgLaVswzdYSFAv6CNWoldN6od9l9nQ
	XHX4+bGFKDVeyPBIR6mR+L/tRhFlfkotQOq3RmVxBq2l7IH810W/ktyQ9TClwJB3pwwDMC
	AxAvXP+KH5iFZg2pIwzihJAk1dzUM/Q=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM
Date: Sun, 30 Aug 2026 15:04:02 +0300
Message-ID: <a430306b2f97e3fa9639c9e28ece272d5f824475.1788091154.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2b863abeea0ada6e990b07a7f3182e261ecd8e09.1788091154.git.pav@iki.fi>
References: <2b863abeea0ada6e990b07a7f3182e261ecd8e09.1788091154.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_ecred_defer_connect() clears FLAG_DEFER_SETUP also for channels
with different PID/PSM, which will not be added to the same
ECRED_CONN_REQ in any case. Consequently, only one ECRED connection
group can work at a time although it appears intended they would be
separate for each PID/PSM combination.

Fix by clearing FLAG_DEFER_SETUP only for the connections that could be
added in the request. Retain test_bit(FLAG_DEFER_SETUP) before calling
get_peer_pid as it may be NULL otherwise.

Fixes: da49b602f7f7 ("Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Another sashiko.dev pre-existing issue
    
    v2:
    - new commit in series

 net/bluetooth/l2cap_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1b612b9beaa8..e3d955d7d4fa 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1344,7 +1344,7 @@ static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
 	if (chan == conn->chan)
 		return;
 
-	if (!test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
+	if (!test_bit(FLAG_DEFER_SETUP, &chan->flags))
 		return;
 
 	pid = chan->ops->get_peer_pid(chan);
@@ -1354,6 +1354,9 @@ static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL || chan->state != BT_CONNECT)
 		return;
 
+	if (!test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
+		return;
+
 	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
 		return;
 
-- 
2.55.0

