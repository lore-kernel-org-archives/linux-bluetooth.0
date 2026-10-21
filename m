Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567321;
	b=VgFxKoD3W2QVjQcyMFBgbQeqTmUVG3Z4KPglDOvgwGHlR39ixjD8Fw3ZCaEYD7ScdckG
	 TAHBjKZd93HsKHlGNY9B/MgUp+DdEgXtu8U/jt2qb8aq7BQa1v29aX/4HS4ia0kzG7KSD
	 fzX1+yOOsghzumFyzGEgje6CevcoC21ins5YHg3B+i9oWUo4G9LdyrBXvY0TMcaQRi9Ro
	 /NpDeev0qGL72bAy5kTskV+l5ImOHXNSsicq69kq5WPdf2tRKCh9pllOiWUhCVGB4DQga
	 GcnCsyLXDc+Jr18lVHefSl34mcYQr+n6/BX3dyi8xIn3pvbkhiCVpI5I8g3tEVioebA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tp8lZDmXnN4hhq5XqZqhHMLflWw98SONRhSMCc9s00Q=;
	b=q2lV58jgMrb8OaNUj77nn8ubYF5s5CXDar6EYpNl6Sb5pY/OOnN5Q+rng/uZq7HKg058
	 AQQSRPuPo1HficZOVd693vSh7RX0x6oxpHiSTJUJHGpM3ZuzvOzRKVDGnvKV57ndiiPvv
	 a1wBREGP/llVfvW8fd1MHnddwhrvo6CayrpAsolPAbOvMcHF0eNv11xvnqr/CHJKCpke+
	 e9o97eaZMr6cmtl8ckcbSolFYkyaioAa9oi+FB9z9x/+z15phrDwmCRWZ2YLjlC0h0NaL
	 avQdvRE788DEuvPz09B7nriPd8JMTbrZBNVbi5wz0rCJB6+gai0K8VGAdxMyNb7zAwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tooangel.de;
	spf=pass smtp.mailfrom=tooangel.de;
	dkim=pass header.d=tooangel.de header.i=@tooangel.de header.a=rsa-sha256 header.s=google header.b=RuziS7H9;
	arc=none smtp.remote-ip=74.125.228.71
Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57FF606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 07:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A57FF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tooangel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tooangel.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tooangel.de header.i=@tooangel.de header.a=rsa-sha256 header.s=google header.b=RuziS7H9
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6b1a8f9aba5so198800a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tooangel.de; s=google; t=1792567319; x=1793172119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Tp8lZDmXnN4hhq5XqZqhHMLflWw98SONRhSMCc9s00Q=;
        b=RuziS7H9MI9feqInG4GLrP+GRiuN9F1fAdUl/s/DLKygcH4B8LFVY1TkWa7LQS+iS1
         dwl6qKDak36jzl7pudOlKJoxIiOWzDDfZA7BmN7cH2lHpY6jPL48xrvlrOJw26qRNWkZ
         nWT0RaR0LJ4K4NzAZZQFH0sVdWrJJyE3tnkCRriU1boq3gRXwrCFF/JzFF3E1aBMHD/N
         1QThEvftYpaspy2/EISCe7ed3XPdP2VR4gEZsV7vSdb1qCEBJhq9DURai8Ax9E7yMULi
         QO9KqC69T1DWppniuz5x2Y8MuAReemY6unZ5Qjp68C3AabNaa/k/NL8xD2FDarT3GSoK
         lGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567319; x=1793172119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Tp8lZDmXnN4hhq5XqZqhHMLflWw98SONRhSMCc9s00Q=;
        b=YQ33KiMKUdhwOM9AZq6fdFOh9WfWa5aGwgSwt6M5WH9z6HMhiH0wrMIGwX4yhfzahV
         o//FsqZe8Nu1MDRVYUxnBgklFfEzYXJJ/TeJrk/EuwM3CFzFVpR9qIqP2XVHewuZGGTt
         EcuvlD5oHtSM6AWyyVC8uwUVueG0ikQ3d0dbEVVfPKQYFthc9DdA0E89GeSOQpakOp0W
         FaHalmuh4sQdG1GMrmSjCIkHWYiYw6cHYarwJFNCcvtAWZhjncRKNzkPA5Wt8/CBUUKl
         2y2AdvSWkfexy/a4xPZ2vjTrBnNVhQTEBNDRse7quLf+TsWu5Rl9HMB/r5KBrk7f2zBE
         2xgA==
