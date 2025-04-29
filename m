Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB571F4736
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745954006; cv=none; b=LAvT0HOQUsgNp0I9fVUUcWNfhgGPX3p0nVkffWsyEYybAaGQCUL1q1yab9WDSZmTWekrsKZfmHEBVNGorSnMauLI/6sle+nOwrHIdUNTijcq9mOzXZVV1n2ljXvK1mskweYhPOXeCeXzJjG7LvKR9j6dJ48TAjHH3vulPFviXmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745954006; c=relaxed/simple;
	bh=FICA8ldjVTbB5SS4fcLjGWjcLdCi5OvP1oWVZSpwj3k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SxNOKdNlgUTW213NiIjl4w2g0aEKfdGBWS2KK+p/Tt/ZHKb5RzeqRkOxNqwVmfoXOvWvUJi3m0B3E1vX2ZeTz7oXDiut0FvrV9H6UBf8k7C/8N4eLAH9/iZjRMp68r4u5kctr7dysQll497uTEC+uL0l1ZsCuOwQV8SciteiIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIZ1a1xK; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIZ1a1xK"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4c4d8638e17so137970137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745954003; x=1746558803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNzb8D7BDI1m5l4txfXJf1yUSyQkE1IugTeypokTQmo=;
        b=aIZ1a1xKkoOYVjGkIr6x0SMvRqXcVRrY9lRgMDPvwy8m7XxWP+/1kk82NqxyhlJHcl
         Wk/M2zmP+6lBnFGc7xGrhRMVAOAU3PBd7vZyEDqIRsWR+GSWdGiGMzPgxAIH3RI2uV3l
         WUTB3zyRzQjUNf0yqvNvk10VAud2of4qFe+fIpvitte/HrG4uREE/M3I7mBlgbrMU+8+
         uHqxVNQBuGiWhPmd/2Pe6n5YU8Vt0rJYOigUAJYAJQx2jqVGYhL/2EvDWC/CJUMcMMNg
         nLhIX4O+h4c+I1mmw2y0r9p0DqnsPVHK8eabSTIYCkab1MyCrWEtypzXFWhbXIAnxwZh
         55gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745954003; x=1746558803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNzb8D7BDI1m5l4txfXJf1yUSyQkE1IugTeypokTQmo=;
        b=ugH5sUCNM1wvAQQq4CbXesmrSRBoUyxMb5yCsfFV4wX97e0jQ5TpoO+8EeHpTIaOBG
         N3a/ki0zcajKT3geoQs0Ixv+nRoZCIpyjrSnNCTuUMwUlcYocCclNrI+keuVXbe48iv9
         yri3gr8yfJOgNpePFL9cZ2Jv3Zc3y7USaYMCg7DVp7wCkSp9IJ6014FJd8WvvPuScROA
         Fh5FMBRbFHzP72nFdn571pvnpVtjcWmOupC/vlWsDffrOaMHlM/IV2CmawF7Q8AehVzH
         amyexWP7Jj4MvdNXclt8QecZ4SoLNplATkHu8oF8KhPdP748MvkgWdM/vvaEQZL+uWlA
         FCRQ==
X-Gm-Message-State: AOJu0YwE+L2+N/fzryaS1eqk6+CcASY2rP30LAo9t4cqJlHVq+Ipy3W2
	7stcxRsMsPkQ481bpLgVpU5Ti5Icda76cehXi7EMvoXdgrH+lOtBKmLHxPeq
X-Gm-Gg: ASbGncuu/u2ewMZv54R1ojXNviGbdIm4LynpjcQ7eWWu6Q3Ryy73oP94isua8ithEI1
	t6Ig8hum5FRdLHZEd2iCQ8q0OOPVdvbbZGzPG4x2ejI8QtdTRJTXuy1BDpi6T5gIObFEY5jDDIp
	HRDmLr81ciIlpcLJufW9/CtJ13Bq2+Rfv9mxdPwqrXWRMRvEQrjvZBZ+vfAGIa48HF9cK8nbHSp
	vuzNphovVaNGNf+U2dLoyvF7qRjC1+XXVOIngMQfx0WeGMd85ePuZT2kngWiM2YWYCK05w/OrCY
	jESC5jReUeRQYzd0e8NB25ki/eSolUaHya1O9UznKqFMe3wNf5RDT7CIrMYrzlhkYLmwbiG4yqP
	3Eh2LIMdGiQ==
X-Google-Smtp-Source: AGHT+IFcmiXSdXIQDlj/fsEHU1GnlRIzA9gDVowHiUd/uwtUs56PfRBZkpHWfFrIQ7w9MJmTRMlmhg==
X-Received: by 2002:a05:6102:3048:b0:4bb:db41:3b6c with SMTP id ada2fe7eead31-4dad35ac562mr348197137.12.1745954003361;
        Tue, 29 Apr 2025 12:13:23 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4dad423db57sm5360137.19.2025.04.29.12.13.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 12:13:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags
Date: Tue, 29 Apr 2025 15:13:19 -0400
Message-ID: <20250429191319.2234877-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device flags could be updated in the meantime while MGMT_OP_ADD_DEVICE
is pending on hci_update_passive_scan_sync so instead of setting the
current_flags as cmd->user_data just do a lookup using
hci_conn_params_lookup and use the latest stored flags.

Fixes: a182d9c84f9c ("Bluetooth: MGMT: Fix Add Device to responding before completing")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c1e1e529e26c..46b22708dfbd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7506,11 +7506,16 @@ static void add_device_complete(struct hci_dev *hdev, void *data, int err)
 	struct mgmt_cp_add_device *cp = cmd->param;
 
 	if (!err) {
+		struct hci_conn_params *params;
+
+		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
+						le_addr_type(cp->addr.type));
+
 		device_added(cmd->sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 			     cp->action);
 		device_flags_changed(NULL, hdev, &cp->addr.bdaddr,
 				     cp->addr.type, hdev->conn_flags,
-				     PTR_UINT(cmd->user_data));
+				     params ? params->flags : 0);
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_ADD_DEVICE,
@@ -7613,8 +7618,6 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	cmd->user_data = UINT_PTR(current_flags);
-
 	err = hci_cmd_sync_queue(hdev, add_device_sync, cmd,
 				 add_device_complete);
 	if (err < 0) {
-- 
2.49.0

