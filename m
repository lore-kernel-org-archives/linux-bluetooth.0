Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F03C13E9
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602338; cv=none; b=trxHv0lismTBeZ7ibikYOr8tillVJ5LNi8/S60blP+XZRYL1qDBMxbnwuaa1F+IIaF7juzEaswi9T6nCnp6Fj7NCVclwHt/hlAyR0M22Hfr3QPSGzAJ8ONbUkER22tgxoCnsRL+cLUsUd/phG923LXwp61xOLfGT/WwwOcdGatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602338; c=relaxed/simple;
	bh=Y6GccGF21YfsWKFVWJ3HVZ20jgC6O8CWC703eWcFriQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgCzPrUReyxHbBYR4AIya37GTa2jibJSoxsvAdKPrgKa0KT9x9Zv7UkeIr+4jeNpndjZ5MO+ix3/HwlkKJwVu++eWFALHzai4p5EbvpP6sE/wiUr67VJ4QvA1TZHnlDCkRhQPb4oonJ6+RQkfr1aqlNXALXupjJdat6zaeGzgz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCgM8eSA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCgM8eSA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16bc7ac85so104075e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 20:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791602335; x=1792207135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O1YdoQYCniyfYU9kLAlzKplr5XmWGGB1MOnU2RVVEKY=;
        b=mCgM8eSAkPvWuq4aRrfe1UDFiOZ2mnSWTmcpBn9IUlUpK0OIgh3I70rc4PoVGxB2JX
         FEXfuqOULjAcSYeOJbgK/kz3p/8R/bvsSaZsfUXVBgUArEhtfeAvMwk+/HPWXJ7Qkida
         b80S5xpugY1oe899zodSoMzKfmrzbBuOsVTuItpG8Eo8HCKhBuuoRgm+hyjQTg/7wV7n
         bWuXTc8/XWSKElBNTg24sh+3USLhm9SDQpVKay3E59HQSzB0hbiToGM+PULqkSgRH8mQ
         VCHiRbJMIBNOqlng+2RdGnCdRQEfdpXwaH0kRVL0dR5zNfVBFi2r+wU9GVoq3KdMy2cM
         iseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602335; x=1792207135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=O1YdoQYCniyfYU9kLAlzKplr5XmWGGB1MOnU2RVVEKY=;
        b=EfXO//bHWhZ0TdkHwqRqIg2YLd7XcQ/WBBsMnr5j0kbfxi0ZO6+7VI+FsQeDo11kPP
         D2IP14RhALsAX0XSo8qgChKYOf0rYx/FpfYaMv9syNxbbcyIDVTfDV5JXR0A3wB/5y45
         Ljk7zoDFwlUnmFRKUU5WUvOI1H8K6OV0moQA+s8o2dXVe1ZGm/QjkpVANacmMxXRHuDB
         BjF8jjZNRH0eXJxf0cGC84LcQNlt16Ieq9ioPPEfytjUxs7PNfVIOs6EMt4Bu5iQJQ8D
         CIARFsJMB16qchVAiaXDNXC+3KgakAki12Cmi49sM/VnDOuPH9BPDlAebWK1cvvfD2n0
         gEEQ==
X-Gm-Message-State: AFq9FYJRwNjoXhUU5T6Qfb+GIDKxyWZMAls1mf0PGIC/uTsVkC8vXn1A
	72+z1wsYKL6SRSbkuAYIRMgMbVCGA8iUtdnRgyaDhOB6KMdwW6xrGOhixcZ232q34No=
X-Gm-Gg: AYBFou1SMS+TcqDSW94BmV6MJ0O9Tu5uwKC9ozVn2OdxMEKS4zdgzK2/AykNz33C4uu
	NqAI2PvrMq5vcVG7fYSJQK8a4YwQqapLqV7ScyQYQjQLchWMtOFSnbLTdoOQGyX0o79S1etG+78
	XKwKlro1aBpb5PL+xS0lQD5rHMjSHpgoov+36vlJjVOW2iSTmi1gb2o6naz8AUtEbR4/Lg/VioM
	Orov3Sv45HnB/XKT+Bar7BMrKOebse6rwTWjD/tvIfvAcFieuv60rET37ZQchRzSg49nyHBpXhT
	w/BZZXJ3ugDMSCfC8coyAiT7q7BS1qk4NtYRXaLRMdLRcygkSVMhvX0/X/7cc0bC6Zlv2c4JBdT
	+E4ra37YxCHvJJjE/X/lVfLGlIniG4m/uStdL7oaa6AcRr3jbiDK4Op3UB4+No0wQ69xaQwy9Yi
	C2XTQ1+ZadAk30KbWRs4u29AwTNw5A5rB0CcWvDrUNyu5rB6sCxe4NqDTkb907eER58XA8Q57/1
	0G0/dFj4zaEC5CMe8rrOxPsT8PbZGrS1tuePwTOaqpLc0GZuNR7ZoA=
