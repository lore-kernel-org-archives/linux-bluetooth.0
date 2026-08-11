Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E29386567
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461034; cv=none; b=RtdrYdim/UD9Rk4yzEKTRIe1L6Nah8/77g/nHLoTtN983o6NgHqGjjX41PqnvgP03nEtCKtlgP+0u3TeBK8O3ZRlomL2T8aDarrpNQuxao1yXcuzPPmYVk75LHl468iOeHT9lI5pdmV0Dtmm+TYCRk6Bmp35TnM6UOx43LM87Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461034; c=relaxed/simple;
	bh=Myg60ld0JdNZBw5mpLrbCHtjZoCSQAH1L876dzqErt0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6Gvk2fBev7Qp/ZINkbv2oezq+Bx4lkQDkgu+7KaGHuOWyu7qvaZuYuD8Nuk5dvP/EXxrtMJQKW9Xij1tE40VPZn9HDQ8WEKWG6aRkpb1nOI1L3QqyTBPV4x+m//qWXTKMWijiiPjwKFSa+hZAIGAyKNkOQUraN9GmqYLAambAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5408858239E
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E82453ED11
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:14 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 7/9] unit: Add test for slow element_end() append
Date: Tue, 11 Aug 2026 16:54:10 +0200
Message-ID: <20260811145704.1766949-8-hadess@hadess.net>
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
X-GND-Cause: dmFkZTE7//a8gsi3w1GPpapT5Ukt+fEcfN0ZqTSeGCFTUi06HsKf4CTnNBAfQbQDkgHMQet12ca5SSLbtGFwNNEDfR56GEWiE694LLeds/YbTFK8oKE84ZZdRJN/9FvvJbitjEXe5X2Ux89sLo+6GZDvGV8fazWxgXEouHAPP8iOQOz18/3hSyqTpUBzum+i6Ub0Nt2fhaOHGrZ6NgN+LKLEtlkbSxHz7YtbNs3pVeVioymzgo9MfUufhQwyCrV3uFtqkiDCROWsNOJPwtkJ1K6Q+FDhjCe4szlYUmtKvmhPVzImpKtNCEY8GR2ieMfP074xV8f74uk7YI29NimMTemkaUPeWwuI7Fnm1KrGyJtIiCQG70nsvVk6klZ9McMeSmeWH7nNyCDOY0rYDsTb8nwCNpkHKbqRKIB4/uow9BXPA0GWQ9FU0Do6dIS8MFD11mGB5r3lPWyiGpO+GhSwRtivIkeu80be9TijaDCNDlWHwjUXUA09FvvWYBaUrqfbI2Aa/VP0fXHFGwPWlhT+RN8wGjOMzhRMKNGJmYXJD9wZLvQNhB9HO5Dq1qs2BQVDYjfkjCgP2oaOFOIvCNbwltoEOMs2TrSOAj8n8p+FxsYzSkyGMW59UbZw9b2eukt4UYvJ2dZAti6eOBjVslNib7O4WhKkHzDGEx2ju3sZscWvEzDGBQ
X-GND-State: clean

This uses 40k iterations as this takes a visible amount of time on a
pretty fast desktop machine (3-4 secs on an i9 9900k).

See: https://github.com/bluez/bluez/security/advisories/GHSA-4p57-mrcv-r2jc
---
 unit/test-sdp-xml.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
index 2794170dc153..0a4f9b0d3992 100644
--- a/unit/test-sdp-xml.c
+++ b/unit/test-sdp-xml.c
@@ -64,6 +64,46 @@ static void parse_xml_for_filename(gconstpointer data)
 	g_free(path);
 }
 
+#define XML_START								\
+	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"				\
+	"<record>\n"								\
+	"	<attribute id=\"0x0004\">\n"					\
+	"		<sequence>"
+
+#define XML_VALUE								\
+	"			<uint8 value=\"0x01\" />\n"
+
+#define XML_END									\
+	"		</sequence>\n"						\
+	"	</attribute>\n"							\
+	"</record>"
+
+static void sequence_on_squared(gconstpointer data)
+{
+	struct test_data *t = (struct test_data *) data;
+	parse_xml(t->s->str, t->s->len, TRUE);
+}
+
+static void sequence_on_squared_setup(gconstpointer data)
+{
+	struct test_data *t = (struct test_data *) data;
+	guint i;
+
+	t->s = g_string_new(XML_START);
+	for (i = 0; i < 40000; i++)
+		t->s = g_string_append(t->s, XML_VALUE);
+	t->s = g_string_append(t->s, XML_END);
+
+	tester_setup_complete();
+}
+
+static void sequence_on_squared_teardown(gconstpointer data)
+{
+	struct test_data *t = (struct test_data *) data;
+	g_string_free(t->s, TRUE);
+	tester_teardown_complete();
+}
+
 #define DEFINE_TEST(fname, res)							\
 	data.expected_result = res;						\
 	data.filename = fname;							\
@@ -82,5 +122,10 @@ int main(int argc, char *argv[])
 	/* From https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc */
 	DEFINE_TEST("duplicate-attribute.xml", TRUE);
 
+	tester_add("/sequence_on_squared", &data,
+		   sequence_on_squared_setup,
+		   sequence_on_squared,
+		   sequence_on_squared_teardown);
+
 	return tester_run();
 }
-- 
2.55.0

