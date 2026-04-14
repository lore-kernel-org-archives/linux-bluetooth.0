Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7920DE3
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165215; cv=none; b=CrhYaJKB0MwXNla1TNXZ5DqRRxE4pmJnvbMwVu7EEIdxKmcpr48T1e4txQ+sPUHBFVHaRCvTRC4PV0KH0KdQC3s45smkAGm/2aVXDpKF2yELCf2fQ6nuv6ccfLt3epquIzenQVAFeZaWbFtZwe49/EwXZCFelfU5vQJRslyGFHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165215; c=relaxed/simple;
	bh=VYca3pua4u4WGCbodlQKKRH7yLTVRWcD0NswXtR3NFM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QlqhLZ/GAe5AOma9sLOO8Qk6m6RR8CPYSZmdkewHXkouREdz0MV81RsjT1buDqPalN+mFPIhbx0j2uros7G5U+xEzkVkEdUw4oV66W/C+9Lx7l91jTeK106y3U+eMi3S1wO9PI9RhjtuxaTMdhDEUt9de5Mlg6TL1nALGTyuhuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wf0ApCTz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wf0ApCTz"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242b9359aso50328585ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776165214; x=1776770014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jYQgMhZcNRLWOdYKuAP9wzRUiz3Mx5fd01yZgXYYTBY=;
        b=wf0ApCTzfSw+sYtDZ7jj3aZ2cpdF8R/sWkGmtfkSP1BlfwUX0J3gi7yieB1dOm0ST7
         ExKa+K4pSovsXr+7jQ18Y8WBNi0OO7kZwDGqq8mGwHCcEpr/d1r4RIgxG+Pkv49wsJPT
         WKbBmd/TT6V2IbHmHM/KDlfEaB4o9hEAgzjBa6F+LCCzJQs8ZgkCovppqVuSu8c0IMPs
         zkRVWC3pu4z6Tpuzm7nq7HLWFw6AfIgvvSYAFq6K9dhUZt0RPkYeXroMsTcjGuyWEXop
         h9EylIjvgStQ7vy+KHwPb29l8ybY8ICzJRv63UufDAGbZAiyhfzwc6DYqe6vzgZCds7r
         Q+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776165214; x=1776770014;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYQgMhZcNRLWOdYKuAP9wzRUiz3Mx5fd01yZgXYYTBY=;
        b=HJUDnlvZowfReBUJ4knrN77ZaVI/2IztnbhmxdsEOsQNR3g/nEWHtuCzEVYpLWZwqK
         y//KAZP6hu/6SGR/lCyhR85j+NYZUHE01ATFvHQl2WRf6mDWTLYeiFdkFvAmcdVXDWxT
         J2p89y2y8pJyEBPReOy4qrexLmBNRkgqgshR/DYBv7IxcZilRYPCRDCYcqG3z3pzk3UD
         EdWQ1THU2a8/Gg5o0uyAIzLzEfmw4daYDouetcSjDk5cY8S45gUgU7qHnmtrBDCRHuLQ
         OQOmVZUtNG/04iKX0dBnB1YcqZj6l8CvQjg+DFlCp8A0YGn52lN8Ox9s+wxI9KYfhNcR
         r4Pw==
X-Gm-Message-State: AOJu0YwFVnqYZlCn21ncOaxq7Os1m3ad/i11fAyDHKR1xDMa7LyXM806
	ajOSYfuwzkkHIZHSQgfhCIzUIikg5Sbs9ayQ9XAv+2k+L2ae7GjDuhBomdy5PouHJrrW8ndzPis
	8IYElf3S4HTKl6vaXembinSnxmJYwU0SxSLAXpKX7LMU/SKLaPsAdeUNvnqxeCQtwhcDBJkMI7K
	/8OKZ6KL+DWgVjSgIUkUkZSsr4ddSZOnJHD3u595fr61tdMuMeMVTosQ==