X-Received: by 2002:a05:600c:4ecc:b0:4a1:7dcf:be1f with SMTP id 5b1f17b1804b1-4a18e476022mr78112855e9.1.1791602334577;
        Fri, 09 Oct 2026 20:18:54 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm110270805e9.10.2026.10.09.20.18.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:18:54 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] mgmt-tester: Add simultaneous discovery stop tests
Date: Sat, 10 Oct 2026 05:18:51 +0200
Message-ID: <20261010031852.2842893-4-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010031852.2842893-1-yaroslav.voytovych@gmail.com>
References: <20261010031852.2842893-1-yaroslav.voytovych@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With HCI_QUIRK_SIMULTANEOUS_DISCOVERY, kernels without commit
96d006ae6445 ("Bluetooth: hci_event: fix simultaneous discovery stuck
in FINDING") stay in DISCOVERY_FINDING when the Inquiry Complete event
arrives after LE Set Scan Enable (disable) was sent but before its
Command Complete: no Discovering (disabled) event is sent and every
later Start Discovery fails with Busy.

Both tests set the quirk through debugfs and send the Inquiry Complete
themselves: one second into the discovery (Simultaneous Inquiry First,
the normal order) or from the LE Set Scan Enable (disable) command
hook, before its Command Complete (Simultaneous Inquiry Late). The LE
scan timeout itself is not shortened. One second after that command a
new Start Discovery probes the state; a test fails if no Discovering
(disabled) event came before the probe or if the probe does not
succeed. Without the kernel fix the Late test fails. If the debugfs
entry cannot be opened, the tests are reported as Not Run.
---
 tools/mgmt-tester.c | 395 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 395 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 75a1431fd..992351e2e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -40,6 +40,19 @@
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
+#include "src/shared/timeout.h"
+
+struct simult_discovery {
+	bool during_scan_disable;
+	bool started;
+	bool stopped;
+	bool scan_disabled;
+	bool hooks;
+	unsigned int discov_id;
+	unsigned int power_off_id;
+	unsigned int inquiry_id;
+	unsigned int restart_id;
+};
 
 struct test_data {
 	tester_data_func_t test_setup;
@@ -64,6 +77,7 @@ struct test_data {
 	int unmet_conditions;
 	int unmet_setup_conditions;
 	int sk;
+	struct simult_discovery simult;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -73,10 +87,38 @@ static void print_debug(const char *str, void *user_data)
 	tester_print("%s%s", prefix, str);
 }
 
+static void simult_discovery_cleanup(struct test_data *data)
+{
+	struct simult_discovery *simult = &data->simult;
+
+	if (simult->power_off_id)
+		timeout_remove(simult->power_off_id);
+
+	if (simult->inquiry_id)
+		timeout_remove(simult->inquiry_id);
+
+	if (simult->restart_id)
+		timeout_remove(simult->restart_id);
+
+	if (simult->discov_id)
+		mgmt_unregister(data->mgmt, simult->discov_id);
+
+	if (simult->hooks) {
+		hciemu_del_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT,
+						BT_HCI_CMD_INQUIRY);
+		hciemu_del_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+					BT_HCI_CMD_LE_SET_SCAN_ENABLE);
+	}
+
+	memset(simult, 0, sizeof(*simult));
+}
+
 static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
+	simult_discovery_cleanup(data);
+
 	if (data->sk >= 0)
 		close(data->sk);
 
@@ -12241,6 +12283,352 @@ static void test_add_remove_device_nowait(const void *test_data)
 				command_generic_callback, NULL, NULL);
 }
 
