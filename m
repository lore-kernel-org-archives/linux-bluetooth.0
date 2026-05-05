Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB67287503
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014052; cv=none; b=VgupCkHIaV8iORvXYG20INEbHxENTdUGKCrdqjtiECG6xu2alSa+04cYwa6Vh2AGzd29U98AjJ2YJJXnx9w5zvI++p465gHKp47Y46bfUG+SoKCRgUdPhHpAHYfhITiusrBGiSZ6lfX1TlBLnai5XPiae3lPfkQScCmmrjt1IZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014052; c=relaxed/simple;
	bh=mRVB3ggAS54pFRELBBZkW/OD3oztKRmzedAQU+T4UKE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtZN6dvgCa2zW2FA6VeGlSfdEA234lwA2BSBkncYT8+HNeuXhwdWh0k3T/ZcCJP5UwuqtgT8qZ4GIGbNSKW3np6MhJ3+ePwMT6SoomcNWp7hzj1fvLt+Ttjgb+8LwMF8zEodsdmQgxhvMVv5kJFXr/K5LgBlS61tL+cI/uHjEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcjOb3BB; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcjOb3BB"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-95cd8b71105so2930273241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778014049; x=1778618849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jT137JZJLTI4ELhpdq7jXWsGiGX39VWunOPz9bD0EHA=;
        b=WcjOb3BBCw5MLLvRgNHX5mNNZeyPcT7XIdco0VAUXc6sZqE0rppWBibkb2UqOg8vox
         hgK+hbpiG1XyaL+0dsYkyYlBYvqW8Qc0pXxu7kOYdCiR0WS95kxWCEe7vW/BfBzbcgN1
         62HVdoK+wufZXoRMIirWtzR4eBVJPoKwFBGBKloHaSbfuYyjxSqAuc4otP6LtszWu9Eo
         tPyMbq7By382akUe2CNjdfNyvGQvqJ8h0nGcTqnp57vYdvQYWm2qQXNFd557RvN4kPJG
         apifv9Fm8crQw21ieXCAklFB8aem5Pg2Gi7zbsvduiTyn5ViRsCWb63mUGB7oF83Z3ub
         ZWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778014049; x=1778618849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jT137JZJLTI4ELhpdq7jXWsGiGX39VWunOPz9bD0EHA=;
        b=LhG3vcMCj4RBR1O4JB8pgQCZGg7y7+5j5UR35TZQ3tQJPAVGAwb4c98MCsQkWSF5FE
         eUsmXn5cPhwPHJTHhpjuOGB8Dn+GDrbEM7R4txaSg8QORAkiQr+WI+TJwIET+ODY4STA
         s7xx2WaHzv7ovZ2VFoxkW45MkiY93e6uId7HMoyc17AfRNkwdMSfj4i5WWS0GysT+by9
         G2mOE+JdJwEwqk4i4LoDHNkCSPpjedgGkQALV/SoiZHXNo9Fj+Y3ezzCjgyBniajgmmO
         5fvFaVNjvlvbJEcKEpkOlY1oJDNKO/cUcNS5GcUipSrEKZX9zvi2x8vS1YALoUVMV89O
         yLmg==
X-Gm-Message-State: AOJu0YwBAXTZNKgF2oepbmVI1QmTsGGi92uP6IhQduGGDWNjyZvXEg/U
	SMEtOlhl1L6ES6CobCrnT9u46KO/Z5V6JJy3dRlKsDAIjSSiyIqVjdjhnKuCVjQd
X-Gm-Gg: AeBDiesIYrEjldXMRyxMMr8S5y5a3jHHa3znmwjR/QgzXpVJJC0zZnJf05LqMo9kAdP
	LpjvRlrJILWWsZ29cL5FWgbVix6GMoMickzluDmHtdVfBZ//CUOP1nF8jG+bvFkxY5J2iRSxinE
	hiSIeywblZE+kjyYgUcW3Lm9ruzgT0dP42P983zvAzsbYti1G6Yu0/PTGwjlahniSbRMcKVayiB
	Ha1hTmhxrYJInQ3DTWPZtbl/z/VZaumwbSXDNCcThlLprZ8tUZQ6EwSHD6PMDkEcTCscJKoz9NT
	yPZNF6sa7tlo4SLwcduS5pq8PAcU22tzjQSnHDUAVFvCF3o8snX0qht6gwMHa8p3vnX9fsC6IVR
	mrmdHzTli0LqZRcvBbR2V81AyUSEG8Zf3lg+WkqFQcCHjSnyxNTIsd28ABuMdewQtedWTfJx2qU
	muKvAhdLvaIa1epOv4ocUqxqZTAvvkt+kb2mGqPUSyDwr7utcg46dlqLQg22uk+S4C9CQ1yvb+Z
	tr02/sfsxgu+qFDcACFD+k98zhomivNsFKtLXU=
X-Received: by 2002:a05:6102:f0f:b0:606:49d:1861 with SMTP id ada2fe7eead31-630f9058f05mr173289137.27.1778014049442;
        Tue, 05 May 2026 13:47:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfb14f1aasm8006629137.2.2026.05.05.13.47.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:47:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] emulator/hciemu: Add debug messages to error paths
Date: Tue,  5 May 2026 16:47:17 -0400
Message-ID: <20260505204719.1348473-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505204719.1348473-1-luiz.dentz@gmail.com>
References: <20260505204719.1348473-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Introduce a variadic hciemu_debug() helper using util_debug_va and add
debug messages to the following error paths:

 - create_vhci: failed to open vhci
 - hciemu_client_new: failed to create btdev, bthost, or socketpair
---
 emulator/hciemu.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index bff92286ed45..9534d82bac39 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -19,6 +19,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <stdbool.h>
+#include <stdarg.h>
 #include <errno.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
@@ -60,6 +61,18 @@ struct hciemu {
 	unsigned int flush_id;
 };
 
+static void hciemu_debug(struct hciemu *hciemu, const char *format, ...)
+{
+	va_list ap;
+
+	if (!hciemu || !format || !hciemu->debug_callback)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(hciemu->debug_callback, hciemu->debug_data, format, ap);
+	va_end(ap);
+}
+
 struct hciemu_command_hook {
 	hciemu_command_func_t function;
 	void *user_data;
@@ -249,8 +262,10 @@ static bool create_vhci(struct hciemu *hciemu)
 	struct vhci *vhci;
 
 	vhci = vhci_open(hciemu->btdev_type);
-	if (!vhci)
+	if (!vhci) {
+		hciemu_debug(hciemu, "Failed to open vhci");
 		return false;
+	}
 
 	btdev_set_command_handler(vhci_get_btdev(vhci),
 					central_command_callback, hciemu);
@@ -343,12 +358,14 @@ static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu,
 
 	client->dev = btdev_create(hciemu->btdev_type, id++);
 	if (!client->dev) {
+		hciemu_debug(hciemu, "Failed to create btdev");
 		free(client);
 		return NULL;
 	}
 
 	client->host = bthost_create();
 	if (!client->host) {
+		hciemu_debug(hciemu, "Failed to create bthost");
 		btdev_destroy(client->dev);
 		free(client);
 		return NULL;
@@ -358,6 +375,8 @@ static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu,
 
 	if (socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK | SOCK_CLOEXEC,
 								0, sv) < 0) {
+		hciemu_debug(hciemu, "Failed to create socketpair: %s",
+							strerror(errno));
 		bthost_destroy(client->host);
 		btdev_destroy(client->dev);
 		return NULL;
-- 
2.53.0

