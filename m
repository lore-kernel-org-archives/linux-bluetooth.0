Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD341BDFA
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EssZOpOX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8C35C43141;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413639;
	bh=NvolrZ1r/y7wWC9D7JKhSSVI2sMbcjnlzO+Cd5rTv/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EssZOpOXZXZxPTlnV+WEkxHnCo+IOyvS8xvHu+wO51Lb1iOB3TqBokUYIc13hXXmc
	 xDNAOfsZyBJc3z535VM78QS/FY64nXDRBy+ee5PX37xraHGwAgFgYvcdEUORf/fksK
	 nHKZ2sykjN7giOeaHackeJ0roOMc8cjGWfsW3OYUzQ/P+bPFxyWwZOTx15AXjh/Uig
	 Kg4W997iBiEspFRFeeLDm587UDqwuwbarowjK4HYC7Kp/W2mcJepoAWHgLJKHwZdnA
	 NNh6Hi7vS+57YaWY+dmr4097IBMWhSHhVAktW8twtGlw1uloezAsIzwPlE2+U+pPLk
	 TZfmZn1uo14PA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80B2C47DAF;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:00:36 +0000
Subject: [PATCH BlueZ 11/20] gobex: const annotate RO arrays, use
 G_N_ELEMENTS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-const-v1-11-17c87978f40b@gmail.com>
References: <20240116-const-v1-0-17c87978f40b@gmail.com>
In-Reply-To: <20240116-const-v1-0-17c87978f40b@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413636; l=1328;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=fKEuOSVKg0zguPSlbGmjQMiLNTaWi6zZrrBTQ9MTicY=;
 b=0OUt50pFkhUCXUGGFl5FRDpNCvoyOOEqLLNQNxqu1qafyrRwAGipXGI30lQSczquLxIwZZGYu
 FL5ynJpKvwYDlAD42F5dtJcDo8NiyUJt2WB5MEa+s7VAwqXWknO3tCX
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

---
 gobex/gobex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index e9b89cead..8924e059f 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -122,7 +122,7 @@ struct setpath_data {
 	guint8 constants;
 } __attribute__ ((packed));
 
-static struct error_code {
+static const struct error_code {
 	guint8 code;
 	const char *name;
 } obex_errors[] = {
@@ -169,7 +169,7 @@ static struct error_code {
 
 const char *g_obex_strerror(guint8 err_code)
 {
-	struct error_code *error;
+	const struct error_code *error;
 
 	for (error = obex_errors; error->name != NULL; error++) {
 		if (error->code == err_code)
@@ -1423,7 +1423,7 @@ failed:
 	return FALSE;
 }
 
-static GDebugKey keys[] = {
+static const GDebugKey keys[] = {
 	{ "error",	G_OBEX_DEBUG_ERROR },
 	{ "command",	G_OBEX_DEBUG_COMMAND },
 	{ "transfer",	G_OBEX_DEBUG_TRANSFER },
@@ -1443,7 +1443,7 @@ GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
 		const char *env = g_getenv("GOBEX_DEBUG");
 
 		if (env) {
-			gobex_debug = g_parse_debug_string(env, keys, 7);
+			gobex_debug = g_parse_debug_string(env, keys, G_N_ELEMENTS(keys));
 			g_setenv("G_MESSAGES_DEBUG", "gobex", FALSE);
 		} else
 			gobex_debug = G_OBEX_DEBUG_NONE;

-- 
2.43.0

