Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE61F2D6E64
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778348246; cv=none; b=o8wQdceQgXdac2KmD6BKpq5pWGpN0YL4UJrqfo6Rd7hCTGgybHht8DNISw5+f2Bl2zi8mDKsAj5piZ8g/vkrpnGv77jzlLUeSM+yi3vdrJeotibiLHBTOwdx18opSGDDAstod9q5+tS1Z6NJ4OzzwCINXRXuuDhkSydcWW9COtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778348246; c=relaxed/simple;
	bh=e2GjKTKea81CGHYtzFQV32hsev817Ai0nnPKifZlU4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MW75r9c8utmUUbuTLtuSil4FVvLHmP/fJgfbJGZfzhwpnv7FB9dy9UtvpK5NyM6+Cj2skp5/f94Gu4YQqgRMUMWgjdhd6y42Q8apWr9fiBUsXHuB2xOux58zG3Tl+kyoqxyQ0yUuTY7DIlUHO/pduWIRTI01Hq0TXp5HIhglvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5zDSUd2; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5zDSUd2"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-8383fb7143aso1406883b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2026 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778348244; x=1778953044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFetqh0f7P3KIBFIpJJ71t2M01oqcpZfHvvZgt/9GlY=;
        b=R5zDSUd2k9vGIhktwQOAzXrj6SKAppd875VSmyW80oPEd4km88kmkSakO2FePCxNLA
         lpwHx6ecFnXnQuT/O8n00nHTx7+4NAiQUic3M3NIvrGlm7cfCjSAICdUp4Hfl2L4NoG6
         HrbBKFUaFhw5MW0R/GTnUzEco43SnNHtQqloVTKZAPdFQbTN+3tcTpBqTOgeCZkBFFFz
         ftmZVp28+yoeRvosYqX9LVXMV+JWDZgqnGMNYR9YsGdXdGyjC6huYpD4DSOuHxXoojsR
         EZUrT2Jh1rbO1L1FagFmyaqzKzRaw+ur/guiOcemcKX/DeX/0vuNjxShL2RB4TfdcHtB
         DhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778348244; x=1778953044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFetqh0f7P3KIBFIpJJ71t2M01oqcpZfHvvZgt/9GlY=;
        b=TGPXXCMS0eVXfwaKiEd0lLSY0wwdGAol3ujYos2iv4JPP+W85853/MMOxV9YCCf+Kw
         9ZE1jcv7TEWi1KGR6xIxYSrW7QWL79KDmECEVouUFFqKO8Qdba456pUUD+9IEkFNpEJ2
         fb9Z5j6j5pB0078Nnc48Fcs0LaYDdJT+HQZaLSw52W4ra3T6kVnhFdmlyOktyJ46Xqwp
         cW6foX/w97UmpzhG4hEU4PdE2yD17JzkqOvYyn7s2iDUAt4w7Jb0VsYbyhkH6HUh03mS
         I7XdWqAlzVNoGxcD0wyZLzBXr1TThsNDRBMTnLcahiy1spuiY+obDfi0BNS2kVLvwGbG
         2ipA==
X-Gm-Message-State: AOJu0YxLM7Vht/I+VIhpw2Wx7kIJ2/oAj5ZdQdFCMx+9V3+fO2DBfF5U
	GWQTIPHZMkmQvSOWLwYAywTTVmSL8rBmDfCmm8BtfUz4IAmeWZnNjkFZ
X-Gm-Gg: Acq92OGXFVtLnrE38eTK5yLAEGW/PWTOw8Y9jXRM0znI2frD/DGvcNFEAHPjcFM0AiQ
	qQgv/RR61+mMYHgwdywU1YadAk0yePyLzuaQPFDBHvs0yEm8Em/3hE6tGrdn4JbTrqZdC+Moe4y
	d1eH7EvuVuOpGQQxViS7PM2MUJ9lB5nNKkrHotuIuue07yJiPujUk3oHNvClI8Iyc4uR98Awx04
	+KuLbyBX8E8nmYZ8do/OK9K0uY20aiNxxcIU+5xP7p7U02X9G9Yw4uv8iTpliBtcKpONwm6Xnzx
	C2Jml3FW7EePvWWjrKYwy+Tk18lTfY2EdWO14eSNb8SOIkFiewsW1lXO0inWegY9jScrCKqqINS
	BpTKOg0PZtWbRoQ5MONTyYhUc377cLra1oBNQJfWIzA8/xt9AHxVP3gTawZPFVIppgeLxrv2XuR
	XEvukndjz4fx+oTv8mZTsofoQ9LKAJUEg=
