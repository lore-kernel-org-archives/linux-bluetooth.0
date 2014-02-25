Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] unit/test_hfp_at: Add test cases for processing basic commands
Date: Tue, 25 Feb 2014 10:23:42 +0100
Message-Id: <1393320227-10931-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will test processing basic commands including S-parameter commands,
D-commands.
---
 unit/test-hfp-at.c | 252 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/unit/test-hfp-at.c b/unit/test-hfp-at.c
index 4374a70..9cb716d 100644
--- a/unit/test-hfp-at.c
+++ b/unit/test-hfp-at.c
@@ -33,6 +33,9 @@
 
 struct test_data {
 	const struct hfp_at_handler *handlers;
+	const char *process_data;
+	bool process_return_val;
+	enum hfp_cmd_type returned_type;
 };
 
 static void test_init(gconstpointer data)
@@ -46,9 +49,27 @@ static void test_init(gconstpointer data)
 	hfp_at_free(hfp_at);
 }
 
+static void test_process_data(gconstpointer data)
+{
+	struct hfp_at *hfp_at;
+	const struct test_data *test_data = data;
+	bool ret;
+
+	hfp_at = hfp_at_new(test_data->handlers);
+	g_assert(hfp_at != NULL);
+
+	ret = hfp_at_process_data(hfp_at, test_data->process_data,
+							(void *)test_data);
+	g_assert(ret == test_data->process_return_val);
+
+	hfp_at_free(hfp_at);
+}
+
 static void process_generic(struct hfp_at *hfp_at, enum hfp_cmd_type type,
 						const char *at, void *user_data)
 {
+	struct test_data *test_data = user_data;
+	g_assert(type == test_data->returned_type);
 }
 
 const struct hfp_at_handler handlers_1[] = {};
