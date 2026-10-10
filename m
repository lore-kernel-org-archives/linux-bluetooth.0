Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC23C3F56
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602339; cv=none; b=WesozuYkzBMdhhuWMWfxQZ6SUKsQNOVs77UPOf117jaV9M4Ta9Zau5dbAQzIsxHHVtrKXCOuG3APIaVqu94P1lzXyWMU9XyrJk8PiULntALkR7U0QNXfm0u71jLPQu5s0Hqho5KHSkY3nVvkwrax/rKuJNj8TFrTrkE1toiU2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602339; c=relaxed/simple;
	bh=vPVY1zBXn1hkp1Bon/HGPRARj7tUWXKtHFq26MOjusM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+bpZY6GqDPQ9mAA49tWw+BU3tYcN6RtCR3+p0A/Ak65kfJQRyfcioN6+0llwY7CLEt9K81tT1TIaOvUM9P9SdbsTIeXmxzF2ZMBRD9GXrSkwskLeSRZZHvo5AQwUKZZk8IS3Hqg9TDc9bDGkksr+cFZELUmgZws5WNV/N3GSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZCIB1Hz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZCIB1Hz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49fd4e9e1f6so237405e9.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 20:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791602334; x=1792207134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l/NEc8GAILJbnyzFH3WDW8BPyDgM0OZvb2WD/ptrViE=;
        b=fZCIB1HzfpGDmKbAJJDlVPiyORrgKNkHsnvcuaCoRHvpnAIGqzQk5TcyLXxRo0Hf5k
         ZMwRzDA9si+2FXCg1oYl6b0emoFP1jSMwfwlGy1MRi4pw4kovxn6x6eOpz5ejgO5x1RM
         uOO+WdRJUVO4TaMFeTFkQ64IDF67s6dWadWVIy434yAb2KomdAkdIuG1z1er1YhPKvwP
         4jU5okQXS7hkX1KsZjmzlBf2hysVVS8vOGzxF8MjKO26rVFYPXvLvUCam9i3JcYSwi2I
         rEtW3xITJSPClQlLRnNEjdRy9zXrRDY9ZRsyOPIjZ/seMooKKJMsYtvA41vGxV8S7eGc
         rHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602334; x=1792207134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l/NEc8GAILJbnyzFH3WDW8BPyDgM0OZvb2WD/ptrViE=;
        b=YmjlnarV6FfaOLnup5rRepvk+nVqoWnmQX6RpwVqZeENR86yS3jdOcaxz0F1xLdbv9
         nne/gxrqCG1fzfdbjZH05IFGuyDgx/SXzntgbb8C1Esoer0lL/yGTRyLe1ICleSh0bAz
         ql2/kRjOIjHAAq2k2o2vJluJRak93k0id9YmYg2Y0/CGyATUUOxy4jhKDQhnsBd0x0jU
         01siz0LqD0awEbj3tUV+Eex+sdkCJtMR3PPd8mQupJuHt57ydrZBSG2HRNSbZM+EMKM0
         szRs107GK70XaC1E0sgsA0odz87lXPC68jUc2gGs472MwDFnbwWS2yv1GVq9u2durqmp
         u+7Q==
X-Gm-Message-State: AFq9FYLi/cFbQuEoSNvF6uyxc1V1sMekJmiEWJXpOd0iBhevks8Fn6lm
	H/KlZjfOdVPeTC/yeMTMJ8DrYO8JWzz1c7wISEzMyjiNFEyiYJaCDloVnuhxt7NbUgw=