X-Received: by 2002:a05:6a00:39a0:b0:82c:215d:5e9d with SMTP id d2e1a72fcca58-83e3b3d0bd1mr2964385b3a.32.1778348244012;
        Sat, 09 May 2026 10:37:24 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d38ab5sm18893425b3a.26.2026.05.09.10.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:37:23 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH] Bluetooth: mgmt: validate advertising TLV envelopes before parsing
Date: Sun, 10 May 2026 01:37:08 +0800
Message-Id: <20260509173708.411850-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tlv_data_is_valid() loads the field length from data[i] and then inspects
data[i + 1] for managed EIR types before it proves that the element still
fits inside the supplied advertising buffer.

Move the existing per-element length check ahead of the type-byte tests so
every non-empty element is proven to fit before data[i + 1] is read.

Also reject MGMT_OP_ADD_EXT_ADV_DATA commands whose declared advertising
and scan-response lengths do not match the trailing command payload.
Unlike MGMT_OP_ADD_ADVERTISING, that path did not validate the outer
envelope before slicing cp->data for tlv_data_is_valid().

Sanitizer validation reported:
BUG: KASAN: vmalloc-out-of-bounds in tlv_data_is_valid()
Read of size 1 at addr ffffc9000031a000
Call trace:
  dump_stack_lvl() (?:?)
  print_address_description() (mm/kasan/report.c:373)
  tlv_data_is_valid() (net/bluetooth/mgmt.c:8623)
  print_report() (?:?)
  srso_alias_return_thunk() (arch/x86/include/asm/nospec-branch.h:375)
  kasan_addr_to_slab() (mm/kasan/common.c:45)
  kasan_report() (?:?)
  add_advertising() (net/bluetooth/mgmt.c:8751)
  __entry_text_end() (?:?)
  __hci_dev_get() (net/bluetooth/hci_core.c:67)
  do_raw_read_unlock() (kernel/locking/spinlock_debug.c:178)
  _raw_read_unlock() (kernel/locking/spinlock.c:262)
  hci_mgmt_cmd() (net/bluetooth/hci_sock.c:1619)
  hci_sock_sendmsg() (net/bluetooth/hci_sock.c:1800)
  sock_write_iter() (net/socket.c:1234)
  reacquire_held_locks() (kernel/locking/lockdep.c:5375)
  security_file_permission() (?:?)
  vfs_write() (fs/read_write.c:668)
  __sys_bind() (net/socket.c:1947)
  ksys_write() (fs/read_write.c:729)
  rcu_is_watching() (?:?)
  do_syscall_64() (arch/x86/entry/syscall_64.c:87)
  entry_SYSCALL_64_after_hwframe() (?:?)

Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>

---
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b05bb380e5f8..827a67db4733 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8638,6 +8638,12 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		if (!cur_len)
 			continue;
 
+		/* If the current field length would exceed the total data
+		 * length, then it's invalid.
+		 */
+		if (i + cur_len >= len)
+			return false;
+
 		if (data[i + 1] == EIR_FLAGS &&
 		    (!is_adv_data || flags_managed(adv_flags)))
 			return false;
@@ -8654,12 +8660,6 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		if (data[i + 1] == EIR_APPEARANCE &&
 		    appearance_managed(adv_flags))
 			return false;
-
-		/* If the current field length would exceed the total data
-		 * length, then it's invalid.
-		 */
-		if (i + cur_len >= len)
-			return false;
 	}
 
 	return true;
@@ -9113,6 +9113,10 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s", hdev->name);
 
+	if (data_len != sizeof(*cp) + cp->adv_data_len + cp->scan_rsp_len)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_DATA,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	adv_instance = hci_find_adv_instance(hdev, cp->instance);