@@ -62,8 +83,63 @@ const struct hfp_at_handler handlers_2[] = {
 
 const struct hfp_at_handler handlers_3[] = {
 	{
+		.prefix = NULL,
+		.cb = process_generic
+	},
+	{
 		.prefix = "+BRSF",
 		.cb = process_generic
+	}
+};
+
+const struct hfp_at_handler handlers_4[] = {
+	{
+		.prefix = "S12",
+		.cb = process_generic
+	},
+	{
+		.prefix = NULL,
+		.cb = process_generic
+	}
+};
+
+const struct hfp_at_handler handlers_5[] = {
+	{
+		.prefix = "S12",
+		.cb = process_generic
+	},
+	{
+		.prefix = NULL,
+		.cb = process_generic
+	}
+};
+
+const struct hfp_at_handler handlers_6[] = {
+	{
+		.prefix = "D",
+		.cb = process_generic
+	},
+	{
+		.prefix = NULL,
+		.cb = process_generic
+	}
+};
+
+const struct hfp_at_handler handlers_7[] = {
+	{
+		.prefix = "&A",
+		.cb = process_generic
+	},
+	{
+		.prefix = NULL,
+		.cb = process_generic
+	}
+};
+
+const struct hfp_at_handler handlers_8[] = {
+	{
+		.prefix = "A",
+		.cb = process_generic
 	},
 	{
 		.prefix = NULL,
@@ -83,6 +159,136 @@ const struct test_data data_3 = {
 	.handlers = handlers_3,
 };
 
+const struct test_data prefix_S_1_data = {
+	.handlers = handlers_4,
+	.process_data = "ATS12=12,6",
+	.process_return_val = true,
+	.returned_type = HFP_AT_SET
+};
+
+const struct test_data prefix_S_2_data = {
+	.handlers = handlers_4,
+	.process_data = "ATS12=?12,6",
+	.process_return_val = true,
+	.returned_type = HFP_AT_TEST
+};
+
+const struct test_data prefix_S_3_data = {
+	.handlers = handlers_4,
+	.process_data = "ATS12?",
+	.process_return_val = true,
+	.returned_type = HFP_AT_READ
+};
+
+const struct test_data prefix_S_4_data = {
+	.handlers = handlers_4,
+	.process_data = "ATS12",
+	.process_return_val = true,
+	.returned_type = HFP_AT_COMMAND
+};
+
+const struct test_data prefix_S_5_data = {
+	.handlers = handlers_5,
+	.process_data = "ATS1",
+	.process_return_val = true,
+	.returned_type = HFP_AT_UNKNOWN
+};
+
+const struct test_data prefix_D_1_data = {
+	.handlers = handlers_5,
+	.process_data = "ATD0046131415",
+	.process_return_val = true,
+	.returned_type = HFP_AT_UNKNOWN
+};
+
+const struct test_data prefix_D_2_data = {
+	.handlers = handlers_6,
+	.process_data = "ATD0046131415",
+	.process_return_val = true,
+	.returned_type = HFP_AT_SET
+};
+
+const struct test_data prefix_D_3_data = {
+	.handlers = handlers_2,
+	.process_data = "ATD0046131415",
+	.process_return_val = true,
+	.returned_type = HFP_AT_UNKNOWN
+};
+
+const struct test_data prefix_anda_1_data = {
+	.handlers = handlers_7,
+	.process_data = "AT&A=12",
+	.process_return_val = true,
+	.returned_type = HFP_AT_SET
+};
+
+const struct test_data prefix_anda_2_data = {
+	.handlers = handlers_7,
+	.process_data = "AT&A=?12",
+	.process_return_val = true,
+	.returned_type = HFP_AT_TEST
+};
+
+const struct test_data prefix_anda_3_data = {
+	.handlers = handlers_7,
+	.process_data = "AT&A?12",
+	.process_return_val = true,
+	.returned_type = HFP_AT_READ
+};
+
+const struct test_data prefix_anda_4_data = {
+	.handlers = handlers_7,
+	.process_data = "AT&A",
+	.process_return_val = true,
+	.returned_type = HFP_AT_COMMAND
+};
+
+const struct test_data prefix_a_1_data = {
+	.handlers = handlers_8,
+	.process_data = "ATA",
+	.process_return_val = true,
+	.returned_type = HFP_AT_COMMAND
+};
+
+const struct test_data prefix_a_2_data = {
+	.handlers = handlers_8,
+	.process_data = "ATA=12",
+	.process_return_val = true,
+	.returned_type = HFP_AT_SET
+};
+
+const struct test_data prefix_a_3_data = {
+	.handlers = handlers_8,
+	.process_data = "ATA=?12",
+	.process_return_val = true,
+	.returned_type = HFP_AT_TEST
+};
+
+const struct test_data prefix_a_4_data = {
+	.handlers = handlers_8,
+	.process_data = "ATA?",
+	.process_return_val = true,
+	.returned_type = HFP_AT_READ
+};
+
+const struct test_data invalid_command_1_data = {
+	.handlers = handlers_2,
+	.process_data = "AYA?",
+	.process_return_val = false,
+};
+
+const struct test_data invalid_command_2_data = {
+	.handlers = handlers_2,
+	.process_data = "AT?",
+	.process_return_val = false,
+};
+
+const struct test_data invalid_command_3_data = {
+	.handlers = handlers_2,
+	.process_data = "AT",
+	.process_return_val = false,
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -90,6 +296,52 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/hfp_at/init_1", &data_1, test_init);
 	g_test_add_data_func("/hfp_at/init_2", &data_2, test_init);
 	g_test_add_data_func("/hfp_at/init_3", &data_3, test_init);
+	/* Basic commands tests */
+	g_test_add_data_func("/hfp_at/prefix_S_1", &prefix_S_1_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_S_2", &prefix_S_2_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_S_3", &prefix_S_3_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_S_4", &prefix_S_4_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_S_5", &prefix_S_5_data,
+							test_process_data);
+
+	g_test_add_data_func("/hfp_at/prefix_D_1", &prefix_D_1_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_D_2", &prefix_D_2_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_D_3", &prefix_D_3_data,
+							test_process_data);
+
+	g_test_add_data_func("/hfp_at/prefix_&A_1", &prefix_anda_1_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_&A_2", &prefix_anda_2_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_&A_3", &prefix_anda_3_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_&A_4", &prefix_anda_4_data,
+							test_process_data);
+
+	g_test_add_data_func("/hfp_at/prefix_A_1", &prefix_a_1_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_A_1", &prefix_a_2_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_A_1", &prefix_a_3_data,
+							test_process_data);
+	g_test_add_data_func("/hfp_at/prefix_A_1", &prefix_a_4_data,
+							test_process_data);
+
+	g_test_add_data_func("/hfp_at/invalid_command_1",
+					&invalid_command_1_data,
+					test_process_data);
+	g_test_add_data_func("/hfp_at/invalid_command_2",
+					&invalid_command_2_data,
+					test_process_data);
+	g_test_add_data_func("/hfp_at/invalid_command_3",
+					&invalid_command_3_data,
+					test_process_data);
 
 	return g_test_run();
 }
-- 
1.8.5.3