X-Received: from plbbj8.prod.google.com ([2002:a17:902:8508:b0:2b2:4d5c:3eec])
 (user=apusaka job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:289:b0:2b4:5e65:5d0e
 with SMTP id d9443c01a7336-2b45e655efamr82380295ad.10.1776165213123; Tue, 14
 Apr 2026 04:13:33 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:11:10 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260414111307.3725821-1-apusaka@google.com>
Subject: [PATCH Bluez 1/2] monitor: define manufacturer company IDs
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

Define company IDs to make it more readable.
Also remove an unnecessary if that could cause uninitialized variable
warning.
---

 monitor/packet.c | 51 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index ff28dfbd4..30cab1a2f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -100,14 +100,21 @@
 
 #define COLOR_PHY_PACKET		COLOR_BLUE
 
-#define UNKNOWN_MANUFACTURER 0xffff
+#define COMPANY_ID_INTEL	0x0002
+#define COMPANY_ID_BROADCOM	0x000F
+#define COMPANY_ID_QUALCOMM	0x001D
+#define COMPANY_ID_MEDIATEK	0x0046
+#define COMPANY_ID_APPLE	0x004C
+#define COMPANY_ID_REALTEK	0x005D
+#define COMPANY_ID_LINUX	0x05F1
+#define COMPANY_ID_UNKNOWN	0xFFFF
 
 static time_t time_offset = ((time_t) -1);
 static int priority_level = BTSNOOP_PRIORITY_DEBUG;
 static unsigned long filter_mask = 0;
 static bool index_filter = false;
 static uint16_t index_current = 0;
-static uint16_t fallback_manufacturer = UNKNOWN_MANUFACTURER;
+static uint16_t fallback_manufacturer = COMPANY_ID_UNKNOWN;
 
 #define CTRL_RAW  0x0000
 #define CTRL_USER 0x0001
@@ -3487,7 +3494,7 @@ static void print_manufacturer_data(const void *data, uint8_t data_len)
 	packet_print_company("Company", company);
 
 	switch (company) {
-	case 76:
+	case COMPANY_ID_APPLE:
 	case 19456:
 		print_manufacturer_apple(data + 2, data_len - 2);
 		break;
@@ -4446,7 +4453,7 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 			index_list[index].manufacturer = manufacturer;
 
 			switch (manufacturer) {
-			case 2:
+			case COMPANY_ID_INTEL:
 				/*
 				 * Intel controllers that support the
 				 * Microsoft vendor extension are using
@@ -4454,7 +4461,7 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 				 */
 				index_list[index].msft_opcode = 0xFC1E;
 				break;
-			case 29:
+			case COMPANY_ID_QUALCOMM:
 				/*
 				 * Qualcomm controllers that support the
 				 * Microsoft vendor extensions are using
@@ -4462,7 +4469,7 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 				 */
 				index_list[index].msft_opcode = 0xFD70;
 				break;
-			case 70:
+			case COMPANY_ID_MEDIATEK:
 				/*
 				 * Mediatek controllers that support the
 				 * Microsoft vendor extensions are using
@@ -4470,7 +4477,7 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 				 */
 				index_list[index].msft_opcode = 0xFD30;
 				break;
-			case 93:
+			case COMPANY_ID_REALTEK:
 				/*
 				 * Realtek controllers that support the
 				 * Microsoft vendor extensions are using
@@ -4478,7 +4485,7 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 				 */
 				index_list[index].msft_opcode = 0xFCF0;
 				break;
-			case 1521:
+			case COMPANY_ID_LINUX:
 				/*
 				 * Emulator controllers use Linux Foundation as
 				 * manufacturer and support the
@@ -6528,7 +6535,7 @@ static void read_local_version_rsp(uint16_t index, const void *data,
 	print_manufacturer(rsp->manufacturer);
 
 	switch (manufacturer) {
-	case 15:
+	case COMPANY_ID_BROADCOM:
 		print_manufacturer_broadcom(rsp->lmp_subver, rsp->hci_rev);
 		break;
 	}
@@ -10900,11 +10907,11 @@ static const char *current_vendor_str(uint16_t ocf)
 		return "Microsoft";
 
 	switch (manufacturer) {
-	case 2:
+	case COMPANY_ID_INTEL:
 		return "Intel";
-	case 15:
+	case COMPANY_ID_BROADCOM:
 		return "Broadcom";
-	case 93:
+	case COMPANY_ID_REALTEK:
 		return "Realtek";
 	}
 
@@ -10928,9 +10935,9 @@ static const struct vendor_ocf *current_vendor_ocf(uint16_t ocf)
 		return msft_vendor_ocf();
 
 	switch (manufacturer) {
-	case 2:
+	case COMPANY_ID_INTEL:
 		return intel_vendor_ocf(ocf);
-	case 15:
+	case COMPANY_ID_BROADCOM:
 		return broadcom_vendor_ocf(ocf);
 	}
 
@@ -10952,9 +10959,9 @@ static const struct vendor_evt *current_vendor_evt(const void *data,
 		manufacturer = fallback_manufacturer;
 
 	switch (manufacturer) {
-	case 2:
+	case COMPANY_ID_INTEL:
 		return intel_vendor_evt(data, consumed_size);
-	case 15:
+	case COMPANY_ID_BROADCOM:
 		return broadcom_vendor_evt(evt);
 	}
 
@@ -10971,11 +10978,11 @@ static const char *current_vendor_evt_str(void)
 		manufacturer = fallback_manufacturer;
 
 	switch (manufacturer) {
-	case 2:
+	case COMPANY_ID_INTEL:
 		return "Intel";
-	case 15:
+	case COMPANY_ID_BROADCOM:
 		return "Broadcom";
-	case 93:
+	case COMPANY_ID_REALTEK:
 		return "Realtek";
 	}
 
@@ -11116,7 +11123,7 @@ static void remote_version_complete_evt(struct timeval *tv, uint16_t index,
 	print_manufacturer(evt->manufacturer);
 
 	switch (le16_to_cpu(evt->manufacturer)) {
-	case 15:
+	case COMPANY_ID_BROADCOM:
 		print_manufacturer_broadcom(evt->lmp_subver, 0xffff);
 		break;
 	}
@@ -13808,7 +13815,7 @@ void packet_vendor_diag(struct timeval *tv, uint16_t index,
 					"Vendor Diagnostic", NULL, extra_str);
 
 	switch (manufacturer) {
-	case 15:
+	case COMPANY_ID_BROADCOM:
 		broadcom_lm_diag(data, size);
 		break;
 	default:
@@ -16161,7 +16168,7 @@ static void mgmt_print_system_config_tlv(void *data, void *user_data)
 			value = get_u8(entry->value);
 		else if (entry->length == 2)
 			value = get_le16(entry->value);
-		else if (entry->length == 4)
+		else
 			value = get_le32(entry->value);
 		print_field("%s: %u", desc, value);
 	} else {
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

