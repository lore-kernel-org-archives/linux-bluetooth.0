Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FF3D891E
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165228; cv=none; b=WStagtQsIByulnBfZ7TQPYee4mBF26YLtrOddNTCjQwvoqlhTdH/Yh8sKOw5i13F7RZsVJT7UxYnQjbTux5HbXc40hSzjwXHRk/kuDL8cxIByMxt/UX/HeoatYUYkMe2IIDhrqNQniep2g7y7x1r7u27QLux96TDF3l2bOSYA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165228; c=relaxed/simple;
	bh=I4BcHWrG6j12lvpiXbiOa/BQ/RDFFAwVN0L7PWpiDAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qz855B2OZqIdFQxtJBJoSMnQFORGwI+iGaXhaWGKwF4B6L2SYrVW5zyzCa5urDcxqUOBM1RRTtoefn5oX0F2k0X2G383LPCXHbAvlZoS6flct/zLbxlOipoZPysEcUiPA3x4Zh5WEYRfQ9eZAGI05lHWMcflU/iVMm5COXKQjpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqVQM6rw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqVQM6rw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a90510a6d1so44410485ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776165227; x=1776770027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0cUCBSD1OUsPMML0fx+o7ycL4ZQM6SI/O1l5R7MhAw=;
        b=sqVQM6rwi1wVMxFNWN07UBXUJNuyrtZzqTzKTR+/OXXuYTTMr4xeZDKdoe/Zg7SvEk
         c4vEcUjnNB9jJd8Dr+LQjFw0Z26tBZEFAEXeeAtbhtYkKNuut8Ch5eH16C7IMM6GQghU
         jmDbRGjfJH86Qj8cLg+oYjnlSt3Nf6WGxc6HkNqmQ6IEUQCmsyCYJDzLDU35OhD0N3fa
         +NCkJFYJ012WyMNZD3VPpboU+7hDgvIQAsokA/thC26K4amI0TF+QUEhD9WsFzDLii1Z
         h7mgzB7a0lMg7uASjZUEmUfYFv9V2CJerAcHU3QtzlthVIXpcSkfvG98yu5L0lA7Lgtc
         Ijgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776165227; x=1776770027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0cUCBSD1OUsPMML0fx+o7ycL4ZQM6SI/O1l5R7MhAw=;
        b=ZVUxR5bV8OIZ6x+RQckIa8ccJStzeTnC7anU1F00KM+BK/WEzDkkosgVME6OgjcNBQ
         uMwSQN1YA3IPHm8QSCtIDpTCjEEbG+oZEGTwLKVHgl9ckpbfMDr3Ou4AvIAq7tO+lKxM
         zsvrgngj+w5krNt/x65nZURMQL5n1ZzI2eOHlA60G+ur9ZGozVzWuqnyCTl+jRFWi176
         SPKpfgviHGeRvjyEpIpuZGPGcuKRhQAzi5hy4BWflvl9Q2VH6cF2BDRtLwk+en0N9oBY
         +XRomNj10EHTffJSG4cAFMXaDMIsXGMASzmfglXzmxBD+ElRMuWoKGsUNHdI0DjgCkA/
         Se3A==
X-Gm-Message-State: AOJu0YyTrzEiOw5mwqGi1az+/mEZL2rxCM6RZbngUfV/J65ZAOY+I6IH
	xdj9RWhWC7zv4iLnkcGCI62buCD8PmRvvbFgjK1JLSboErMYfYfnxMGM95rx96NrFQ43rTei5ye
	1As2ckU1+vOR0LzFBm8e/0GQ5wulUCXfXZUMtk0ePOsaRrZAXG6UCCm5RJv6uUL8nxwqoRLnlE2
	8LVEIO52RsSQI1LqP97kyTp4vPRro9M0iZJs/RuLyz3MpPWQC83u2y1g==
