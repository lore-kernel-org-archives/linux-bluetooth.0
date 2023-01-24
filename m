Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDB5C38142
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 23:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjAXX7e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 18:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAXX7b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 18:59:31 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFE747EC6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 15:59:28 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id b6so12362980pgi.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 15:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQPugu7B9HrwJq2khs0mn0gnme2ItCl7ethv33RJbRQ=;
        b=K/s17aiLl98ntUgRQYyH6STrBurKU2mJMmOdi0T3Wms+/yIWQu/faoMGYHVpG+9r0X
         +DYKHpYLDWBCoEqa7YENJjK0AW4/W57bmO3YMAVBBc9KMfSbfbAf120Q/0wy8x1U4VgF
         r7o6B99FQ0GBzI8S8l3YYU0raL/3VZ/DonFfTFHXB91Q2Bsq92xeHsNm1/xGUYFUuyrZ
         nfa2+w5/qAmndLt0Eq+KZZZMCBC+tHVBPZ/K4dDEMBgKqTZnFafcAEbbZHCKfzh7EODx
         ifNZCzEJkN8iwMq3tKmoWzrXpGEFrZf2iEz1tjkEyklOD+/w401ixFyHVIPI34rBsCeM
         99gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQPugu7B9HrwJq2khs0mn0gnme2ItCl7ethv33RJbRQ=;
        b=lZaF1qJEdZCEj8GJHVGzJyE5tb/bMfmJs36QYsQNAPECf95NBL8zFtAgl2gqozZSs0
         kMvCiRdloffF0BUK7KNg52aSTmygtZicJxOk8jlCUbcqKK17pkE9jA3qw7iQMIM1lC/x
         poQfLMXx7ij9H5fe9g114gFQoYrR0Mg8qLPV+08AqxtOoG/5X7KodW6Ox7hZX2qRCKin
         2X0gXs3NNZnOS6O6iuEzsrBDNlsItsP37MJVGqkjgSmlGVmtW0bF18P1zI8AKn1IqFJW
         s6N8DJz13TrdGbUbpJFksiCBx8zwQ1ohiOlJ4VcIxR+F18W1hDXRJOk/XDkqt0dQMmI8
         hpIg==
X-Gm-Message-State: AFqh2koJAqAqfJujbg27x6vR9M9GxULAT+9VmL8jSY2t8zYfeYXB3qow
        LjGuKqXBirX6oozb8o9DeoPe6u1uBjo=
X-Google-Smtp-Source: AMrXdXtJ9bzRb2LAMBGff6fPM4k2ntWCagGSbG4Qq+SsS4Qgxrg1Lr4yAMCQ1HoPPDyMEKeaIF1oQA==
X-Received: by 2002:a62:61c4:0:b0:581:a8dc:8f95 with SMTP id v187-20020a6261c4000000b00581a8dc8f95mr29357380pfb.12.1674604767138;
        Tue, 24 Jan 2023 15:59:27 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79883000000b00585cb0efebbsm2242648pfl.175.2023.01.24.15.59.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 15:59:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] bap: Fix not setting stream to NULL
Date:   Tue, 24 Jan 2023 15:59:22 -0800
Message-Id: <20230124235923.3623705-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230124235923.3623705-1-luiz.dentz@gmail.com>
References: <20230124235923.3623705-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the stream state is idle the ep->stream shall be set to NULL
otherwise it may be reused causing the following trace:

==32623==ERROR: AddressSanitizer: heap-use-after-free on address ...
 READ of size 8 at 0x60b000103550 thread T0
    #0 0x7bf7b7 in bap_stream_valid src/shared/bap.c:4065
    #1 0x7bf981 in bt_bap_stream_config src/shared/bap.c:4082
    #2 0x51a7c8 in bap_config profiles/audio/bap.c:584
    #3 0x71b907 in queue_foreach src/shared/queue.c:207
    #4 0x51b61f in select_cb profiles/audio/bap.c:626
    #5 0x4691ed in pac_select_cb profiles/audio/media.c:884
    #6 0x4657ea in endpoint_reply profiles/audio/media.c:369

Fixes: https://github.com/bluez/bluez/issues/457#issuecomment-1399232486
---
 profiles/audio/bap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ae944b617bb4..8f24117681d2 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -998,9 +998,10 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_IDLE:
 		/* Release stream if idle */
-		if (ep)
+		if (ep) {
 			bap_io_close(ep);
-		else
+			ep->stream = NULL;
+		} else
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-- 
2.37.3