X-Gm-Message-State: AFq9FYLvbwn62aZGefG3Knu+V3DTM9acr9BPMiaVp/+IHzD9B2a8S2Ra
	uA1BJ06f1YsFu9s8nNs3st6lgzctPQRIHcugqpeUThbrdzH9ud5iPa6v1I0GrQ4un9glPicP+CQ
	RllYFId8Dixjn
X-Gm-Gg: AYBFou3lMsbSy5Psnk8av2xfEHWWv4IMfdjVfjueXsEjkyMWl1Vs4PP4eQxcqZLltiK
	qJ4538OUV2/mGPPwlMAc+xKSIRXv0piscNPaVTnX5HCzPY25WNBQ/tSDG3h2785yWvezu/ce2Ua
	kSfOR9I41/X6TTDZduM0x51VJyDLYM1hgBo54Pgisu8bb2T5zbKXdd5l7PBWr6MIR/2azW//lVp
	TErRoM0NNd5PPjAcZYgHvTHCFpsfnByTMrv6MgsWY5x3KZ/DsuVQb+KVIZiweWAmoPDRS2ipTc0
	JUXUNXdcxl64xfDxbzufdimjg75/L4Vfg7Eu+8Ab+r4tS2UlQdGPAqaqaQMuAgK+G+0q71Ef8pB
	R4ANhtCeWDEPrB6R9fB5Upuj2xmJ9NBkMp2G3nA9rgzAf4HdI9IgTh0NIiYdblO/GlYyAiaeogL
	L3Yhe7vnvm6+LAe2DjflqbCMEpsXwKcgjLAcbhlhJAfcJgkVBLQ1xIecBcHekFIjig4f1YjraNf
	r6cq3gvklZ6vrJrCulLdxCA4/Ql8KU+3KZhuTwAIP/bwBaWK1oQG0jIZBhdeYxoFDQNfIQtZ02z
	xgNC6ua+hkCpS09EB/UiESDP1r1+AJ0Jl2SxnczlANlhTgdQUlcbr9arHBEA5gAUDMYrrxvz2nG
	/D4JFCGNOqshTPO2S0pgtzX6z44isMI/hVZOHCb4JrUdWW1QJcvYfaTmN+ih/3w==
X-Received: by 2002:a05:6402:11cd:b0:6b4:1037:2bb1 with SMTP id 4fb4d7f45d1cf-6b41037339bmr516786a12.22.1792567318900;
        Wed, 21 Oct 2026 00:21:58 -0700 (PDT)
