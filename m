Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799F3AFAEA
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521870; cv=none; b=HYG5gmjSjblJtrJqfTfMJ4aVBk0qSISpo3Lp0Y79y4vfR2gjHQdJlILZYAaS94OrWtVnLJerGN2z3d4/PSj5k2vP0PedH1IyABRaMnTGUX5IKFNRc9QcQ4l7z0rAscIMv6pgH35N/omKzYPM8bn8TEHOGSMVe4h0+nceAM4r7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521870; c=relaxed/simple;
	bh=MP9V600FdG0yxJadJzr96EBtWO4KgO/CNbXOOAQs3c8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvI0z5cHSGGc+cAotxKTT8+MilIjxgcNEawZXb4xJ+AjC5Mwn8Nkv2IxBvbE5at4vUW/s2DxsjY6seAh3A8nqzt3ivJIFSiuOhs6Y2MKnf08oVi5Zk3PYRhHHCMB+F483NJCljphyNTJk4m/x9A5dHPOVzSLC72K7n9AzgwME/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A9193EE28
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v4 9/9] unit: Add convert_sdp_record_to_xml() to SDP XML testing
Date: Wed, 12 Aug 2026 10:01:40 +0200
Message-ID: <20260812080410.2116906-10-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812080410.2116906-1-hadess@hadess.net>
References: <20260812080410.2116906-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGnQGjbKmJd+Y1MDjSo4aN39TQZ1m7TiiY5swXGq+cBi1hlzlgQeWT5sd4v9pGo2Nult/OOPKFeC13MfhnGyEUlm7mauNaNtYRSeH0HVQvJT6SPmzqJl1RlOB7yVKDhDY5kCqJc0c7WnSfTn3uUh4zzQBNdk9XWciFveg7ufvMNisAUO8qq6QjjOns56rugpCW9OQnsy0EBXkM1hLpdmrTuFKryV78jHsSAizA96ZGrEL2yS9/PqU0nyfqgPjtlqOboqqA3QP7N3a15ICheKLviMZFIh02+gbGL8UUH6STBWhpbmEF7EZx5iFMWSGAhB2nw8OMVROSckGhTcuZ94yRlL0bI3nl9yUgCUeln7B6+o0j3b0/CZiOFYcJlXU6E4O1wuRLm47Dv5YnOvWzthaEBixU6uQnEjrdIG1Kjkm+jAt7Yj9WXOjQ3zogS98koy3fJK2E7A/Ev/HJE59hne8cK4AGtv6pmQJAqOjn3+umGwEtvyofaitQCkwodny7AOfNFSo6diVamRrE9702goiAfA7Hr+SN/UgvR1cWyU99IX1DIhx/Z74n83pLwjvswpMfHZ5A6mY1P3La1LAWv5U1D2ElXbch+RrN/nMR6ckpUPfbYWYd9cAGXHkoYZzOAqSGXhB+1BLk0rBcFg2PhcwnVjx9a1/rWOP9CBurfR9aeIw
X-GND-State: clean

This tests SDP binary to XML conversion, including whether a fix for
a stack overflow when dealing with large sequences, like in
sequence_on_squared(), works correctly.
---
 unit/test-sdp-xml.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
index 5aa98334eabc..b338788aa295 100644
--- a/unit/test-sdp-xml.c
+++ b/unit/test-sdp-xml.c
@@ -28,6 +28,12 @@ struct test_data {
 	gboolean expected_result;
 };
 
+static void doprintf(void *data, const char *str)
+{
+	/* Do nothing for our tests */
+	/* printf("%s", str); */
+}
+
 static void parse_xml(gconstpointer data, gsize len, gboolean expected_result)
 {
 	sdp_record_t *rec = NULL;
@@ -39,8 +45,10 @@ static void parse_xml(gconstpointer data, gsize len, gboolean expected_result)
 		tester_test_passed();
 	else
 		tester_test_failed();
-	if (rec)
+	if (rec) {
+		convert_sdp_record_to_xml(rec, 0, doprintf);
 		sdp_record_free(rec);
+	}
 }
 
 static void parse_xml_for_filename(gconstpointer data)
-- 
2.55.0

