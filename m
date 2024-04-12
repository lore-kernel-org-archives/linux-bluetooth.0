Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F914F9E9
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951773; cv=pass; b=H3hX+ziTNCMbYpdgHk9VVbeEz8T7e249uVEmVPlvuXCUpEiN3BBK9Q/kLBfl5KhsJI9AFmswtx3OyJRpFyj9+mHPFNwxmmm8kJnd20+hekUvQ4MjTYKlfStD5CjQeyfg3uDajVc/Ee1JE99YYPzmvzgrQyl06Nplo9l4c9Y81d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951773; c=relaxed/simple;
	bh=gE+UHnx0YPjUC0wvCFUT9AB8n9HVLyj972V05NZoFvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6LKz4wxAWCj0wEroET7qY2U/fl7Bu3i54zhYZeZ3Lrfm2pKW0bsQtNvjspSnLsw6bTFaHU08ynhpV1RSPgU6e7UN/cstKdSFj8HRVvoI6X49UY8gtVKKTjfCGU7RST9ZO9N/3Dv/jdj7f0ctVM5KFsWjNyAc/DuEML6rdvfajo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=FOg41G5c; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="FOg41G5c"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VGS430GNyz49Q3T;
	Fri, 12 Apr 2024 22:56:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712951763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKXYvvaT7qFbssRo2MwF2eEWFSmp2R2fhKw7/edvDZU=;
	b=FOg41G5cdbiYu+rbLljeVxBFucC/ieGtfvjsVWYLzYOD46c5BW03M/6jwgpcAJukVfGL7i
	5pS9xkfo/yvt1by665GSO9ptjEq5K4ANQvHmIKjdtButLPnALOV07cFhZZDdMqOyiaRbKN
	JD8UPGSvYioA4d1ewIbC3cVyXNebBj4KopOA63aCXLuWmtfPM/Y1FflUPcPbnayE2/Zcwa
	EEMuO+hxaURSxsChzcKxQ518h3ZUVeMjJvXXrkbKCfsztDE97peC/cgLI7FAUmdObSRbLH
	HycUn4+pVQY2Oceuegq2iOtutx2th8AySHAx7iuU4Lnq024RZTKF4MiEiswyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712951763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKXYvvaT7qFbssRo2MwF2eEWFSmp2R2fhKw7/edvDZU=;
	b=u6dlI47sQtaNhzIePzRgdKzoLKtEKHCLb5VpXns0YsvRc1dWIzwutloD+wuL6WZxcY16n9
	GhyYEL7dXvwn5ZBWSBQzwyS0505TozG+uwMGeNvlDIGq2rzy3p4GT3KUT4jTwqk0k3XPMH
	gLOqZasViQqQ2JhDOVesiMm3mccvLFDfJQunPMcuUo/N0rYI5ISSNzMVIONeAEZyDZ2eB2
	Grxkog2phVCw8OFHRR/jOXNjKB+O4m8OkH9QcGblSI4/ZQvazFaJbk1l3EFyu3Nl+y+mZQ
	/SUfEG9gy6F2z+HYMXlurr2J9UJnQPWfbye0/XYGB591zEmIgE3rwcIdHDWPRA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712951763; a=rsa-sha256;
	cv=none;
	b=UphiOmUipsODgfNpUXn7bZcllVmZrqaEMj4yeCKQMMyX4NNoOyN/savlhWniidHvOLaRep
	7ANdWESdVUwlll0Kc7r1i6ON9ecGQe0tNyGDV+2dPdfDtYnpSZv4n/wuLlMCQif08Hrijs
	t8BA6waDH753xvlqCV0o5YEmIcxoKA53vlvmTdqcUv/SzrallDg76zGdl7ctxXDKXSofIV
	rRAmGjQdV62twnX0Q3Lo3jgSuMWe+7vBnsM/r/+dV8ZSyv0BKNJ0YrB4uSybR4fIwM4Xzt
	VLlstgt4w3pG4duURLFKhEOEQ2zFFb1/ioRfYUla+nfWRIG9ahN/erc7EJoTPA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] bap: cancel stream operation before freeing setup
Date: Fri, 12 Apr 2024 22:55:56 +0300
Message-ID: <faff5310d5070cf3a64e364b3159672e696625b6.1712951445.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <d52ddf4759720a2879677fca0129d3fd1a32dda0.1712951445.git.pav@iki.fi>
References: <d52ddf4759720a2879677fca0129d3fd1a32dda0.1712951445.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before freeing setup, cancel any ongoing stream operations, and indicate
failure for pending DBus replies.

Fixes:
=======================================================================
ERROR: AddressSanitizer: heap-use-after-free on address 0x60d000004758
WRITE of size 4 at 0x60d000004758 thread T0
    #0 0x557159 in qos_cb profiles/audio/bap.c:753
    #1 0x89c38f in bap_req_complete src/shared/bap.c:1191
    #2 0x8cb7fc in bap_req_detach src/shared/bap.c:4789
    #3 0x8cb9bb in bt_bap_detach src/shared/bap.c:4801
    #4 0x571e25 in bap_disconnect profiles/audio/bap.c:3011
    ...
freed by thread T0 here:
    #1 0x558f2b in setup_free profiles/audio/bap.c:890
    #2 0x7f34e8 in queue_remove_all src/shared/queue.c:341
    #3 0x7f0105 in queue_destroy src/shared/queue.c:60
    #4 0x55cdc8 in ep_free profiles/audio/bap.c:1167
=======================================================================
---
 profiles/audio/bap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 30049f0fb..ff6d6d881 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -879,9 +879,22 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 static void setup_free(void *data)
 {
 	struct bap_setup *setup = data;
+	DBusMessage *reply;
 
 	DBG("%p", setup);
 
+	if (setup->stream && setup->id) {
+		bt_bap_stream_cancel(setup->stream, setup->id);
+		setup->id = 0;
+	}
+
+	if (setup->msg) {
+		reply = btd_error_failed(setup->msg, "Canceled");
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+		dbus_message_unref(setup->msg);
+		setup->msg = NULL;
+	}
+
 	if (setup->ep)
 		queue_remove(setup->ep->setups, setup);
 
-- 
2.44.0

