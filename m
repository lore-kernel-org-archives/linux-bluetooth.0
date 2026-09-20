Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6617993
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789936561; cv=pass; b=OE2X+zRMZVkEKDH7alMYeJ2xXYQ4tZ/mzu88YeY3QBgO6QbGanuwg7trB0stgmH7OddVBGZBxp2JCKqLqOf9uuLq3MWQrFV3v/lgXO5dX38bBnnAxMMTdM2CajdY3s3aZsGSknLWHZKlb951CbSX6/GhxaiBuVjf7EKoumWeQbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789936561; c=relaxed/simple;
	bh=o7VeHlPXpKEjnfTRUYW9D0k2mZDIpjwrA6IHuY9uPo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy5zcvGat97qI51JNzH3SAuAhsVyp56pcuIWsfYmZTAANkyeV7DWJqFZXOqYlm8DJ0mZvbEkCotjHbKu+E2EMqK+ybXtCrph/U7yMEEW4TTS/JNytuvPQsyg+r8R9tSTLpkk2bmxaJ56EXwRWaz5yG1+fGi1v39ZY7f7ar6nUIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rt7uGM+a; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rt7uGM+a"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::d901])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hnymn2DFMzyYL;
	Sun, 20 Sep 2026 23:35:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789936553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fbIDJ3cmKJFGXgQLKvo/6vepNo4KW3S+e3jM1O1DiE=;
	b=rt7uGM+akVljh+8pjbGVqFwnpAh+W04iU7mhI3MEgivfBEgoX2HSfKmf4KUiAhAuDAXRBQ
	G7eAIXvOkVPA4/ZH+/P183VjqQ+L4aHkhX6obxCAB9eL3LuxmI/JFHC1Sjm7VSU/5GTH2k
	xuRgnGcUaCOIQuuKJn69u5U79Limf14=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789936553;
	b=g588ICAKrt5RcqJDXNrwAPpIGsJoVwOBHfV4neiZuob1LNMhTXlSKz8oAt8qL/Xfzi7QwP
	nh5X8Z63be9DVvy4PAA0VAqdr+2m2AT+cQhCsgl0WfG8ajNdZRckFoHFBrEycwG3zrlGfP
	ok0fLTGWm5KcBRoKGdkSMb3L7BG8740=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789936553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fbIDJ3cmKJFGXgQLKvo/6vepNo4KW3S+e3jM1O1DiE=;
	b=VCMcw7SE6WOulg7hYm3z8FT1YZtuevQSbNAr4NO2HBPfUZFo6O5+U9jk3j7a8JHeWG40WQ
	saLrBrETNhghbmCHXZsQBIaPsxOOy2he52qjB0uLxUVWMwXhPdHsLh2CZaCKoDYo/Jf98+
	b/6RKCy+tnsiOUBd1Tbc1WkYQXgzNwM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/5] mgmt-tester: Fix expected status for invalid key entries
Date: Sun, 20 Sep 2026 23:35:10 +0300
Message-ID: <7268f6f5d320c94b832f48c6132419525dd749b8.1789934710.git.pav@iki.fi>
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

Kernel commit 1e9683c9b6ca ("Bluetooth: MGMT: Ignore keys being loaded
with invalid type") made Load Link Keys and Load Long Term Keys skip
entries with an invalid address type or initiator value instead of
rejecting the whole command with Invalid Parameters.

Update "Load Link Keys - Invalid Parameters 3" and "Load Long Term Keys
- Invalid Parameters 2 and 3" to expect success.

Assisted-by: opencode:qwen3.8-flash-next
---
 tools/mgmt-tester.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 3eb2b20ad..542335e6e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2769,11 +2769,15 @@ static const struct generic_data load_link_keys_invalid_params_test_2 = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+/* Kernel commit 1e9683c9b6ca ("Bluetooth: MGMT: Ignore keys being loaded
+ * with invalid type") made invalid entries be skipped instead of failing
+ * the whole command, so this is expected to succeed.
+ */
 static const struct generic_data load_link_keys_invalid_params_test_3 = {
 	.send_opcode = MGMT_OP_LOAD_LINK_KEYS,
 	.send_param = load_link_keys_invalid_param_3,
 	.send_len = sizeof(load_link_keys_invalid_param_3),
-	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
 static const char load_ltks_valid_param_1[] = { 0x00, 0x00 };
@@ -3067,18 +3071,22 @@ static const struct generic_data load_ltks_invalid_params_test_1 = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+/* Invalid entries are skipped instead of failing the whole command,
+ * see kernel commit 1e9683c9b6ca ("Bluetooth: MGMT: Ignore keys being
+ * loaded with invalid type").
+ */
 static const struct generic_data load_ltks_invalid_params_test_2 = {
 	.send_opcode = MGMT_OP_LOAD_LONG_TERM_KEYS,
 	.send_param = load_ltks_invalid_param_2,
 	.send_len = sizeof(load_ltks_invalid_param_2),
-	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
 static const struct generic_data load_ltks_invalid_params_test_3 = {
 	.send_opcode = MGMT_OP_LOAD_LONG_TERM_KEYS,
 	.send_param = load_ltks_invalid_param_3,
 	.send_len = sizeof(load_ltks_invalid_param_3),
-	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
 static const char load_ltks_invalid_param_4[22] = { 0x1d, 0x07 };
-- 
2.55.0

