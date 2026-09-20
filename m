Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAB17993
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789936565; cv=pass; b=XC+JB90Z/XrXnuDcM+cj8BqLpqeOrjXMkedz8K7Vac8jBaRSXiMteoKiklNdK3JQ3c+0Np8zm68OVRa0opxp4OEC+zLf0Qq1Idn+E48V3ltrx1Mxx7NpGd5BgxjyIfBKPYN+iinOPftItw8R7QaGfF8RK8NUNDvMc2BUiXhbnMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789936565; c=relaxed/simple;
	bh=fw5Idz3g0a3EVYkLAnuhtgNUvgG0i6OdfsbDO16fBZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KC1QmwDuTvG4Y61YvkMGNJBii/bVJj0pzr7CNEld3vKf/ImkUMep4mVCXGP7jVJhqa0NlHGWAgkLdNDyiCcpQgCau/0agYJtZzZophd3X7TshSX/cs1lfqPziHR5W3HrMFTikRnD5x0uke3Q/ZX9r/sNpCjd7ImjSiLR5o06k18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ie9wbG69; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ie9wbG69"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::d901])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hnymt0n38z10xX;
	Sun, 20 Sep 2026 23:35:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789936558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+vnjfheLWGDeNcSNltz5T613wmTbx/VIIT0zUaEwOg=;
	b=Ie9wbG6945mHfl5B+BKxF4XqdEC2xuhF0QrC5cP3oIK/5De1rdKq14OdPxjMsnSdt9e9Os
	L81vGKIo1sOXCNf6zCB7SHJbdoJok/29f9JbwRNt1skYmFkGaNJP7d1kkZdEX8OM7oCloa
	f25IlD0i4xJDpXWQFUrkNRdiGgZQRBM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789936558;
	b=CrvjhdAWXna0jQ4VgIs6zRedPESVxqlybT/ndbH0pdBkBE7+gO01EvPUZbHXEyjdU07WI7
	taLcRzuLGk2ctq/ru3rdg5A0EEQmJvB3awvQK2A2JG/+Dp9mloSN3nPII2hfeCYlftXvdj
	YzgMuy1kFzXpY+ARHII0FPkCx1NAzMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789936558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+vnjfheLWGDeNcSNltz5T613wmTbx/VIIT0zUaEwOg=;
	b=ZtKAQWpLh2uAslv4e8lCP9beGF0qX8y92ML/WYgSHA029BTqd6EDrqCSkQ5JA3BlCWjyMh
	09j1JHoAWIgL0cnsAwU4ek1g/Y2ur7ynw3lnOk6hOK0svpC6gT8y8q5Z+3+l7uF+b5MDm5
	S9PR3MrHGbXKOpdSKqT4FwLwjaqxMP4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/5] mgmt-tester: mark Pair Device - Power off 1 as fail_tolerant
Date: Sun, 20 Sep 2026 23:35:11 +0300
Message-ID: <d2729a25694f1f94ba4b390d37ee14dc4e05fe58.1789934710.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789934710.git.pav@iki.fi>
References: <cover.1789934710.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pending Pair Device command is completed by whichever path wins
the race against HCIDEVDOWN: if it is still queued when the controller
is closed, __mgmt_power_off() responds with Not Powered; if the
connection failure callbacks run first, pairing_complete_cb() responds
with Disconnected.

Both are valid outcomes, so mark the test fail_tolerant, as done for
Get Conn Info - Power off

Assisted-by: opencode:qwen3.8-flash-next
---
 tools/mgmt-tester.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 542335e6e..a89d38ece 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3246,6 +3246,11 @@ static const struct generic_data pair_device_legacy_nonbondable_1 = {
 	.client_pin_len = sizeof(pair_device_pin),
 };
 
+/* Whether the pending Pair Device command gets answered by
+ * __mgmt_power_off() with Not Powered or by the connection failure
+ * callbacks with Disconnected when the controller is forced down
+ * with HCIDEVDOWN depends on timing.
+ */
 static const struct generic_data pair_device_power_off_test_1 = {
 	.setup_settings = settings_powered_bondable,
 	.send_opcode = MGMT_OP_PAIR_DEVICE,
@@ -3253,6 +3258,7 @@ static const struct generic_data pair_device_power_off_test_1 = {
 	.force_power_off = true,
 	.expect_status = MGMT_STATUS_DISCONNECTED,
 	.expect_func = pair_device_expect_param_func,
+	.fail_tolerant = true,
 };
 
 static const void *client_bdaddr_param_func(uint8_t *len)
-- 
2.55.0

