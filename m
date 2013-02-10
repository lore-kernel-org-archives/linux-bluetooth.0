Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 13/13] unit: Add tests for sdp_get_server_ver()
Date: Sun, 10 Feb 2013 17:26:37 -0400
Message-Id: <1360531597-3506-14-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-sdp-lib.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/unit/test-sdp-lib.c b/unit/test-sdp-lib.c
index 346942f..a7480c3 100644
--- a/unit/test-sdp-lib.c
+++ b/unit/test-sdp-lib.c
@@ -387,6 +387,53 @@ static void test_profile_desc_workaround(void)
 	sdp_record_free(rec);
 }
 
+static void test_server_ver(void)
+{
+	uint16_t u16 = 0x1234;
+	uint32_t u32 = 0xdeadbeeb;
+	uint8_t dtd1 = SDP_UINT16, dtd2 = SDP_UINT32;
+	void *dtds1[] = { &dtd1 };
+	void *values1[] = { &u16 };
+	void *dtds2[] = { &dtd2 };
+	void *values2[] = { &u32 };
+	sdp_record_t *rec;
+	sdp_data_t *data;
+	sdp_list_t *list;
+	int err;
+
+	rec = sdp_record_alloc();
+
+	err = sdp_get_server_ver(rec, &list);
+	g_assert(err == -1 && errno == ENODATA);
+
+	/* Valid DTD */
+	data = sdp_seq_alloc(dtds1, values1, 1);
+	sdp_attr_add(rec, SDP_ATTR_VERSION_NUM_LIST, data);
+	err = sdp_get_server_ver(rec, &list);
+	g_assert(err == 0 && list != NULL);
+	sdp_list_free(list, NULL);
+
+	/* Invalid: UINT32 */
+	data = sdp_data_alloc(SDP_UINT32, &u32);
+	sdp_attr_replace(rec, SDP_ATTR_VERSION_NUM_LIST, data);
+	err = sdp_get_server_ver(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* Invalid: SEQ8() */
+	data = sdp_seq_alloc(NULL, NULL, 0);
+	sdp_attr_replace(rec, SDP_ATTR_VERSION_NUM_LIST, data);
+	err = sdp_get_server_ver(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* Invalid: SEQ8(UINT32) */
+	data = sdp_seq_alloc(dtds2, values2, 1);
+	sdp_attr_replace(rec, SDP_ATTR_VERSION_NUM_LIST, data);
+	err = sdp_get_server_ver(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	sdp_record_free(rec);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -417,5 +464,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/sdp/lib/profile_desc/workaround",
 						test_profile_desc_workaround);
 
+	g_test_add_func("/sdp/lib/server_ver", test_server_ver);
+
 	return g_test_run();
 }
-- 
1.7.9.5

