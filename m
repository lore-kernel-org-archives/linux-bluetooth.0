Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/11] android/test: Add HAL IPC command tests
Date: Tue, 19 Aug 2014 21:51:11 +0200
Message-Id: <1408477872-24160-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
References: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/test-hal-ipc.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/android/test-hal-ipc.c b/android/test-hal-ipc.c
index 44485c4..0a858ee 100644
--- a/android/test-hal-ipc.c
+++ b/android/test-hal-ipc.c
@@ -307,6 +307,161 @@ static void test_reconnect_stress(const void *data)
 		test_reconnect(data);
 }
 
+struct test_cmd_data {
+	uint8_t service_id;
+	uint8_t opcode;
+
+	uint16_t len;
+	const void *param;
+
+	size_t rsp_len;
+	const void *rsp;
+};
+
+static void signal_action(int sig)
+{
+}
+
+static void wait_for_signal(void)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = signal_action;
+	sigaction(SIGUSR1, &sa, NULL);
+	sigaction(SIGALRM, &sa, NULL);
+
+	alarm(5);
+
+	pause();
+}
+
+static int handle_cmd(const void *data)
+{
+	const struct test_cmd_data *cdata = data;
+	char buf[100];
+	struct ipc_hdr *hdr = (void *) buf;
+	int ret;
+	int result = 0;
+
+	ret = read(cmd_sk, buf, sizeof(buf));
+	if (ret != cdata->len + (int) sizeof(*hdr))
+		result = 1;
+
+	if (hdr->opcode != cdata->opcode)
+		result = 2;
+
+	if (hdr->service_id != cdata->service_id)
+		result = 3;
+
+	if (memcmp(hdr->payload, cdata->param, hdr->len))
+		result = 4;
+
+	memcpy(hdr->payload, cdata->rsp, cdata->rsp_len);
+	hdr->len = cdata->rsp_len;
+
+	write(cmd_sk, hdr, sizeof(*hdr) + hdr->len);
+
+	return result;
+}
+
+static void send_cmd(const void *data)
+{
+	const struct test_cmd_data *cdata = data;
+	char buf[100];
+	char *rsp;
+	size_t rsp_len;
+
+	rsp = cdata->rsp_len ? buf : NULL;
+	rsp_len = cdata->rsp_len;
+
+	g_assert(hal_ipc_cmd(cdata->service_id, cdata->opcode, cdata->len,
+				cdata->param, &rsp_len, rsp,
+				NULL) == IPC_STATUS_SUCCESS);
+
+	g_assert(cdata->rsp_len == rsp_len);
+	if (cdata->rsp_len)
+		g_assert(memcmp(cdata->rsp, rsp, cdata->rsp_len) == 0);
+}
+
+static void cmd_cb(void *data)
+{
+	g_assert(FALSE);
+}
+
+static void test_command(const void *data)
+{
+	pid_t pid;
+	int status;
+
+	cleanup_hal();
+
+	g_assert(hal_ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH)));
+	hal_ipc_set_disconnect_cb(cmd_cb, NULL);
+
+	pid = fork();
+	if (pid == 0) {
+		int ret;
+
+		connect_hal();
+		ret = handle_cmd(data);
+		wait_for_signal();
+		exit(ret);
+	}
+
+	g_assert(pid > 0);
+
+	g_assert(hal_ipc_accept());
+
+	send_cmd(data);
+
+	hal_ipc_cleanup();
+
+	kill(pid, SIGUSR1);
+	wait(&status);
+
+	g_assert(status == 0);
+}
+
+static const char cmd_data[] = { 0x01, 0x02, 0x03, 0x04 };
+static const char rsp_data[] = { 0x06, 0x07 };
+
+static const struct test_cmd_data cmd1 = {
+	.service_id = 1,
+	.opcode = 2,
+	.len = 0,
+	.param = NULL,
+	.rsp_len = 0,
+	.rsp = NULL,
+};
+
+static const struct test_cmd_data cmd2 = {
+	.service_id = 1,
+	.opcode = 2,
+	.len = sizeof(cmd_data),
+	.param = cmd_data,
+	.rsp_len = 0,
+	.rsp = NULL,
+};
+
+static const struct test_cmd_data cmd3 = {
+	.service_id = 1,
+	.opcode = 2,
+	.len = sizeof(cmd_data),
+	.param = cmd_data,
+	.rsp_len = sizeof(rsp_data),
+	.rsp = rsp_data,
+};
+
+static const struct test_cmd_data cmd4 = {
+	.service_id = 1,
+	.opcode = 2,
+	.len = 0,
+	.param = NULL,
+	.rsp_len = sizeof(rsp_data),
+	.rsp = rsp_data,
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -333,6 +488,10 @@ int main(int argc, char *argv[])
 							test_reconnect);
 	g_test_add_data_func("/android_hal_ipc/reconnect2_stress",
 					(void *) false, test_reconnect_stress);
+	g_test_add_data_func("/android_hal_ipc/command1", &cmd1, test_command);
+	g_test_add_data_func("/android_hal_ipc/command2", &cmd2, test_command);
+	g_test_add_data_func("/android_hal_ipc/command3", &cmd3, test_command);
+	g_test_add_data_func("/android_hal_ipc/command4", &cmd4, test_command);
 
 	return g_test_run();
 }
-- 
1.9.3

