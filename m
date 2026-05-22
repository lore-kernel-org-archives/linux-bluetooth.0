Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8E3D75DE
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779448560; cv=none; b=dctxyvVacg12wVVcpt6g/1Ep2zz68Aa7ZEp52XW6v4OFxxu8fUE3wPp1xngNLGfkJftZCdIsJR+TJpM4GR7PZLe+SZnDnBrmAa0A2uyaydH/6sO8TnYGh2W2R7Ij5vhAHK1EfY3c2NQsFLyO0i2xlmdBshHGxuFXB0VRzG+IbDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779448560; c=relaxed/simple;
	bh=lTah1Hss3kMZiwSD471yGlYCsNR3U/u63Q8k7Vtx93Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qc//sRdcR1kAa7/J6cXfiqjvgu8gEDiIuJ8lrUk4J+w1z0tm+YLg6NOZa8+aVdfro29FcIRcswoGACeM0NxNbEBaVqhVklok9GMgt4Cm5o/kUBG+C35I0nIfz3knBnQKYuruCRi77URjYpEZ7wHpDkixrdgjHyT28aNDk/mkyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kGfF1OOi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGfF1OOi"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36603ad6709so6121970a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779448558; x=1780053358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Egmmjo9f2AA1P39cP28CRgmybfRY380QQNUq9twb6kE=;
        b=kGfF1OOi9CNLxel+TBucbF0qM/NwA/QcN9q39/8MVrIx+K6ACFD5yPmaahjFiuuaHK
         Lrexfbn1I2YpYfBCJX0/UnwTUtRphpNVIZBPyeL+q2K39R+YAqrbN9UjRkNOfnFWa4DO
         OW05H1za/fKKzrWS9lbtnCTqoPHkE7wDEbG2jyavD+YjLmSn/cqRf4xTsEbsKV8vMfTg
         8XJvTRPALGHGpH771CTDbPQ1dVQ/xaE/bwXZLrSDxEx8X/4/f4dqbJoABYg7H4Xe/ueS
         /2DIYOxH8eqCHwdORt5wPr6xpKCK2Em8q1IXP0jPmXjRcutizda51KgA4Ljqp7MUxwGS
         Ff3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779448558; x=1780053358;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Egmmjo9f2AA1P39cP28CRgmybfRY380QQNUq9twb6kE=;
        b=dXLtLFfeW9YYvlDexGOKlxQsOaBEP+g/wosObejs89OKKnlePk7mePJtbiAEzNo2JQ
         /1ujQO2zdlaHcvLbfLL5Oj4Sm8x1aFNqf0G/yo83lUkFl78DZlnAM28im4AKkWQuODL1
         yO5FMBmuaHLasR2AxmflMsMa+ZZusYioc4am1U+5nFbhZUF2R8agkEeSivDpic+8nQwN
         4zodcbsSARJCcJA4xTvJEwSXGv43a8nx+uEtNMLJoSdtJLspqXNK5grRQLLkzZjDY+om
         12CdPZxU9lneWcZ8Ct1JCxNYIldf2bpQIBvQw7yAAZjKX7aJGwF1BZ+7Hr5mPaiWGiiU
         oPrA==
X-Gm-Message-State: AOJu0Yxotu2JvopvgcWN0WIOKOaAk2b8DTnUmwiO8SElKw4vI1yfVMkq
	/8qYKZZW2DJmiK2tOn350cfNqJqnRuIV1f8btMIPUlnSMNF7+A/gsyaUJ8tik1LdPJoi0ZAdgXZ
	uuJ/EcUGtnC77oTWMzjZjUCZ3tw/NxdRJbYDcqWl/NDf3u36HWN+O2N6VQbGEjwCzQ4b6C3DHvE
	7xfmTD8t05BxYQWggmDk4vw1/n0ukzhMTJ/HSopTq4U/LwOfN7PhvFJA==
X-Received: from pjhk32.prod.google.com ([2002:a17:90a:4ca3:b0:365:f319:942b])
 (user=apusaka job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e84:b0:369:747b:48b8
 with SMTP id 98e67ed59e1d1-36a67734201mr3635604a91.8.1779448558297; Fri, 22
 May 2026 04:15:58 -0700 (PDT)
Date: Fri, 22 May 2026 19:15:12 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522111540.581113-1-apusaka@google.com>
Subject: [PATCH BlueZ] monitor: Add support for HCI Event Encryption Change v2
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

> HCI Event: Encryption Change v2 (0x59) plen 5
        Status: Success (0x00)
        Handle: 256 (BR-ACL) Address: 00:11:22:34:56:78
        Encryption: Enabled with E0 (0x01)
        Key size: 16
---

 monitor/bt.h     |  8 ++++++++
 monitor/packet.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 147b76537..eac6b5ed7 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3696,6 +3696,14 @@ struct bt_hci_evt_auth_payload_timeout_expired {
 	uint16_t handle;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_ENCRYPT_CHANGE_V2		0x59
+struct bt_hci_evt_encrypt_change_v2 {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  encr_mode;
+	uint8_t  encr_key_size;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_CONN_COMPLETE		0x01
 struct bt_hci_evt_le_conn_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index ff0b1cac2..0de7e6f57 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12008,6 +12008,17 @@ static void auth_payload_timeout_expired_evt(struct timeval *tv, uint16_t index,
 	print_handle(evt->handle);
 }
 
+static void encrypt_change_evt_v2(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_encrypt_change_v2 *evt = data;
+
+	print_status(evt->status);
+	print_handle(evt->handle);
+	print_encr_mode_change(evt->encr_mode, evt->handle);
+	print_key_size(evt->encr_key_size);
+}
+
 static void le_conn_complete_evt(struct timeval *tv, uint16_t index,
 					const void *data, uint8_t size)
 {
@@ -13737,6 +13748,8 @@ static const struct event_data event_table[] = {
 	{ 0x57, "Authenticated Payload Timeout Expired",
 				auth_payload_timeout_expired_evt, 2, true },
 	{ 0x58, "SAM Status Change" },
+	{ 0x59, "Encryption Change v2",
+				encrypt_change_evt_v2, 5, true },
 	{ 0xfe, "Testing" },
 	{ 0xff, "Vendor", vendor_evt, 0, false },
 	{ }
-- 
2.54.0.746.g67dd491aae-goog

