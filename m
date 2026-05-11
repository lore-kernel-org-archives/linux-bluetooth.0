Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB59371049
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499329; cv=none; b=SD34QkmW8Y9T5toj1cK9pK4maIllBNZvTNORQk1Y7V1M7i1djtLlaFMsc9OVVlVqd9iQnq1e4sBRUgXeu4taC7Q36SckHzgCg4jb3oDEkXdaRsooV8ixOoQ/yuLu7J7hEpyDb+pq32ECSTj29zE/zcgk3IDQM4d6XY+Vh6+NBsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499329; c=relaxed/simple;
	bh=SH3dftZzjiOHiY54Ji67254WZ+ZXGSwwuMCAECEIerQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikNC2W/3wBgY2VUKPU/AXu5KYVGVAWZY+Ab1diyORw/eCG59SyCsOVH8rFyZM4QFtYYWPqVyMCG6y6pcuTjayyLIhYgEQoibdTC05q9aLMgowtMY92AagFI2N3cVrtJEnVWCSjk6e+Ob4TuS+a15fE3YkgXNKMLS8+TgNSKtI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C72403EBD0
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:35:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 2/3] mesh: Fix str{r,}chr usage
Date: Mon, 11 May 2026 13:35:06 +0200
Message-ID: <20260511113511.1217887-2-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511113511.1217887-1-hadess@hadess.net>
References: <20260511113511.1217887-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTE0P9CzzhI7/mFJDYy52Q5Y4HCnJMbzySdemXis2wHaQpxY8eWThnl6gGGW3sVTgKwsxOFWk7oNIMKcDpzWNF88hx5UXIzN8YBdpL7TbknOwa0hTtB/rLMcRb2Glr3lDt70Lb4cxmGGXGNt15o4fPu5/OOiDKfGdJK5cnfHE+zuej6sdYh7M89lCcUHUj3FR0v3t21nGZmknzxMGMY3T02sDvVp8AU+/IsHkMrJB/UwTvG+vvqN2yc09S9uyYHFSJJw2I18/ht4nk4mHhOUcIL7MLV464q0xNUk31PVL0yZl5Xno/p/atb5H2DT+tThWw1rU+z+n99VSB29gkHJVqpnqteza1vV+Zldwn4zpw1I9DOBVG9hqqmXpADKorVg6WJz9GVlDRl5VcDbQFb3EK0U1AsHT+Sozhcc3zYq8srqcljhe5St2fgx1kVDNMFBv2A2T5/VSShLcl3b3pjHsbFhEovmPQCm9Oqzk5tXV22TyMAXpI/vf7SJ+Z6sbx6XMV1eEbLi92JzNuGZKtbSIlDayJDryYlPDIHvjvAmdahtoYvtNR/nyH9W9nh2blFKOvOoMVAwSzqeglJl/6oTyKJWq5ZJE0Y+zzcqch2Pjp1Yo392eFBVpnJTXsU0zGuE8AmD6bGJPIDkhA2tCsf+R1FH6w9iTL5CbmhgX1zVBMEhRQ

Fix the code manipulating "const char *" return values from
json_object_to_json_string_ext() to modify it for printing, we're
not allowed to do that.

tools/mesh/mesh-db.c: In function ‘mesh_db_finish_export’:
tools/mesh/mesh-db.c:2598:13: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
 2598 |         pos = strrchr(hdr, '}');
      |             ^
tools/mesh/mesh-db.c:2604:13: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
 2604 |         pos = strrchr(hdr, '"');
      |             ^
tools/mesh/mesh-db.c:2613:13: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
 2613 |         pos = strchr(str, '{');
      |             ^
---
 tools/mesh/mesh-db.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index fb9c436d1d06..7bb8ab53ecbb 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -2547,7 +2547,9 @@ void *mesh_db_prepare_export(void)
 bool mesh_db_finish_export(bool is_error, void *expt_cfg, const char *fname)
 {
 	FILE *outfile = NULL;
-	const char *str, *hdr;
+	const char *str_s, *hdr_s;
+	char *str = NULL;
+	char *hdr = NULL;
 	json_object *jhdr = NULL;
 	bool result = false;
 	char *pos;
@@ -2581,15 +2583,18 @@ bool mesh_db_finish_export(bool is_error, void *expt_cfg, const char *fname)
 	if (!add_string(jhdr, "version", schema_version))
 		goto done;
 
-	hdr = json_object_to_json_string_ext(jhdr, JSON_C_TO_STRING_PRETTY |
+	hdr_s = json_object_to_json_string_ext(jhdr, JSON_C_TO_STRING_PRETTY |
 						JSON_C_TO_STRING_NOSLASHESCAPE);
 
-	str = json_object_to_json_string_ext(expt_cfg, JSON_C_TO_STRING_PRETTY |
+	str_s = json_object_to_json_string_ext(expt_cfg, JSON_C_TO_STRING_PRETTY |
 						JSON_C_TO_STRING_NOSLASHESCAPE);
 
-	if (!hdr || !str)
+	if (!hdr_s || !str_s)
 		goto done;
 
+	hdr = strdup(hdr_s);
+	str = strdup(str_s);
+
 	/*
 	 * Write two strings to the output while stripping closing "}" from the
 	 * header string and opening "{" from the config object.
@@ -2624,6 +2629,10 @@ bool mesh_db_finish_export(bool is_error, void *expt_cfg, const char *fname)
 	result = true;
 
 done:
+	if (hdr != NULL)
+		free(hdr);
+	if (str != NULL)
+		free(str);
 	if (outfile)
 		fclose(outfile);
 
-- 
2.54.0

