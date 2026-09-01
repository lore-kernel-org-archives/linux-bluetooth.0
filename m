Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB261488213
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285212; cv=none; b=TFey2DP4xvh8FGl1G6fZoh9rR0wt36H7XslRoZPUPFVZlhbLRKcLHJzB0qZqBRP5Cp4z0MoO4gpkv5GF60UoF1NS3pUE+v0w5B9Qq9n3vQ673wMvW2TPU/OhFon/FQ2w1U7/R6hVJLGezHpOi6h10/L3FycXuQyDt37UHN5PKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285212; c=relaxed/simple;
	bh=NAJIqcmkGUc3mtiWs61eByeIBiAz24RQAouuMIQDVLM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9KmgDMDVuBTOem+XiCkxTbOTeUkBI4fpaNziPC7VlCnuoYUL7ZsrzC2HYycKIFKmUws3Buto2WalWw4mVJ/Wk0QMomnP9HqPd4F/7nIRSEppWIf6TAAp7guOk4X03FOYuyxpZ9arNVlU14e5CDYdCB7j3q1JSM3h7HcwfoM0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlgwYx59; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlgwYx59"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c79c9f7b54so104039e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788285209; x=1788890009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pS+Mfnjcg1IbQN9RYjwRE8/ttL7aE0IrrST4UoLLaW8=;
        b=YlgwYx596YO1h7Saq9AbLm8/1pv4Tg6Rf/sHlpJ67DknUtJrXjJgEE6aFhzN6/6Dru
         Yys6j28hZJlhCptflk3EdSNb1tF0DPdR6Zu9VRnlYOHQnnnzd4BXIoarzfThAByYZSji
         T+0JvP2/ZE23v7esflrjwtsw1pL7A6vV01kMaiC8l7RxwafBwGF4cWzOni3VKLehjCk0
         Pfo0Xq2yox93LDy5hRxDUu5jTUTc1AXymfqGwTA1jS/EZgW5y0dFtvRd0XPmX+e7P8/R
         4c7cTxOQlVOLQ5M0Iu2BJ/ax6DqbKmw8hd0nbTXdFdxyGa4gK5JwRvZNRB72nN0sxL7o
         636g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788285209; x=1788890009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pS+Mfnjcg1IbQN9RYjwRE8/ttL7aE0IrrST4UoLLaW8=;
        b=GVe0cFxGlFAKy7pclEhHJBofkHMJBQ3DZFhG9c/WuqBLKDhO23ApfA1ye2ci4Y4pJL
         slvjHfubkEZhsZxdgiHdUBaAjPQFl27vOwJKOL22EaRQxJgU5Uj4g6MRsUycXFcwb1yI
         Bryt1XYuS4ut4AwpyQeR2ro+TurR1FwWkxXC9exprtdSt78nNMeZijsAmH4Yvt3qkrqW
         y9LsxiZbIy2hAVKqUEP+42gowT6hot5KRk06+zDIOtlPH0Kw6CS/Qo/RPI4wFxyHhpbA
         0Re4DGdl/3Swi2fAgJXpHSaENxdZtNzRFtO9OMWzmXhg+szVkJH27otVs6/StbwH4zvk
         0aOQ==
X-Gm-Message-State: AFuF++lMpZfgrrKx2GFy8xNDwh4eO3+fIZO+oSPksCzcAwZpx/0kqUls
	2cRhW5lNJgmQ8DiXVGyWFbnh5I9wwF7TVa/O3cVBICJL7l4EXcwRpYLJDdv7AN3D
X-Gm-Gg: AYBFou3Hmfk0ZdkIG2eP5Cen64UczrJeggPNR2eNv5gBTyenumkspodBKnXnh/cpOWF
	ED76uNftwdmocOby89K/nAEkHmfHuILxbm5awBcCpoSK8JiwpZUwLXRSVWQTHVok7RsRMOAxrgf
	F/fCjcpGTZkpomCU/nGljxYOHOk0z2kwangbCrnGB4723YF3g/jrRAhEYwmVVRnserV0KqBvVpm
	wc8pCXKY/CtoV+A3BzZV4qyYTbVjEQne+pFTsiUK1Bhy4m6MY8X3KtJ2dVzQp7oDjG/Ohr91HeH
	5kvCgQoWt6jvTCSsOKbk6XCyzLtNKJp3mE0k9BHVkJuFFMVe2LUk1VdmKnLP5ipGcHqdGG+fWiH
	038iisoS1+q1dqMQlD2XBQX229Fkyu5qmB9Xz2v8XKswZBaDZoB/CLhK1IGpcGkIP1zhUO5PdRI
	apMf8vrBLQja+uA0sgAwh0VK7lbzmw0/HhnktKYAG7YWGcUcZxsPNTxZoRsFO3wJ7CivkeeFLAk
	QPjx5aLisW093bd/iCpEaRnoDYIExx1mcnnq22jfGX200dftjLGvNw=
