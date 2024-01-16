Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6C1BF21
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eITnELqp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70C1FC433C7;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413639;
	bh=cWdugJEuHZ01hL67IcYj3CskgRjmmsH+t0DUp0K4p1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eITnELqpiLzQJdPg2jgIk42wkz3Ln1hZpS+CWfvLWbsxtN3FKFfSzFHZ9ctfRGF6i
	 U1QY9aprVijerHX3U5R0RuQTIV/Af1DGpzRqst4eTIicwvr6l9/Dq+zlHXC1OjeC+T
	 Xc6qzjY3R7LGZDNvDNockDKQVDUnY+7gqlw3jolCfbrfuhLuO3Jzls5HEW2n6Io3+f
	 da5N448yIhya1J/hHIRAryLZAwjRYjBWoCYguqPgtVJTKxDz6xEHHa6jvukZk9bRZM
	 7CRdtPdZKvQnWK+VoH+VGQo6EdhyXr5z97pdNplgaheHWqKxGJAnmgW6dmFqWq3kfK
	 zB4cVxJDFr4UQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C61C47DA9;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:00:27 +0000
Subject: [PATCH BlueZ 02/20] monitor: const annotate util_ltv_debugger
 instances and API
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-const-v1-2-17c87978f40b@gmail.com>
References: <20240116-const-v1-0-17c87978f40b@gmail.com>
In-Reply-To: <20240116-const-v1-0-17c87978f40b@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413636; l=2252;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=SWETOT2uVy6nUDBhnJWLVd9iTSKcoM2gRJYy59LqmtQ=;
 b=LSW+gQOehX9oFttXX2MOvyPWVh81sCxYC31oTPd+wg3hT0QDevNUgrrtgAbIOlLsZDVSm6NCK
 7BsgwcMBXFCDTKXIR0rHHqGyN5vHq0yCvUV1y9dLjxmFQARNa4QH/Yn
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

---
 monitor/att.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 9db273223..51a5a759c 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -683,7 +683,7 @@ static void print_ltv(const char *str, void *user_data)
 }
 
 static bool print_ase_lv(const struct l2cap_frame *frame, const char *label,
-			struct util_ltv_debugger *decoder, size_t decoder_len)
+			const struct util_ltv_debugger *decoder, size_t decoder_len)
 {
 	struct bt_hci_lv_data *lv;
 
@@ -705,7 +705,7 @@ static bool print_ase_lv(const struct l2cap_frame *frame, const char *label,
 }
 
 static bool print_ase_cc(const struct l2cap_frame *frame, const char *label,
-			struct util_ltv_debugger *decoder, size_t decoder_len)
+			const struct util_ltv_debugger *decoder, size_t decoder_len)
 {
 	return print_ase_lv(frame, label, decoder, decoder_len);
 }
@@ -813,7 +813,7 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-struct util_ltv_debugger ase_metadata_table[] = {
+static const struct util_ltv_debugger ase_metadata_table[] = {
 	UTIL_LTV_DEBUG(0x01, ase_debug_preferred_context),
 	UTIL_LTV_DEBUG(0x02, ase_debug_context),
 	UTIL_LTV_DEBUG(0x03, ase_debug_program_info),
@@ -994,7 +994,7 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-struct util_ltv_debugger pac_cap_table[] = {
+static const struct util_ltv_debugger pac_cap_table[] = {
 	UTIL_LTV_DEBUG(0x01, pac_decode_freq),
 	UTIL_LTV_DEBUG(0x02, pac_decode_duration),
 	UTIL_LTV_DEBUG(0x03, pac_decode_channels),
@@ -1336,7 +1336,7 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-struct util_ltv_debugger ase_cc_table[] = {
+static const struct util_ltv_debugger ase_cc_table[] = {
 	UTIL_LTV_DEBUG(0x01, ase_debug_freq),
 	UTIL_LTV_DEBUG(0x02, ase_debug_duration),
 	UTIL_LTV_DEBUG(0x03, ase_debug_location),
@@ -2769,7 +2769,7 @@ static const struct big_enc_decoder {
 
 static bool print_subgroup_lv(const struct l2cap_frame *frame,
 				const char *label,
-				struct util_ltv_debugger *debugger,
+				const struct util_ltv_debugger *debugger,
 				size_t debugger_len)
 {
 	struct bt_hci_lv_data *lv;

-- 
2.43.0

