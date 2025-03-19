Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF3255229
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386288; cv=none; b=BdeenNoUqTuiJXA7SFMHDRYv/0HFyjRT7cld6HIMZBBs0cC/1L0biNWXo4xnILhEpXZC5eDNWT9y9MeLCjye4MGpBGd6IK3gREALPCXqBIaR4aMZR0+cn+pV9QVs1LnXRMKX+67qre79P/RUuD5dFj8u2ZVWbLQq5lZvkZMTRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386288; c=relaxed/simple;
	bh=5bjk9A9Alulo+RbmdC0IIptFgI+CFHwuDMfhqt2HNmE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=syR/SFzmOO5vmziKGJ6M1S3f0A7tlXR01L28Eoqo8nRdn3BhIKmWnfw7AX0QbfpdkAbr3kP1Pmqrqv4V7hK8LoUf51r3tNYgSZG1Rh5z/fdwOfBsVZ/gqx5xhuX7SLyLRx2jPKonjhApf6fZwgCsvj8AmFwJlUPZDLjeqyL5KTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a3o26GYq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a3o26GYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742386278;
	bh=5bjk9A9Alulo+RbmdC0IIptFgI+CFHwuDMfhqt2HNmE=;
	h=From:To:Subject:Date:From;
	b=a3o26GYqS8ml7+Rzh3j8tk0UPiFx3yGB5MtjjFdByZkFE6KINQZVXtbZKprNpXtnh
	 UrRkT3LJF84A2R6bj668TeH9bB05pU9yDmaxttQIHjXstPyLhFRaQSpUf+pJ2RBKtU
	 Q8UgNgyy+TITM0G82FpaEX490amKCJjsPb16t2TUv99YpXqGFzPb9jCID1nbUMwbsb
	 4WMGRNxnU/l9IGsvxDy18fh+Hk6Splv1ay6Jl4LG0VqmSY+vihre7K5AWm5ugl9gAK
	 I80CCWM4VWag8EzBLRuwh5LLMePjjIvaOmQeA04TGA5zbNwKJRa7CASKHNnrqs1D1v
	 XQrmYbeP7e5tg==
Received: from fdanis-XPS-13-9370.. (2a02-8428-Af44-1001-9F24-9328-eC9D-4c39.rev.sfr.net [IPv6:2a02:8428:af44:1001:9f24:9328:ec9d:4c39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4D67417E0657
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 13:11:18 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] profiles/avrcp: Fix AVRCP PDU parameters length don't match
Date: Wed, 19 Mar 2025 13:11:12 +0100
Message-ID: <20250319121112.166754-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is required for passing PTS test case AVRCP/TG/VLH/BI-01-C
(To verify the behavior of the TG receiving an invalid SetAbsoluteVolume
command).
---
 profiles/audio/avrcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 7e9a383b0..65f1adbdd 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1963,7 +1963,8 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 
 	if (be16_to_cpu(pdu->params_len) != operand_count) {
 		DBG("AVRCP PDU parameters length don't match");
-		pdu->params_len = cpu_to_be16(operand_count);
+		pdu->params[0] = AVRCP_STATUS_PARAM_NOT_FOUND;
+		goto err_metadata;
 	}
 
 	for (handler = session->control_handlers; handler->pdu_id; handler++) {
-- 
2.43.0