X-Received: by 2002:a05:6122:660f:b0:5c5:ac11:9731 with SMTP id 71dfb90a1353d-5c7cf4693b1mr65972e0c.8.1788285209286;
        Tue, 01 Sep 2026 10:53:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7cd94646csm254265e0c.18.2026.09.01.10.53.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:53:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/5] unit/test-avrcp: Add robustness tests for response parsing
Date: Tue,  1 Sep 2026 13:53:15 -0400
Message-ID: <20260901175315.1348621-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901175315.1348621-1-luiz.dentz@gmail.com>
References: <20260901175315.1348621-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The existing tests drive avrcp-lib.c through the AVCTP harness and all
feed it well formed PDUs. Nothing covered what happens when a peer
sends a response that lies about its own length, which is what the
three preceding fixes were about.

Add tests under /robustness that call the parsers in avrcp-parse.c
directly, since a response is entirely peer controlled and the parser
is what has to survive it:

- headers that are short, that declare more parameter bytes than were
  received, and that declare fewer

- a ListPlayerApplicationSettingAttributes response declaring 255
  attributes, which used to be written into a four byte array, and one
  declaring more attributes than it carries

- attribute lists declaring a 0xFFFF byte value with none of it
  present, a truncated value, a truncated attribute header, and more
  attributes than were received

- media elements missing the attribute count that follows the name,
  carrying a name longer than NAME_MAX_LEN, or declaring a name that is
  not there, and the equivalent for media folders

Each PDU is copied into a buffer of exactly its size, so that reading
past the end of it is an out-of-bounds access rather than a read of
whatever the receive buffer happened to hold beforehand, and the
attribute array is surrounded by a guard so that a write past its end
is caught without a sanitizer.

Reverting the three fixes fails ten of these outright and trips
valgrind on six more.

Assisted-by: Claude:claude-opus-5 valgrind
---
 Makefile.am       |   4 +-
 unit/test-avrcp.c | 395 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 398 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 475a344c713d..f0028cfb39f8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -674,7 +674,9 @@ unit_tests += unit/test-avrcp
 unit_test_avrcp_SOURCES = unit/test-avrcp.c \
 				src/log.h src/log.c \
 				unit/avctp.c unit/avctp.h \
-				unit/avrcp-lib.c unit/avrcp-lib.h
+				unit/avrcp-lib.c unit/avrcp-lib.h \
+				profiles/audio/avrcp-parse.h \
+				profiles/audio/avrcp-parse.c
 unit_test_avrcp_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 7bed8fbaf74a..e0c8971514ba 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -30,6 +30,7 @@
 
 #include "unit/avctp.h"
 #include "unit/avrcp-lib.h"
+#include "profiles/audio/avrcp-parse.h"
 
 struct test_pdu {
 	bool valid;
@@ -986,6 +987,398 @@ static void test_client(gconstpointer data)
 		avrcp_send_passthrough(context->session, 0, AVC_FAST_FORWARD);
 }
 
