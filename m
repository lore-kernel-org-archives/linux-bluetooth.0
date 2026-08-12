Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960AD3C8724
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521870; cv=none; b=CMFCed7QqD+HBpE4eTCFjtgoe/HRawJs3vp6h3P0rSfVeDX/k50/LTAKWJP1ibWF1Oo7V0IvJL/yAmR3afiPOEJF7/po0pctiZRFlAio/7wNxICRoRnpp3VxuyHcPMqqZyYh/0o4A4fxmTLf4IYYixLpaBglnqzBAEWz0gjgXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521870; c=relaxed/simple;
	bh=fbzMp8zUmmkyaSV8/ptozSBnt+zUXcQ38buGHz488sg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGgcClTjtyWOse0FXfYvol5zdTtaIKTzSOV2f2Br56m7B5UXSwuXZD/+aJbXnXs6dXEXrlDx2zvITZPvVlhj77AFcTc6SyBbzZWOzCOjwwjZt92r4Z6/L9Og+29cOHwEKtHxkAFDzb95HHnJVBzoAn8cvDLLv+LHMOGrLUAmoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D1EE3EE68
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v4 7/9] unit: Add test for slow element_end() append
Date: Wed, 12 Aug 2026 10:01:38 +0200
Message-ID: <20260812080410.2116906-8-hadess@hadess.net>
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
X-GND-Cause: dmFkZTEATMgZESnXpnF9odixN+j9pjFJQtDJ1lOhKFVo5Z/nUe0V4kv8/975cH/jEC+64/687m2yeqptp72V8V+Fn9K7g/HOIo1s/A9vRcgAydT3FnC79LRZiaW2AsRMtWp8LHcLMk8RcFDZX+r73gvBiN0XAE69n/K+cGPfKTwfhuW4u+6P6l14AuHgA/JCsdUHL9YAy7vZyMQgTf4Y9kDKFjf6ZpkPzEK1NNr+QOxeLPriprXbk5OoT4J/7DzuhFaA2uT7ogxycD/0WB/G3uqVtCR3ahE9Xg872i09EVeEPn7oX7BCDVBYVDLUT70+1UfOo+2x9MExJKd0WKIq1ANYXqkcfaTlRgnpmFiLKVo8aYOK/7HQxgavYYEog055d18dJwfN6h0SmruTYul6GDrxHkrKgUeaurhhCxSY/Uujelk1X2OoK8NLAwucI3REqYJTAJ6GjGma8MiLD/Vya/3U236Z0znLuQsS+PlfNW8DM1NPC7iUqUauckJfwEy1BpEvQHD8GoBaQ4zO4Wvhyjy+QGsfL53CPYYvB/ddmEmuaaca0b+H2lZXKZj5PCseSlGcddlRHlSMHIp4+NJeLvSgKmghnOVRBf4b3zUdaYs3cWWn/hLEnMD9dqIT3k/9LXQ7gO2dm9J5oN074w/sdIy3T5L2GfjP0WsuP9Vgxka/VI6bDg
X-GND-State: clean

This uses 40k iterations as this takes a visible amount of time on a
pretty fast desktop machine (3-4 secs on an i9 9900k).

See: https://github.com/bluez/bluez/security/advisories/GHSA-4p57-mrcv-r2jc
---
 unit/test-sdp-xml.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
index 9bf35235423b..5aa98334eabc 100644
--- a/unit/test-sdp-xml.c
+++ b/unit/test-sdp-xml.c
@@ -65,6 +65,47 @@ static void parse_xml_for_filename(gconstpointer data)
 	g_free(path);
 }
 
+#define XML_START						\
+	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"		\
+	"<record>\n"						\
+	"	<attribute id=\"0x0004\">\n"			\
+	"		<sequence>"
+
+#define XML_VALUE						\
+	"			<uint8 value=\"0x01\" />\n"
+
+#define XML_END							\
+	"		</sequence>\n"				\
+	"	</attribute>\n"					\
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
+
+	g_string_free(t->s, TRUE);
+	tester_teardown_complete();
+}
+
 #define DEFINE_TEST(fname, res) {					\
 	data.expected_result = res;					\
 	data.filename = fname;						\
@@ -85,5 +126,10 @@ int main(int argc, char *argv[])
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

