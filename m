Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7D391838
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461033; cv=none; b=D/rRHz0vByR5WS0po0ZX+ji7cgrB9F6npvefmwWp5ysmTt2Nwp0JnmqXFvBGh11wSG5vADG+ffI1L7k45p5g9JrxOroAlqvhVRxAZllCTjjyG/ZGfPDbc2sLVstM3vqEG/5I4mnrNleu7XvATR4HXVzZ4NXfty30jZE8et3Y6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461033; c=relaxed/simple;
	bh=pTjOLgblxTnbQYD8OQGVhcAdO/mga+lQbTCyRzpi1mA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAL7+YWlFaab3jHzVlGs3EsiAmoJwRg1so5KzAr1fCFsAcpK3bRIIphRdC0p4bJe6DkywNxvBOYP6vU90v0ZbjbDa27SIz5O0geQDqJTgkf/iF+poJO2GezbJkHei31eORQXveDy/OvskHqwUrdgeEAT0wxhERBR4OT5TbBTvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 66BA55823A6
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55F1F3ED15
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:15 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 9/9] unit: Add convert_sdp_record_to_xml() to SDP XML testing
Date: Tue, 11 Aug 2026 16:54:12 +0200
Message-ID: <20260811145704.1766949-10-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811145704.1766949-1-hadess@hadess.net>
References: <20260811145704.1766949-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTF4bdVHFdZG4ll+rkbPd4OBQm7n4PeAxiBvwtIeMQr0JxyH0jMI7CIh0yO8VHtbAjnjyTUVcX/+LOjlbUj0Jc38vMSlj7MgAgF/YKstwnYcVs8H+qe2OlQQ45quGtMhPRKXk+jkUThgKyKUTZFiD2iLMqd2XQJbZF8axpqz2frx5d/7JnMP5udHcMOOsLijYqjg0my3Yl9QgaeUoIp8WKxeMLMzUaO8EBwXb/DELMyYvuvRIKK3TkxOj28MEPFChdbzmiXO0Vw3JHsRbe10V9NROOalZV+IiiRXp60coWsdh7hH3WJ8NpXriAhtbu2HP6TMXk7qH3rbr1j4twUFTpE+eKaxyzxVCW2v73dEH02jHboSieqWWNP9PWJ/1pWqj1avSWjcQNvIKjEVvgePIaVqVKQH3t6RxDjxDiffwnmZUWcVG0U198j6T5h5EDY0lll0lNNQg0msETfAkFeppMt5UvUNQ8SsYnTav1Tfp+FkE9CspEZHnFebgIYxikC9EnEFtz6Z82mPEwKoFyx73fvPl7ePpr3+Je2ebSXnbm9EoPtqXOlqueC4wVOvi59UlqHOS5b1coE+BOOfSIFfNN0sc5Bmeh7ZidrMKqK2z7ggoqW0bDcVoaoSpcJrn84h5zUhGXt+BnMw+uop0lgix+W/GoXVoG1HU1Vp7G78+xq5hg
X-GND-State: clean

This tests SDP binary to XML conversion, including whether a fix for
a stack overflow when dealing with large sequences, like in
sequence_on_squared(), works correctly.
---
 unit/test-sdp-xml.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
index 0a4f9b0d3992..9ebe6ee5b912 100644
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