X-Gm-Gg: AYBFou0/VG7K6d3+1KC1DclR6NwjSc5KVyAi93k7L40TfDmU+unD3AXO2F+xBjNNiPf
	/ymuVT8XvyQBSODL4GwJTNa0/8RqAW2HWphi2yek0LqM/f4Wd6Qnh2maA/4YLcT+H8lS4GhNX2I
	88kklkioGBIgMteNu+26luAqRzZcOUXjwk958zBYXbnW3iot3gOaFXYqxr1V/7cnmzUQ0UIKLrk
	jpRE+nFAOQNl8vzdmWyvKHx2RPYnlgvnjIUu0/7xEN5UfuNh21OhiK2MV8B1pJdqBm18hl7vPmm
	OWA6gu0PDzpmZ5AN++vWpcv43mmt1nupU9eLK1JVDMZrJzX1RLtJShYcBGluAkabguXLfApfG+i
	yEq+UtwjoNw3Za8BJ3sRMq8VFe+ZCuiHOmhsn+xrvk2msUXruzn3gRvYt9CS8XYh7iRRS0DP2ZE
	eItCHUEUz6YxNTUlnNvbbyWtCqOgf6MkJEbz0qaxnza6c+EiTozoonk7Nn/3vkWc+IiBskXo3Di
	ZwwpICOXjiONCZgWwPaNWdJHAhwLrp0txnb1267H+I9OqBjonUMCm0=
X-Received: by 2002:a05:600d:82c6:b0:4a1:8469:e6c3 with SMTP id 5b1f17b1804b1-4a18e471decmr80337745e9.1.1791602334074;
        Fri, 09 Oct 2026 20:18:54 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm110270805e9.10.2026.10.09.20.18.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:18:53 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] emulator/vhci: Add vhci_set_quirk_simultaneous_discovery
Date: Sat, 10 Oct 2026 05:18:50 +0200
Message-ID: <20261010031852.2842893-3-yaroslav.voytovych@gmail.com>
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

Set or clear HCI_QUIRK_SIMULTANEOUS_DISCOVERY through the kernel's
quirk_simultaneous_discovery debugfs entry, which only accepts writes
while the controller is down.

This entry name is the longest so far: its path does not fit in the
64 byte buffer of vhci_debugfs_write() from hci1000 on, so size the
buffer with PATH_MAX and use snprintf().
---
 emulator/vhci.c | 15 +++++++++++++--
 emulator/vhci.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index 05fcfd0b7..1edba8cfc 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -220,7 +220,7 @@ struct btdev *vhci_get_btdev(struct vhci *vhci)
 static int vhci_debugfs_write(struct vhci *vhci, char *option, const void *data,
 			      size_t len)
 {
-	char path[64];
+	char path[PATH_MAX];
 	int fd, err;
 	size_t n;
 
@@ -228,7 +228,8 @@ static int vhci_debugfs_write(struct vhci *vhci, char *option, const void *data,
 		return -EINVAL;
 
 	memset(path, 0, sizeof(path));
-	sprintf(path, DEBUGFS_PATH "/hci%d/%s", vhci->index, option);
+	snprintf(path, sizeof(path), DEBUGFS_PATH "/hci%d/%s", vhci->index,
+								option);
 
 	fd = open(path, O_RDWR);
 	if (fd < 0) {
@@ -307,6 +308,16 @@ int vhci_set_force_static_address(struct vhci *vhci, bool enable)
 							sizeof(val));
 }
 
+int vhci_set_quirk_simultaneous_discovery(struct vhci *vhci, bool enable)
+{
+	char val;
+
+	val = (enable) ? 'Y' : 'N';
+
+	return vhci_debugfs_write(vhci, "quirk_simultaneous_discovery", &val,
+							sizeof(val));
+}
+
 int vhci_force_devcd(struct vhci *vhci, const void *data, size_t len)
 {
 	return vhci_debugfs_write(vhci, "force_devcoredump", data, len);
diff --git a/emulator/vhci.h b/emulator/vhci.h
index 12c4b55a0..1efb52f2e 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -29,6 +29,7 @@ int vhci_set_msft_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
 int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_force_static_address(struct vhci *vhci, bool enable);
+int vhci_set_quirk_simultaneous_discovery(struct vhci *vhci, bool enable);
 int vhci_force_devcd(struct vhci *vhci, const void *data, size_t len);
 int vhci_read_devcd(struct vhci *vhci, void *buf, size_t size);
 bool vhci_pause_input(struct vhci *vhci, bool paused);
-- 
2.43.0

