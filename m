Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586225BF18
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760039937; cv=none; b=PVJbeaaWYVg+LjvVQIJDE6uht/kz7HltpgsWcsrEJl9Zq9YiysksD0S3OA+0gcHPHVDfUTdzgEJvSJDSg/836+lKURg+vBe1qrD3pUtjaCAGZemSJ7ocFbjXR0GDNebjNtzcsztbZfcbxE3TrJhbywO8euvBl0C8uXEt+C8CU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760039937; c=relaxed/simple;
	bh=UC/fAlxaRYdqaUB3W77acy1at73gOBE59VO8iuF1Zys=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=c+ZTsNFcqvChHwIbYprYIE4Ma3/bMebK+Gx8wxP+FvWabEiEIa+U7EhLrEVVYg7m1++tQJ2Jb7p1T7O1kO7ILRnMQ2hcxQe5AWlaWSMgiYQxNzxjFm7cBBMzHgFFXFQmQC6EMu6jWFogiWkF7AwuiXTttoKtupbD134TFuTGASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KdEPle5P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KdEPle5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760039928;
	bh=UC/fAlxaRYdqaUB3W77acy1at73gOBE59VO8iuF1Zys=;
	h=From:To:Subject:Date:From;
	b=KdEPle5PNFwuOUIwPwMGFrF+Z/iquUfo9G1TmtamxiS2mey+QrTDKNSneaMLCRuO1
	 zaiD6Y4Qyfpi5zc2/IzoId9dXBNm47KK9UAZksknsQtAuz0NHVeLZmCSXIVxdlK4Ms
	 ZtKqhexzWWQ+cZ0ek9cCHlMh05/gQACwOJH4sRKNbP6M/qX2hQHzrA2dn2jOJC5sLF
	 ANpoEdXemjaD9u5E26bWJt8jpkoKSsuxZPCGrYJL+O+iDWnc0EwYFYXl7hxOgPeDyz
	 rfSIDy3xdFMBC1KTiHcKNMabDzbg5a9AdKdQhGtOPme/pu36JrY7RXheMP36uPTRIy
	 vHsrbEklB3Nkw==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-aB6e-1eE8-0e0E-15d0.rev.sfr.net [IPv6:2a02:8428:af44:1001:ab6e:1ee8:e0e:15d0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 229DB17E1060
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:58:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/6] shared/hfp: Add dial support
Date: Thu,  9 Oct 2025 21:58:37 +0200
Message-ID: <20251009195842.776231-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

If no number, NULL or empry string, is passed to hfp_hf_dial() this
will try to call the last dialed phone number using AT+BLDN.

If the phone number starts with '>' and is followed by a number nnn…,
up to 10 digits, it will call the phone number in memory entry nnn….

Else it will performed a voice call to the number provided.
---
v1->v2: Fix issue found by codacy in previous commit

 src/shared/hfp.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/hfp.h |  3 +++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 94adccada..a6f9645d8 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -102,6 +102,7 @@ struct hfp_hf {
 	uint8_t battchg;
 
 	struct queue *calls;
+	char *dialing_number;
 };
 
 struct cmd_handler {
@@ -1388,6 +1389,11 @@ void hfp_hf_unref(struct hfp_hf *hfp)
 	queue_destroy(hfp->calls, remove_call_cb);
 	hfp->calls = NULL;
 
+	if (hfp->dialing_number) {
+		free(hfp->dialing_number);
+		hfp->dialing_number = NULL;
+	}
+
 	if (!hfp->in_disconnect) {
 		free(hfp);
 		return;
@@ -1622,7 +1628,8 @@ static struct hf_call *call_new(struct hfp_hf *hfp, unsigned int id,
 	call = new0(struct hf_call, 1);
 	call->id = id;
 	call->status = status;
-	call->line_id = number;
+	if (number)
+		call->line_id = strdup(number);
 	call->hfp = hfp;
 	queue_push_tail(hfp->calls, call);
 
@@ -1807,7 +1814,11 @@ static void ciev_callsetup_cb(uint8_t val, void *user_data)
 			DBG(hfp, "hf: No new call index available");
 			return;
 		}
-		call_new(hfp, id, status, NULL);
+		call_new(hfp, id, status, hfp->dialing_number);
+		if (hfp->dialing_number) {
+			free(hfp->dialing_number);
+			hfp->dialing_number = NULL;
+		}
 		break;
 	}
 }
@@ -2421,6 +2432,50 @@ const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id)
 	return call->line_id;
 }
 
+bool hfp_hf_dial(struct hfp_hf *hfp, const char *number,
+				hfp_response_func_t resp_cb,
+				void *user_data)
+{
+	const char *c;
+	int count = 0;
+
+	if (!hfp)
+		return false;
+
+	DBG(hfp, "");
+
+	if (number == NULL || strlen(number) == 0)
+		return hfp_hf_send_command(hfp, resp_cb, user_data,
+								"AT+BLDN");
+
+	if (number[0] == '>') {
+		for (c = number + 1; *c != '\0'; c++) {
+			if (!(*c >= '0' && *c <= '9'))
+				return false;
+			count++;
+		}
+		if (count < 1 || count > 10)
+			return false;
+	} else {
+		for (c = number; *c != '\0'; c++) {
+			if (!(*c >= '0' && *c <= '9') &&
+				!(*c >= 'A' && *c <= 'D') &&
+				*c != '#' && *c != '*' &&
+				*c != '+' && *c != ',')
+				return false;
+			count++;
+		}
+		if (count < 1 || count > 80)
+			return false;
+	}
+
+	if (hfp->dialing_number)
+		free(hfp->dialing_number);
+	hfp->dialing_number = strdup(number);
+
+	return hfp_hf_send_command(hfp, resp_cb, user_data, "ATD%s;", number);
+}
+
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data)
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 4b171ad88..21214eee4 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -237,6 +237,9 @@ bool hfp_hf_session(struct hfp_hf *hfp);
 
 const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id);
 
+bool hfp_hf_dial(struct hfp_hf *hfp, const char *number,
+				hfp_response_func_t resp_cb,
+				void *user_data);
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data);
-- 
2.43.0