+/*
+ * Robustness tests for the controller side response parsers.
+ *
+ * These call the parsers directly rather than going through the AVCTP
+ * harness, since responses are what the peer controls and the parsers are
+ * what has to survive them. Each PDU is copied into a buffer of exactly its
+ * size, so that reading past the end of it is an out-of-bounds access rather
+ * than a read of whatever the receive buffer happened to hold before.
+ */
+
+struct robustness_test {
+	char *test_name;
+	uint8_t *data;
+	size_t size;
+	/* Expected result, or -1 if the PDU must be rejected */
+	int expected;
+};
+
+#define define_robustness_test(name, function, exp, args...)		\
+	do {								\
+		static struct robustness_test rt;			\
+		rt.test_name = g_strdup(name);				\
+		rt.data = util_memdup(data(args), sizeof(data(args)));	\
+		rt.size = sizeof(data(args));				\
+		rt.expected = exp;					\
+		tester_add(name, &rt, NULL, function, NULL);		\
+	} while (0)
+
+/* AVRCP header: BT SIG company id, pdu id, packet type, parameters length */
+#define AVRCP_HDR(pdu_id, len)						\
+	0x00, 0x19, 0x58, pdu_id, 0x00, ((len) >> 8) & 0xff, (len) & 0xff
+
+#define X4	'x', 'x', 'x', 'x'
+#define X16	X4, X4, X4, X4
+#define X64	X16, X16, X16, X16
+#define X256	X64, X64, X64, X64
+#define LONG_NAME_260	X256, X4
+
+static void robustness_result(struct robustness_test *rt, void *buf,
+								int result)
+{
+	free(buf);
+
+	if (result != rt->expected) {
+		tester_warn("%s: expected %d, got %d", rt->test_name,
+							rt->expected, result);
+		tester_test_failed();
+		return;
+	}
+
+	tester_test_passed();
+}
+
+static void *robustness_iov(const struct robustness_test *rt,
+							struct iovec *iov)
+{
+	iov->iov_base = util_memdup(rt->data, rt->size);
+	iov->iov_len = rt->size;
+
+	return iov->iov_base;
+}
+
+/* Expected is the number of parameter bytes left, or -1 if rejected */
+static void test_pull_header(gconstpointer data)
+{
+	struct robustness_test *rt = (void *) data;
+	struct iovec iov;
+	void *buf = robustness_iov(rt, &iov);
+
+	if (!avrcp_pull_header(&iov)) {
+		robustness_result(rt, buf, -1);
+		return;
+	}
+
+	robustness_result(rt, buf, iov.iov_len);
+}
+
+static void test_pull_browsing_header(gconstpointer data)
+{
+	struct robustness_test *rt = (void *) data;
+	struct iovec iov;
+	void *buf = robustness_iov(rt, &iov);
+
+	if (!avrcp_pull_browsing_header(&iov)) {
+		robustness_result(rt, buf, -1);
+		return;
+	}
+
+	robustness_result(rt, buf, iov.iov_len);
+}
+
+/*
+ * The attribute count declared by the peer is what bounds the write into
+ * attrs, so surround it with a guard and check that nothing was written
+ * past its end. Expected is the number of attributes accepted.
+ */
+#define ATTRS_GUARD 8
+
+static void test_player_attributes(gconstpointer data)
+{
+	struct robustness_test *rt = (void *) data;
+	uint8_t attrs[AVRCP_ATTRIBUTE_LAST + ATTRS_GUARD];
+	struct iovec iov;
+	void *buf = robustness_iov(rt, &iov);
+	uint8_t count;
+	int i;
+
+	memset(attrs, 0xaa, sizeof(attrs));
+
+	if (!avrcp_pull_header(&iov)) {
+		robustness_result(rt, buf, -1);
+		return;
+	}
+
+	count = avrcp_parse_player_attributes(&iov, attrs,
+						AVRCP_ATTRIBUTE_LAST);
+
+	for (i = 0; i < ATTRS_GUARD; i++) {
+		if (attrs[AVRCP_ATTRIBUTE_LAST + i] == 0xaa)
+			continue;
+
+		tester_warn("%s: wrote %u bytes past the end of attrs",
+					rt->test_name, ATTRS_GUARD - i);
+		free(buf);
+		tester_test_failed();
+		return;
+	}
+
+	robustness_result(rt, buf, count);
+}
+
+static void count_attribute(const struct avrcp_attribute *attr,
+							void *user_data)
+{
+	unsigned int *count = user_data;
+	unsigned int sum = 0;
+	uint16_t i;
+
+	/* Read the whole value so that a bogus length is caught */
+	for (i = 0; i < attr->len; i++)
+		sum += attr->value[i];
+
+	(void) sum;
+
+	(*count)++;
+}
+
+/* Expected is the number of attributes reported */
+static void test_attribute_list(gconstpointer data)
+{
+	struct robustness_test *rt = (void *) data;
+	struct iovec iov;
+	void *buf = robustness_iov(rt, &iov);
+	unsigned int count = 0;
+	uint8_t number;
+
+	if (!avrcp_pull_header(&iov) || !util_iov_pull_u8(&iov, &number)) {
+		robustness_result(rt, buf, -1);
+		return;
+	}
+
+	avrcp_parse_attribute_list(&iov, number, count_attribute, &count);
+
+	robustness_result(rt, buf, count);
+}
+
+/* Expected is the declared attribute count, or -1 if rejected */
+static void test_media_element(gconstpointer data)
+{
+	struct robustness_test *rt = (void *) data;
+	struct iovec iov;
+	void *buf = robustness_iov(rt, &iov);
+	struct avrcp_media_element element;
+
+	if (!avrcp_parse_media_element(&iov, &element)) {
+		robustness_result(rt, buf, -1);
+		return;
+	}
+
+	/* The name must always be truncated to fit */
+	if (strlen(element.name) >= NAME_MAX_LEN) {
+		tester_warn("%s: name not truncated", rt->test_name);
+		free(buf);
+		tester_test_failed();
+		return;
+	}
+
+	robustness_result(rt, buf, element.count);
+}
+
+/* Expected is the playable flag, or -1 if rejected */
+static void test_media_folder(gconstpointer data)
+{
+	struct robustness_test *rt = (void *) data;
+	struct iovec iov;
+	void *buf = robustness_iov(rt, &iov);
+	struct avrcp_media_folder folder;
+
+	if (!avrcp_parse_media_folder(&iov, &folder)) {
+		robustness_result(rt, buf, -1);
+		return;
+	}
+
+	if (strlen(folder.name) >= NAME_MAX_LEN) {
+		tester_warn("%s: name not truncated", rt->test_name);
+		free(buf);
+		tester_test_failed();
+		return;
+	}
+
+	robustness_result(rt, buf, folder.playable);
+}
+
+static void define_robustness_tests(void)
+{
+	/*
+	 * Responses do not go through handle_vendordep_pdu(), so nothing
+	 * validated the declared parameters length against the number of
+	 * bytes actually received.
+	 */
+
+	/* One byte short of a complete header */
+	define_robustness_test("/robustness/header/short",
+			test_pull_header, -1,
+			0x00, 0x19, 0x58, 0x10, 0x00, 0x00);
+
+	/* Declares 16 parameter bytes but carries one */
+	define_robustness_test("/robustness/header/truncated",
+			test_pull_header, -1,
+			AVRCP_HDR(0x10, 16), 0x04);
+
+	/* Declares fewer parameter bytes than were received */
+	define_robustness_test("/robustness/header/overlong",
+			test_pull_header, -1,
+			AVRCP_HDR(0x10, 1), 0x04, 0x01, 0x02);
+
+	define_robustness_test("/robustness/header/valid",
+			test_pull_header, 2,
+			AVRCP_HDR(0x10, 2), 0x01, 0x04);
+
+	define_robustness_test("/robustness/browsing-header/short",
+			test_pull_browsing_header, -1,
+			0x71, 0x00);
+
+	/* Declares 32 parameter bytes but carries one */
+	define_robustness_test("/robustness/browsing-header/truncated",
+			test_pull_browsing_header, -1,
+			0x71, 0x00, 0x20, 0x04);
+
+	define_robustness_test("/robustness/browsing-header/valid",
+			test_pull_browsing_header, 2,
+			0x71, 0x00, 0x02, 0x04, 0x01);
+
+	/*
+	 * ListPlayerApplicationSettingAttributes response, see
+	 * GHSA-m2vx-pw5f-rc8v. The declared count is what bounds the write
+	 * into a four byte array.
+	 */
+
+	/* Declares and carries 255 valid attributes */
+	define_robustness_test("/robustness/player-attributes/overflow",
+			test_player_attributes, AVRCP_ATTRIBUTE_LAST,
+			AVRCP_HDR(0x11, 21), 0xff,
+			0x01, 0x02, 0x03, 0x04, 0x01, 0x02, 0x03, 0x04,
+			0x01, 0x02, 0x03, 0x04, 0x01, 0x02, 0x03, 0x04,
+			0x01, 0x02, 0x03, 0x04);
+
+	/* Declares four attributes but carries two */
+	define_robustness_test("/robustness/player-attributes/truncated",
+			test_player_attributes, 2,
+			AVRCP_HDR(0x11, 3), 0x04, 0x01, 0x02);
+
+	/* Declares one attribute but carries none */
+	define_robustness_test("/robustness/player-attributes/empty",
+			test_player_attributes, 0,
+			AVRCP_HDR(0x11, 1), 0x01);
+
+	/* Illegal and out of range attributes must be skipped */
+	define_robustness_test("/robustness/player-attributes/illegal",
+			test_player_attributes, 1,
+			AVRCP_HDR(0x11, 5), 0x04,
+			AVRCP_ATTRIBUTE_ILLEGAL, 0x7f,
+			AVRCP_ATTRIBUTE_SHUFFLE, 0xff);
+
+	/*
+	 * GetElementAttributes and GetItemAttributes carry variable length
+	 * attribute values which were never bounds checked.
+	 */
+
+	/* Declares a 0xFFFF byte value with none of it present */
+	define_robustness_test("/robustness/attribute-list/huge-len",
+			test_attribute_list, 0,
+			AVRCP_HDR(0x20, 9), 0x01,
+			0x00, 0x00, 0x00, 0x01,		/* Title */
+			0x00, 0x6a,			/* UTF-8 */
+			0xff, 0xff);			/* value length */
+
+	/* Declares a four byte value but carries two */
+	define_robustness_test("/robustness/attribute-list/truncated-value",
+			test_attribute_list, 0,
+			AVRCP_HDR(0x20, 11), 0x01,
+			0x00, 0x00, 0x00, 0x01,
+			0x00, 0x6a,
+			0x00, 0x04,
+			'a', 'b');
+
+	/* Declares one attribute but carries a partial header for it */
+	define_robustness_test("/robustness/attribute-list/truncated-header",
+			test_attribute_list, 0,
+			AVRCP_HDR(0x20, 4), 0x01,
+			0x00, 0x00, 0x00);
+
+	/* Declares 255 attributes but carries one */
+	define_robustness_test("/robustness/attribute-list/count-overrun",
+			test_attribute_list, 1,
+			AVRCP_HDR(0x20, 12), 0xff,
+			0x00, 0x00, 0x00, 0x01,
+			0x00, 0x6a,
+			0x00, 0x03,
+			'a', 'b', 'c');
+
+	define_robustness_test("/robustness/attribute-list/valid",
+			test_attribute_list, 2,
+			AVRCP_HDR(0x20, 18), 0x02,
+			0x00, 0x00, 0x00, 0x01,
+			0x00, 0x6a,
+			0x00, 0x01, 'a',
+			0x00, 0x00, 0x00, 0x02,
+			0x00, 0x6a,
+			0x00, 0x00);
+
+	/* Media element and folder entries of a GetFolderItems response */
+
+	/* UID, media type and character set only, no name length */
+	define_robustness_test("/robustness/media-element/truncated",
+			test_media_element, -1,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+			0x02, 0x00, 0x6a);
+
+	/* Declares a 0xFFFF byte name with none of it present */
+	define_robustness_test("/robustness/media-element/huge-name",
+			test_media_element, -1,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+			0x02, 0x00, 0x6a,
+			0xff, 0xff);
+
+	/*
+	 * The name is complete but the attribute count byte that follows it
+	 * is not present. This is the off-by-one that used to read
+	 * operands[13 + namesize].
+	 */
+	define_robustness_test("/robustness/media-element/no-count",
+			test_media_element, -1,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+			0x02, 0x00, 0x6a,
+			0x00, 0x03, 'a', 'b', 'c');
+
+	/* A name longer than NAME_MAX_LEN must be truncated, not overflow */
+	define_robustness_test("/robustness/media-element/long-name",
+			test_media_element, 0,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+			0x02, 0x00, 0x6a,
+			0x01, 0x04,	/* 260 byte name */
+			LONG_NAME_260,
+			0x00);
+
+	define_robustness_test("/robustness/media-element/valid",
+			test_media_element, 1,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2a,
+			0x02, 0x00, 0x6a,
+			0x00, 0x03, 'a', 'b', 'c',
+			0x01);
+
+	/* UID, folder type and playable flag only */
+	define_robustness_test("/robustness/media-folder/truncated",
+			test_media_folder, -1,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+			0x01, 0x01);
+
+	define_robustness_test("/robustness/media-folder/huge-name",
+			test_media_folder, -1,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+			0x01, 0x01, 0x00, 0x6a,
+			0xff, 0xff, 'a');
+
+	define_robustness_test("/robustness/media-folder/valid",
+			test_media_folder, 1,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07,
+			0x01, 0x01, 0x00, 0x6a,
+			0x00, 0x03, 'a', 'b', 'c');
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -2080,5 +2473,7 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, AVRCP_ABORT_CONTINUING,
 				0x00, 0x00, 0x00));
 
+	define_robustness_tests();
+
 	return tester_run();
 }
-- 
2.54.0

