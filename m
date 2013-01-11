Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] unit: Add tests for SDP integer Data Elements
Date: Thu, 10 Jan 2013 21:22:02 -0400
Message-Id: <1357867322-31384-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357867322-31384-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357867322-31384-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SDP_DATA_NIL does not have a value, but its sdp_data_t val field is
zeroed by memset(), so just treat it as UINT8 with zero value to
simplify checking (and not require a separate macro.)

SDP_BOOL is handled by SDP library as a INT8.

SDP_UINT128/SDP_INT128 are just byte arrays converted to host order, so
use memcmp() to compare them (converting from host to network order
first.)
---
 unit/test-sdp.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 7879e58..8c0ce98 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -52,6 +52,7 @@ struct test_data {
 };
 
 #define raw_data(args...) ((const unsigned char[]) { args })
+#define build_u128(args...) ((const uint128_t) { .data = { args } })
 
 #define raw_pdu(args...) \
 	{							\
@@ -768,6 +769,7 @@ static void test_sdp(gconstpointer data)
 static void test_sdp_de_attr(gconstpointer data)
 {
 	const struct test_data_de *test = data;
+	uint128_t u128;
 	sdp_data_t *d;
 	int size = 0;
 
@@ -786,6 +788,39 @@ static void test_sdp_de_attr(gconstpointer data)
 	case SDP_URL_STR16:
 		g_assert_cmpstr(test->expected.val.str, ==, d->val.str);
 		break;
+	case SDP_DATA_NIL:
+	case SDP_UINT8:
+		g_assert_cmpuint(test->expected.val.uint8, ==, d->val.uint8);
+		break;
+	case SDP_UINT16:
+		g_assert_cmpuint(test->expected.val.uint16, ==, d->val.uint16);
+		break;
+	case SDP_UINT32:
+		g_assert_cmpuint(test->expected.val.uint32, ==, d->val.uint32);
+		break;
+	case SDP_UINT64:
+		g_assert_cmpuint(test->expected.val.uint64, ==, d->val.uint64);
+		break;
+	case SDP_BOOL:
+	case SDP_INT8:
+		g_assert_cmpuint(test->expected.val.int8, ==, d->val.int8);
+		break;
+	case SDP_INT16:
+		g_assert_cmpuint(test->expected.val.int16, ==, d->val.int16);
+		break;
+	case SDP_INT32:
+		g_assert_cmpuint(test->expected.val.int32, ==, d->val.int32);
+		break;
+	case SDP_INT64:
+		g_assert_cmpuint(test->expected.val.int64, ==, d->val.int64);
+		break;
+	case SDP_UINT128:
+	case SDP_INT128:
+		/* Expected bytes are in network order */
+		hton128(&d->val.uint128, &u128);
+		g_assert(memcmp(&test->expected.val.uint128, &u128,
+						sizeof(uint128_t)) == 0);
+		break;
 	default:
 		g_assert_not_reached();
 	}
@@ -2774,6 +2809,55 @@ int main(int argc, char *argv[])
 				0x6c, 0x75, 0x65, 0x7a, 0x2e, 0x6f, 0x72, 0x67,
 				0x2f),
 			exp_data(SDP_URL_STR16, str, "http://www.bluez.org/"));
+	define_test_de_attr("NIL",
+			raw_data(0x00),
+			exp_data(SDP_DATA_NIL, uint8, 0));
+	define_test_de_attr("UINT8",
+			raw_data(0x08, 0xff),
+			exp_data(SDP_UINT8, uint8, UINT8_MAX));
+	define_test_de_attr("INT8",
+			raw_data(0x10, 0x80),
+			exp_data(SDP_INT8, int8, INT8_MIN));
+	define_test_de_attr("BOOL",
+			raw_data(0x28, 0x01),
+			exp_data(SDP_BOOL, int8, 1));
+	define_test_de_attr("UINT16",
+			raw_data(0x09, 0xff, 0xff),
+			exp_data(SDP_UINT16, uint16, UINT16_MAX));
+	define_test_de_attr("INT16",
+			raw_data(0x11, 0x80, 0x00),
+			exp_data(SDP_INT16, int16, INT16_MIN));
+	define_test_de_attr("UINT32",
+			raw_data(0x0A, 0xff, 0xff, 0xff, 0xff),
+			exp_data(SDP_UINT32, uint32, UINT32_MAX));
+	define_test_de_attr("INT32",
+			raw_data(0x12, 0x80, 0x00, 0x00, 0x00),
+			exp_data(SDP_INT32, int32, INT32_MIN));
+	define_test_de_attr("UINT64",
+			raw_data(0x0B, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+									0xff),
+			exp_data(SDP_UINT64, uint64, UINT64_MAX));
+	define_test_de_attr("INT64",
+			raw_data(0x13, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+									0x00),
+			exp_data(SDP_INT64, int64, INT64_MIN));
+	/* UINT128/INT128 are just byte arrays parsed as uint128_t */
+	define_test_de_attr("UINT128",
+			raw_data(0x0C, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+					0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+					0xff, 0xff, 0xff),
+			exp_data(SDP_UINT128, uint128,
+				build_u128(0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+						0xff, 0xff, 0xff, 0xff, 0xff,
+						0xff, 0xff, 0xff, 0xff, 0xff)));
+	define_test_de_attr("INT128",
+			raw_data(0x14, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					0x00, 0x00, 0x00),
+			exp_data(SDP_INT128, uint128,
+				build_u128(0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+						0x00, 0x00, 0x00, 0x00, 0x00,
+						0x00, 0x00, 0x00, 0x00, 0x00)));
 
 	return g_test_run();
 }
-- 
1.7.9.5

