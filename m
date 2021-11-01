Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B8BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 13:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EF860F58
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 13:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhKAOBH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:01:07 -0400
Received: from tropek.jajcus.net ([31.179.132.94]:40598 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhKAOBH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 10:01:07 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 10:01:06 EDT
Received: from mietek.nigdzie (tropek.jajcus.net [31.179.132.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by tropek.jajcus.net (Postfix) with ESMTPSA id CEBE98506F;
        Mon,  1 Nov 2021 14:50:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jajcus.net; s=mail;
        t=1635774610; bh=LdrqYU2ucjDdTXynGHPrF6Vyu0tPgh6uOemNw1NI1W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QugBqUkENZteh5LGnLnncpD41VNK9nASvyNV0ToEIy/Yd+7K/64Qhmuoy3lro4jIp
         Ry+Wzev87EwGgg9+qfPpufnjep37t/KH87wWaxWgJbE2pF5waybzLYYPFzmCSZLpzD
         Y4+QOVWZ5WVrPX5eU7GZYpqi9fmGoDgHpyjce2Mc4rxThshrs95PHEUkHYMsrXzGqe
         uPMFtTTAJ7SKEFKZrKmZSQb6t08l0PxDaPZr3VFLCzr1ofM57DAlPh5ymJK1EtsYuN
         y5gbsPSjdZaSKWT+cYmbfurmheMyB6rDK8HzktcXIDb1P3qc3zmEKa0HrBVTn4peFP
         eZDoVH2eiJHsw==
From:   Jacek Konieczny <jajcus@jajcus.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jacek Konieczny <jajcus@jajcus.net>
Subject: [PATCH BlueZ 1/1] Free ALSA seq resources in midi_device_remove()
Date:   Mon,  1 Nov 2021 14:49:18 +0100
Message-Id: <20211101134918.69565-2-jajcus@jajcus.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211101134918.69565-1-jajcus@jajcus.net>
References: <20211101134918.69565-1-jajcus@jajcus.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sometimes, on connection error, this gets called and frees the device
when midi_disconnect() was not called which would leave ALSA sequencer
objects leaking.
---
 profiles/midi/midi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
index 737d1b5f6..f644d47e9 100644
--- a/profiles/midi/midi.c
+++ b/profiles/midi/midi.c
@@ -255,6 +255,16 @@ static void midi_device_remove(struct btd_service *service)
 		return;
 	}
 
+	if (midi->seq_handle) {
+		midi_read_free(&midi->midi_in);
+		midi_write_free(&midi->midi_out);
+		io_destroy(midi->io);
+		snd_seq_delete_simple_port(midi->seq_handle, midi->seq_port_id);
+		midi->seq_port_id = 0;
+		snd_seq_close(midi->seq_handle);
+		midi->seq_handle = NULL;
+	}
+
 	btd_device_unref(midi->dev);
 	g_free(midi);
 }
-- 
2.25.1

