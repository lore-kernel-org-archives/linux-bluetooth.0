Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 13/13] unit: Add tests for sdp_get_server_ver()
Date: Fri, 15 Feb 2013 11:07:56 -0400
Message-Id: <1360940876-6314-14-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
 <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-lib.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/unit/test-lib.c b/unit/test-lib.c
index a994dc2..def133a 100644
--- a/unit/test-lib.c
+++ b/unit/test-lib.c
@@ -388,6 +388,53 @@ static void test_sdp_get_profile_descs_workaround(void)
 	sdp_record_free(rec);
 }
 
+static void test_sdp_get_server_ver(void)
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
@@ -418,5 +465,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/lib/sdp_get_profile_descs/workaround",
 					test_sdp_get_profile_descs_workaround);
 
+	g_test_add_func("/lib/sdp_get_server_ver", test_sdp_get_server_ver);
+
 	return g_test_run();
 }
-- 
1.7.9.5