Received: from toogaming.fritz.box (2a02-8206-7df6-9800-2fb8-381c-b7e8-86f2.dynamic.ewe-ip-backbone.de. [2a02:8206:7df6:9800:2fb8:381c:b7e8:86f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b40315506bsm534286a12.29.2026.10.21.00.21.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:21:58 -0700 (PDT)
From: Tobias Wilken <tooangel@tooangel.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] mgmt-tester: Add Set Powered test for rfkill block
Date: Wed, 21 Oct 2026 09:21:33 +0200
Message-ID: <20261021072133.136948-2-tooangel@tooangel.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021072133.136948-1-tooangel@tooangel.de>
References: <20261021072133.136948-1-tooangel@tooangel.de>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Block the controller through /dev/rfkill and check that Set Powered
fails with RFKilled (0x12), the status bluetoothd handles for a
blocked adapter. Without rfkill support in the kernel the test is not
run.

Kernels since Linux commit cf75ad8b41d2 ("Bluetooth: hci_sync: Convert
MGMT_SET_POWERED") return Failed (0x03) instead; the fix is
"Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked
controller".

Assisted-by: Claude:claude-opus-5-5
---

Notes:
    The new test passes with the kernel fix "Bluetooth: MGMT: Return
    RFKILLED for Set Powered on a blocked controller", sent to
    linux-bluetooth:
    https://lore.kernel.org/r/20261021065833.120347-1-tooangel@tooangel.de
    
    Results in test-runner with bluetooth-next: without the fix the test
    fails ("got Failed (0x03) expected Blocked through rfkill (0x12)"),
    with it mgmt-tester passes 515/515, and with a kernel built without
    CONFIG_RFKILL the test is not run.
    
    Hopefully this makes the kernel fix easy to verify.

 tools/mgmt-tester.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 631c906..528d8f7 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -22,6 +22,8 @@
 #include <errno.h>
 #include <unistd.h>
 
+#include <linux/rfkill.h>
+
 #include <glib.h>
 
 #include "bluetooth/bluetooth.h"
@@ -812,6 +814,13 @@ static const struct generic_data set_powered_on_invalid_index_test = {
 	.expect_status = MGMT_STATUS_INVALID_INDEX,
 };
 
+static const struct generic_data set_powered_on_rfkill_test = {
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_RFKILLED,
+};
+
 static uint16_t settings_powered_advertising_privacy[] = {
 						MGMT_OP_SET_PRIVACY,
 						MGMT_OP_SET_ADVERTISING,
@@ -6579,6 +6588,51 @@ static void setup_bthost(void)
 		bthost_write_scan_enable(bthost, 0x03);
 }
 
+static int rfkill_block(uint16_t index)
+{
+	struct rfkill_event ev;
+	char path[64], name[16], hci[16];
+	ssize_t len;
+	int fd, name_fd, err;
+
+	snprintf(hci, sizeof(hci), "hci%u", index);
+
+	fd = open("/dev/rfkill", O_RDWR | O_NONBLOCK | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	/* Reading /dev/rfkill returns an add event for each rfkill device */
+	while (read(fd, &ev, RFKILL_EVENT_SIZE_V1) == RFKILL_EVENT_SIZE_V1) {
+		snprintf(path, sizeof(path), "/sys/class/rfkill/rfkill%u/name",
+								ev.idx);
+
+		name_fd = open(path, O_RDONLY | O_CLOEXEC);
+		if (name_fd < 0)
+			continue;
+
+		len = read(name_fd, name, sizeof(name) - 1);
+		close(name_fd);
+		if (len <= 0)
+			continue;
+
+		name[len] = '\0';
+		name[strcspn(name, "\n")] = '\0';
+		if (strcmp(name, hci))
+			continue;
+
+		ev.op = RFKILL_OP_CHANGE;
+		ev.soft = 1;
+
+		len = write(fd, &ev, RFKILL_EVENT_SIZE_V1);
+		err = len == RFKILL_EVENT_SIZE_V1 ? 0 : -EIO;
+		close(fd);
+		return err;
+	}
+
+	close(fd);
+	return -ENODEV;
+}
+
 static void setup_pairing_acceptor(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -12349,6 +12403,31 @@ static void test_command_generic(const void *test_data)
 	test_add_condition(data);
 }
 
+static void test_command_rfkill_blocked(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	int err;
+
+	tester_print("Blocking controller through rfkill");
+
+	err = rfkill_block(data->mgmt_index);
+	if (err == -ENOENT) {
+		/* Kernel built without rfkill support */
+		tester_warn("No /dev/rfkill, skipping test");
+		tester_test_abort();
+		return;
+	}
+
+	if (err < 0) {
+		tester_warn("Failed to block hci%u through rfkill: %s",
+					data->mgmt_index, strerror(-err));
+		tester_test_failed();
+		return;
+	}
+
+	test_command_generic(test_data);
+}
+
 static void global_adv_disable_hci_callback(uint16_t opcode,
 					const void *param, uint8_t length,
 					void *user_data)
@@ -14073,6 +14152,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Set powered on - Invalid index",
 				&set_powered_on_invalid_index_test,
 				NULL, test_command_generic);
+	test_bredrle("Set powered on - Blocked by rfkill",
+				&set_powered_on_rfkill_test,
+				NULL, test_command_rfkill_blocked);
 	test_le("Set powered on - Privacy and Advertising",
 				&set_powered_on_privacy_adv_test,
 				NULL, test_command_generic);
-- 
2.47.3

