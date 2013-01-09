Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 3/3] unit: Implement tests for sdp_extract_attr()
Date: Wed,  9 Jan 2013 11:19:22 -0400
Message-Id: <1357744762-5111-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357744762-5111-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357744762-5111-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These tests are for valid data. Other tests might be added later to
check for error paths, but will require separate macros.

As example of failure output, if commit
504a0cf46ad89cab8005ce9cffb22e41048f6a30 is reverted for testing, the
STR16 test will fail with:

ERROR:unit/test-sdp.c:776:test_sdp_de_attr: assertion failed
(test->input_size == size): (7 == 11)
---
 unit/test-sdp.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 77a4c6c..d511ef4 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -85,6 +85,29 @@ struct test_data {
 #define define_ssa(name, args...) define_test("/TP/SERVER/SSA/" name, 48, args)
 #define define_brw(name, args...) define_test("/TP/SERVER/BRW/" name, 672, args)
 
+/* SDP Data Element (DE) tests */
+struct test_data_de {
+	const void *input_data;
+	size_t input_size;
+	sdp_data_t expected;
+};
+
+#define exp_data(_dtd, val_type, val_data) \
+	((const sdp_data_t) {			\
+		.dtd = _dtd,			\
+		.val.val_type = val_data,	\
+	})
+
+#define define_test_de_attr(name, input, exp) \
+	do {								\
+		static struct test_data_de data;			\
+		data.input_data = input;				\
+		data.input_size = sizeof(input);			\
+		data.expected = exp;					\
+		g_test_add_data_func("/sdp/DE/ATTR/" name, &data,	\
+						test_sdp_de_attr);	\
+	} while (0)
+
 struct context {
 	GMainLoop *main_loop;
 	guint server_source;
@@ -742,6 +765,35 @@ static void test_sdp(gconstpointer data)
 	g_free(test->pdu_list);
 }
 
+static void test_sdp_de_attr(gconstpointer data)
+{
+	const struct test_data_de *test = data;
+	sdp_data_t *d;
+	int size = 0;
+
+	d = sdp_extract_attr(test->input_data, test->input_size, &size, NULL);
+	g_assert(d != NULL);
+	g_assert_cmpuint(test->input_size, ==, size);
+	g_assert_cmpuint(test->expected.dtd, ==, d->dtd);
+
+	if (g_test_verbose() == TRUE)
+		g_print("DTD=0x%02x\n", d->dtd);
+
+	switch (d->dtd) {
+	case SDP_TEXT_STR8:
+	case SDP_TEXT_STR16:
+	case SDP_URL_STR8:
+	case SDP_URL_STR16:
+		g_assert_cmpstr(test->expected.val.str, ==, d->val.str);
+		break;
+	/* TODO: implement other DTDs here */
+	default:
+		g_assert_not_reached();
+	}
+
+	sdp_data_free(d);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -2697,5 +2749,18 @@ int main(int argc, char *argv[])
 			0x08, 0x09, 0x00, 0x01, 0x35, 0x03, 0x19, 0x11,
 			0x06, 0x00));
 
+	/*
+	 * SDP Data Element (DE) tests
+	 *
+	 * Test extraction of valid DEs supported by sdp_extract_attr().
+	 */
+	define_test_de_attr("STR8",
+			raw_data(0x25, 0x04, 0x41, 0x42, 0x43, 0x44),
+			exp_data(SDP_TEXT_STR8, str, "ABCD"));
+	define_test_de_attr("STR16",
+			raw_data(0x26, 0x00, 0x04, 0x41, 0x42, 0x43, 0x44),
+			exp_data(SDP_TEXT_STR16, str, "ABCD"));
+	/* TODO: implement other tests for valid DEs */
+
 	return g_test_run();
 }
-- 
1.7.9.5

