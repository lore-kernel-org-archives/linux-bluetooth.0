Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0555C7619A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 23:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjC3Xoq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 19:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjC3Xoj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 19:44:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFF4E38C
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 16:44:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so21528650pjt.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680219867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F78JXfAwrKp6Pn0PtyxENZKreopNlsuPAD3ZyN3Ps94=;
        b=ZVkowVE4zTfSrKikvjxSBqDC+Nur3HyiTzwuMGW1wyHRbUBWHwXwQIQsVxDxtDm67K
         Ohd8spy7y7NnMtodSmD7/ysVWIVgS/PouDqmhfrt9p8lPulbLlEXrtQObtE7RYxB6m4a
         rD5wlVsRBFXi/r/zzKU7ZlusCHz6moSPDvcGtU/eHBnskC0PnVojpct8w9RLRAQB3rBC
         Nu7HHQ9qHmrx8zgwh1NHiDIhRiZutAxxs/mP6BsS+QYqKf1wTtuUBNyERqUfCL14fhqu
         Jq3KUsKoVr+B9ejbvHwvRTdOiQXBSpmoZJBDnLDljtNEkMSuylKtE/ujWGczv2oLZwmF
         Eu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680219867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F78JXfAwrKp6Pn0PtyxENZKreopNlsuPAD3ZyN3Ps94=;
        b=NUG4EXdCk3HPl6Q/PpQUVPhGz1RePUzmg0Qwp9ggmyRgbmlxylKOIe6hZDnu0MxdWD
         MlaS5fxM7DpLFc6lxZy/cOI/CB613AbfhO7BLruGwAefbVE7eaCayKKpMi64+4DZG7c1
         caHzjurpQeV2Ni0SGm1I7E6dWhNH5rTTJB1DRWx8imJHRALI7E7IR45IG7gAd950cfIE
         ZZfNzPw5azsgqTaFnnWxPGtUOfL9YdDgCkSyBl3LizcZqRGv4uruoO/H983BEBKo2psT
         mZRaf8bxPi7lj77uwvXJsx/zP6AFYXAcsMIczuU63YoGkqiyAWA9gbGnO1TW+lKek6cA
         Bryg==
X-Gm-Message-State: AAQBX9c5XejF5AsQQAcqx8t19iW3ZRUqY1hwMEIw4Uvk8lLOrEABu6dH
        wNnbLt2/3r72JxbDpwAtGjT08GWIeIk=
X-Google-Smtp-Source: AKy350YH1u1n0kYLHJEj2Xzg8olA6PotKn0mcvK1mTZqtYLv3j9Zyw3hjOJJOEZAW0o54UjLlndDAA==
X-Received: by 2002:a17:90b:4c0c:b0:233:d12f:f43a with SMTP id na12-20020a17090b4c0c00b00233d12ff43amr25397356pjb.1.1680219867026;
        Thu, 30 Mar 2023 16:44:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id mh11-20020a17090b4acb00b0023cfbe7d62esm9005622pjb.1.2023.03.30.16.44.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:44:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] avrcp: Fix crash while handling unsupported events
Date:   Thu, 30 Mar 2023 16:44:25 -0700
Message-Id: <20230330234425.1064422-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following crash can be observed if the remote peer send and
unsupported event:

ERROR: AddressSanitizer: heap-use-after-free on address 0x60b000148f11
 at pc 0x559644552088 bp 0x7ffe28b3c7b0 sp 0x7ffe28b3c7a0
 WRITE of size 1 at 0x60b000148f11 thread T0
     #0 0x559644552087 in avrcp_handle_event profiles/audio/avrcp.c:3907
     #1 0x559644536c22 in control_response profiles/audio/avctp.c:939
     #2 0x5596445379ab in session_cb profiles/audio/avctp.c:1108
     #3 0x7fbcb3e51c43 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
     #4 0x7fbcb3ea66c7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xaa6c7)
     #5 0x7fbcb3e512b2 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)
     #6 0x559644754ab6 in mainloop_run src/shared/mainloop-glib.c:66
     #7 0x559644755606 in mainloop_run_with_signal src/shared/mainloop-notify.c:188
     #8 0x5596445bb963 in main src/main.c:1289
     #9 0x7fbcb3bafd8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
     #10 0x7fbcb3bafe3f in __libc_start_main_impl ../csu/libc-start.c:392
     #11 0x5596444e8224 in _start (/usr/local/libexec/bluetooth/bluetoothd+0xf0224)
---
 profiles/audio/avrcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 80f34c7a77a1..dda9a303fb71 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3901,6 +3901,12 @@ static gboolean avrcp_handle_event(struct avctp *conn, uint8_t code,
 	case AVRCP_EVENT_UIDS_CHANGED:
 		avrcp_uids_changed(session, pdu);
 		break;
+	default:
+		if (event > AVRCP_EVENT_LAST) {
+			warn("Unsupported event: %u", event);
+			return FALSE;
+		}
+		break;
 	}
 
 	session->registered_events |= (1 << event);
-- 
2.39.2