X-Received: from plsp7.prod.google.com ([2002:a17:902:bd07:b0:2b2:3dc8:b460])
 (user=apusaka job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aa6:b0:2b0:badc:c9cf
 with SMTP id d9443c01a7336-2b2c72aba80mr189610015ad.13.1776165226351; Tue, 14
 Apr 2026 04:13:46 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:11:11 +0800
In-Reply-To: <20260414111307.3725821-1-apusaka@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414111307.3725821-1-apusaka@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260414111307.3725821-2-apusaka@google.com>
Subject: [PATCH Bluez 2/2] monitor: Set msft_opcode on read_local_version_rsp
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

Aside from INDEX_INFO, we can also receive manufacturer company ID
when receiving read_local_version_rsp, so we should also try setting
the msft_opcode there.
---

 monitor/packet.c | 68 +++++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 30cab1a2f..ff0b1cac2 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4359,6 +4359,24 @@ static int addr2str(const uint8_t *addr, char *str)
 			addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
 }
 
+static int get_msft_opcode(uint16_t manufacturer) {
+	switch (manufacturer) {
+	case COMPANY_ID_INTEL:
+		return 0xFC1E;
+	case COMPANY_ID_QUALCOMM:
+		return 0xFD70;
+	case COMPANY_ID_MEDIATEK:
+		return 0xFD30;
+	case COMPANY_ID_REALTEK:
+		return 0xFCF0;
+	case COMPANY_ID_LINUX:
+		return 0xFC1E;
+	default:
+		return BT_HCI_CMD_NOP;
+	}
+
+}
+
 void packet_monitor(struct timeval *tv, struct ucred *cred,
 					uint16_t index, uint16_t opcode,
 					const void *data, uint16_t size)
@@ -4451,50 +4469,8 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 		if (index < MAX_INDEX) {
 			memcpy(index_list[index].bdaddr, ii->bdaddr, 6);
 			index_list[index].manufacturer = manufacturer;
-
-			switch (manufacturer) {
-			case COMPANY_ID_INTEL:
-				/*
-				 * Intel controllers that support the
-				 * Microsoft vendor extension are using
-				 * 0xFC1E for VsMsftOpCode.
-				 */
-				index_list[index].msft_opcode = 0xFC1E;
-				break;
-			case COMPANY_ID_QUALCOMM:
-				/*
-				 * Qualcomm controllers that support the
-				 * Microsoft vendor extensions are using
-				 * 0xFD70 for VsMsftOpCode.
-				 */
-				index_list[index].msft_opcode = 0xFD70;
-				break;
-			case COMPANY_ID_MEDIATEK:
-				/*
-				 * Mediatek controllers that support the
-				 * Microsoft vendor extensions are using
-				 * 0xFD30 for VsMsftOpCode.
-				 */
-				index_list[index].msft_opcode = 0xFD30;
-				break;
-			case COMPANY_ID_REALTEK:
-				/*
-				 * Realtek controllers that support the
-				 * Microsoft vendor extensions are using
-				 * 0xFCF0 for VsMsftOpCode.
-				 */
-				index_list[index].msft_opcode = 0xFCF0;
-				break;
-			case COMPANY_ID_LINUX:
-				/*
-				 * Emulator controllers use Linux Foundation as
-				 * manufacturer and support the
-				 * Microsoft vendor extensions using
-				 * 0xFC1E for VsMsftOpCode.
-				 */
-				index_list[index].msft_opcode = 0xFC1E;
-				break;
-			}
+			index_list[index].msft_opcode =
+				get_msft_opcode(manufacturer);
 		}
 
 		addr2str(ii->bdaddr, str);
@@ -6530,6 +6506,10 @@ static void read_local_version_rsp(uint16_t index, const void *data,
 		}
 
 		index_list[index_current].manufacturer = manufacturer;
+		if (index_list[index_current].msft_opcode == BT_HCI_CMD_NOP) {
+			index_list[index_current].msft_opcode =
+				get_msft_opcode(manufacturer);
+		}
 	}
 
 	print_manufacturer(rsp->manufacturer);
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