+/* Simultaneous discovery: with HCI_QUIRK_SIMULTANEOUS_DISCOVERY the BR/EDR
+ * inquiry and the LE scan run together and the kernel's LE scan timeout
+ * ends the discovery. The emulator's own Inquiry Complete is suppressed and
+ * the test sends it either one second into the discovery (inquiry first) or
+ * between LE Set Scan Enable (disable) and its Command Complete (during scan
+ * disable). Either way Discovering (disabled) has to be sent and a new Start
+ * Discovery has to succeed.
+ */
+static bool simult_inquiry_complete(struct test_data *data, const char *when)
+{
+	struct btdev *btdev = vhci_get_btdev(hciemu_get_vhci(data->hciemu));
+	struct bt_hci_evt_inquiry_complete ev;
+
+	tester_print("Sending Inquiry Complete %s", when);
+
+	ev.status = BT_HCI_ERR_SUCCESS;
+
+	if (btdev_send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ev,
+							sizeof(ev)) < 0) {
+		tester_warn("Unable to send Inquiry Complete");
+		tester_test_failed();
+		return false;
+	}
+
+	return true;
+}
+
+static bool simult_inquiry_complete_early(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	data->simult.inquiry_id = 0;
+
+	simult_inquiry_complete(data, "before LE scan disable");
+
+	return false;
+}
+
+static void simult_restart_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	tester_print("Start Discovery after the LE scan timeout: %s (0x%02x)",
+						mgmt_errstr(status), status);
+
+	if (!data->simult.stopped) {
+		tester_warn("No Discovering (disabled) event before restart");
+		tester_test_failed();
+		return;
+	}
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_test_failed();
+		return;
+	}
+
+	tester_test_passed();
+}
+
+static bool simult_restart(void *user_data)
+{
+	struct test_data *data = user_data;
+	struct simult_discovery *simult = &data->simult;
+
+	simult->restart_id = 0;
+
+	/* Only Discovering events received up to here count */
+	mgmt_unregister(data->mgmt, simult->discov_id);
+	simult->discov_id = 0;
+
+	if (!mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
+				sizeof(start_discovery_bredrle_param),
+				start_discovery_bredrle_param,
+				simult_restart_callback, data, NULL)) {
+		tester_warn("Unable to send Start Discovery");
+		tester_test_failed();
+	}
+
+	return false;
+}
+
+static bool simult_inquiry_hook(const void *data, uint16_t len,
+							void *user_data)
+{
+	/* Command Status has been sent; skip the emulator's inquiry timers
+	 * so that the only Inquiry Complete is the one the test sends.
+	 */
+	return false;
+}
+
+static bool simult_scan_enable_hook(const void *param, uint16_t len,
+							void *user_data)
+{
+	const struct bt_hci_cmd_le_set_scan_enable *cmd = param;
+	struct test_data *data = user_data;
+	struct simult_discovery *simult = &data->simult;
+
+	if (len < sizeof(*cmd) || cmd->enable || !simult->started ||
+							simult->scan_disabled)
+		return true;
+
+	simult->scan_disabled = true;
+
+	tester_print("LE Set Scan Enable (disable) received");
+
+	if (simult->during_scan_disable &&
+			!simult_inquiry_complete(data,
+						"before its Command Complete"))
+		return true;
+
+	simult->restart_id = timeout_add_seconds(1, simult_restart, data, NULL);
+	if (!simult->restart_id) {
+		tester_warn("Unable to add restart timeout");
+		tester_test_failed();
+	}
+
+	return true;
+}
+
+static void simult_discovering(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_discovering *ev = param;
+	struct test_data *data = user_data;
+	struct simult_discovery *simult = &data->simult;
+
+	if (length != sizeof(*ev)) {
+		tester_warn("Incorrect discovering event length");
+		tester_test_failed();
+		return;
+	}
+
+	tester_print("Discovering: type 0x%02x %s", ev->type,
+				ev->discovering ? "enabled" : "disabled");
+
+	if (!ev->discovering) {
+		simult->stopped = true;
+		return;
+	}
+
+	if (simult->started)
+		return;
+
+	simult->started = true;
+
+	if (simult->during_scan_disable)
+		return;
+
+	simult->inquiry_id = timeout_add_seconds(1,
+					simult_inquiry_complete_early, data,
+					NULL);
+	if (!simult->inquiry_id) {
+		tester_warn("Unable to add Inquiry Complete timeout");
+		tester_test_failed();
+	}
+}
+
+static void simult_start_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	tester_print("Start Discovery: %s (0x%02x)", mgmt_errstr(status),
+									status);
+
+	if (status != MGMT_STATUS_SUCCESS)
+		tester_test_failed();
+}
+
+static void simult_quirk_power_on_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = user_data;
+	struct simult_discovery *simult = &data->simult;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_warn("Power on with the quirk: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		tester_test_failed();
+		return;
+	}
+
+	simult->hooks = true;
+
+	if (hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT,
+					BT_HCI_CMD_INQUIRY,
+					simult_inquiry_hook, data) < 0 ||
+			hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+					BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+					simult_scan_enable_hook, data) < 0) {
+		tester_warn("Unable to add emulator hooks");
+		tester_test_failed();
+		return;
+	}
+
+	simult->discov_id = mgmt_register(data->mgmt, MGMT_EV_DISCOVERING,
+					data->mgmt_index, simult_discovering,
+					data, NULL);
+	if (!simult->discov_id) {
+		tester_warn("Unable to register for Discovering events");
+		tester_test_failed();
+		return;
+	}
+
+	if (!mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
+				sizeof(start_discovery_bredrle_param),
+				start_discovery_bredrle_param,
+				simult_start_callback, NULL, NULL)) {
+		tester_warn("Unable to send Start Discovery");
+		tester_test_failed();
+	}
+}
+
+static void test_simult_discovery(bool during_scan_disable)
+{
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+	uint8_t param = 0x01;
+	int err;
+
+	data->simult.during_scan_disable = during_scan_disable;
+
+	err = vhci_set_quirk_simultaneous_discovery(vhci, true);
+	if (err == -ENOENT || err == -EACCES || err == -EPERM) {
+		/* No debugfs, no access to it or no such entry */
+		tester_warn("Unable to set quirk_simultaneous_discovery: %s",
+							strerror(-err));
+		tester_test_abort();
+		return;
+	}
+
+	if (err) {
+		tester_warn("Unable to set quirk_simultaneous_discovery: %s",
+							strerror(-err));
+		tester_test_failed();
+		return;
+	}
+
+	if (!mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), &param,
+					simult_quirk_power_on_callback, data,
+					NULL)) {
+		tester_warn("Unable to send Set Powered");
+		tester_test_failed();
+	}
+}
+
+static void test_simult_discovery_inquiry_first(const void *test_data)
+{
+	test_simult_discovery(false);
+}
+
+static void test_simult_discovery_during_scan_disable(const void *test_data)
+{
+	test_simult_discovery(true);
+}
+
+static bool simult_setup_status(const char *step, uint8_t status)
+{
+	if (status == MGMT_STATUS_SUCCESS)
+		return true;
+
+	tester_warn("%s: %s (0x%02x)", step, mgmt_errstr(status), status);
+	tester_setup_failed();
+
+	return false;
+}
+
+static void simult_power_off_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (!simult_setup_status("Power off", status))
+		return;
+
+	tester_setup_complete();
+}
+
+static bool simult_power_off(void *user_data)
+{
+	struct test_data *data = user_data;
+	uint8_t param = 0x00;
+
+	data->simult.power_off_id = 0;
+
+	if (!mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+				sizeof(param), &param,
+				simult_power_off_callback, NULL, NULL)) {
+		tester_warn("Unable to send Set Powered");
+		tester_setup_failed();
+	}
+
+	return false;
+}
+
+static void simult_power_on_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	if (!simult_setup_status("Power on", status))
+		return;
+
+	/* mgmt_set_powered_complete() sends the reply before it frees the
+	 * pending command, so an immediate Set Powered can be answered Busy.
+	 */
+	data->simult.power_off_id = timeout_add_seconds(1, simult_power_off,
+								data, NULL);
+	if (!data->simult.power_off_id) {
+		tester_warn("Unable to add power off timeout");
+		tester_setup_failed();
+	}
+}
+
+static void simult_le_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = user_data;
+	uint8_t param_on = 0x01;
+
+	if (!simult_setup_status("Set LE", status))
+		return;
+
+	if (!mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param_on), &param_on,
+					simult_power_on_callback, data, NULL)) {
+		tester_warn("Unable to send Set Powered");
+		tester_setup_failed();
+	}
+}
+
+/* The quirk can only be written while the controller is down. Until it is
+ * powered on through mgmt it is up with auto-off pending and Set Powered
+ * (off) leaves it up, so power it on and off here.
+ */
+static void setup_simult_discovery(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t param = 0x01;
+
+	if (!mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+					sizeof(param), &param,
+					simult_le_callback, data, NULL)) {
+		tester_warn("Unable to send Set LE");
+		tester_setup_failed();
+	}
+}
+
 static void trigger_device_found(void *user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -13870,6 +14258,13 @@ int main(int argc, char *argv[])
 	test_bredrle("Start Discovery - Power Off 1",
 				&start_discovery_valid_param_power_off_1,
 				NULL, test_command_generic);
+	/* Simultaneous discovery ends on the 10.24 s LE scan timeout */
+	test_bredrle_full("Start Discovery - Simultaneous Inquiry First",
+				NULL, setup_simult_discovery,
+				test_simult_discovery_inquiry_first, 20);
+	test_bredrle_full("Start Discovery - Simultaneous Inquiry Late",
+				NULL, setup_simult_discovery,
+				test_simult_discovery_during_scan_disable, 20);
 
 	test_bredrle("Stop Discovery - Success 1",
 				&stop_discovery_success_test_1,
-- 
2.43.0

