Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC7EE49A5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Aug 2023 13:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjHSNdY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Aug 2023 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHSNdY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Aug 2023 09:33:24 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36113F58C
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 06:31:34 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RSflf4ktXzyPG;
        Sat, 19 Aug 2023 16:31:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1692451886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QFzl1Q1pyyM4DuuxOqyyoJaMaJEA7LV10cSwcwZSSf0=;
        b=YWVrFMnMmF2OKUkfPRAvFyqI80ucjHn0ZIxbpipk6xGa0NFm2rsmd9irEjV3n6l/yeSjZE
        ocfGyICULHqXv4JvPVWUtHakGpNMpI4cmXeW+4fP6cP1oGBWsPkNjrYb/vUR3WMH3VIswk
        EYhG3N32ekOi0WlDtNPP+U0oNCKiWvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1692451886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QFzl1Q1pyyM4DuuxOqyyoJaMaJEA7LV10cSwcwZSSf0=;
        b=ydeKb607BviIae4m6cBOvbzuSgY5Rmb/niwHK7F9WiKdjqfY7r7hRRJLPlMFchPMdEvOGS
        WP2vpuE4QN0C/Sz5pTikGH97sbqaM7JtgauzaGx8CcrJ00D6gUcTsNoxz3CNaqWUSw1Pcz
        boBv+KVcU1ygxI1Rs7sYit0Tc5XTrlk=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1692451886; a=rsa-sha256; cv=none;
        b=PlNDE+EmU5wN+ZmX74QDZrrnFhrdcj962fDwNh5Wrl3bMSdOH+w72AnlzdY96gcL0mz46d
        60kAwWbpFdpE6vcmcjXOnD8EgiFm4Fx2GhPwZMvzqOMheADj+ga+6JlmrkbWaQDt1NbOzi
        S57Q2IG2d+ZGLhTqFrz9hzFVZNQjC6k=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/4] vhci: Add function to pause processing input from vhci
Date:   Sat, 19 Aug 2023 16:31:20 +0300
Message-ID: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add function to pause (temporarily) reading data from vhci.  This can be
used to synchronously pause handling of btdev commands from the kernel.
---
 emulator/vhci.c | 9 +++++++++
 emulator/vhci.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index ecf1db3c7..c6a5caa5e 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -178,6 +178,15 @@ void vhci_close(struct vhci *vhci)
 	vhci_destroy(vhci);
 }
 
+bool vhci_pause_input(struct vhci *vhci, bool paused)
+{
+	if (paused)
+		return io_set_read_handler(vhci->io, NULL, NULL, NULL);
+	else
+		return io_set_read_handler(vhci->io, vhci_read_callback, vhci,
+									NULL);
+}
+
 struct btdev *vhci_get_btdev(struct vhci *vhci)
 {
 	if (!vhci)
diff --git a/emulator/vhci.h b/emulator/vhci.h
index 68eae4c4a..12c4b55a0 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -31,3 +31,4 @@ int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_force_static_address(struct vhci *vhci, bool enable);
 int vhci_force_devcd(struct vhci *vhci, const void *data, size_t len);
 int vhci_read_devcd(struct vhci *vhci, void *buf, size_t size);
+bool vhci_pause_input(struct vhci *vhci, bool paused);
-- 
2.41.0

