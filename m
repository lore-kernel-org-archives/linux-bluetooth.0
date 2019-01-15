Return-Path: <SRS0=18cS=PX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3DFC43612
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B90620656
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtIouQna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfAOOMh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:12:37 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:35892 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbfAOOMh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jan 2019 09:12:37 -0500
Received: by mail-qk1-f178.google.com with SMTP id o125so1609873qkf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jan 2019 06:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=NRmMcQTyCPGDFPiIwwvQcbTId6WBr1vJLCM1OYszSog=;
        b=DtIouQna7sPhAC3evc45w2n0XWOXzQnWIBZDTND3Oe+N8mJimltHVot8V8WvlPJH5V
         kNdrj5Jq6Iq9eGgWIIRzQmuMUZjyDPL43sxxH6IBL+rXE7RxkxWz1yIPLBC5regCUq89
         wUSeABcAXSn+liZis3q/eeffdaVBclERt7c5o2ynyG61SKNeLi44kYp0k5YUzP158Exu
         U58Vmn/1mo47pkBrEHvI+4xfH/TSqojctu7xy90u5dk1GZW42K/h6zDTdN7386EgTqk0
         AxgedHNdAke+dGNxqBIRnZU7w1HjSoQPo6KfEnI0JtaLc0PltpaAfTuCGX5azlsUO/tr
         2/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=NRmMcQTyCPGDFPiIwwvQcbTId6WBr1vJLCM1OYszSog=;
        b=ETZ4zcouAeNefO+EMrgjkO/jLzzCPLwG9BJM+ATcK6SkYutZ5bsakjNtPr09wVn0NU
         HJS7YztU48nhwLU8Wi8UlsP3Jb8oZf+E0609jG57X8o1CRgkmNdRzGfb4OgMQ5jmYRPX
         p9Az+qYenYfDr2T5fsyuwq0aCRxlh9IT07/HT0Mpqe/eJvP7J508AOUl92Uh1iLvOJpn
         tQ2C8hJOHa7GK/Ab8WkE09S0fg9dolkV5McFXE+NdjqUwoamzywyedJDxlSYTkXjzfVw
         fTa/vyznwR30S0613ZDvB0cieVPt2nMMdjVn62LAxpxSB8w+rDDEozP7CaAEEQi4vRjf
         2K0A==
X-Gm-Message-State: AJcUukeOv0wdCcnaZNzi7CpiKhIqj8edyRy8Wabs5cNqShF8MtMtjG+R
        S1SwvcKlgFRD/yWLtGKkfcr9m1itIhY=
X-Google-Smtp-Source: ALg8bN4HduCxQR+im0n4dpskj8I543aCbnHgvC9+VrGxeTsgpxd/Ew//CcHkZ7/PPzTr0B1yO65yiw==
X-Received: by 2002:a37:9a89:: with SMTP id c131mr2865775qke.173.1547561556000;
        Tue, 15 Jan 2019 06:12:36 -0800 (PST)
Received: from localhost.localdomain ([186.206.5.228])
        by smtp.gmail.com with ESMTPSA id l95sm10572580qkh.37.2019.01.15.06.12.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 06:12:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/8] doc/media-api: Add Device property to MediaEndpoint
Date:   Tue, 15 Jan 2019 11:10:22 -0300
Message-Id: <20190115141023.353-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190115141023.353-1-luiz.dentz@gmail.com>
References: <20190115141023.353-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Device property which indicates which device the endpoint
belongs to.
---
 doc/media-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 292e9034c..bca8c9563 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -556,6 +556,10 @@ Properties	string UUID [readonly, optional]:
 			Capabilities blob, it is used as it is so the size and
 			byte order must match.
 
+		object Device [readonly, optional]:
+
+			Device object which the endpoint is belongs to.
+
 MediaTransport1 hierarchy
 =========================
 
-- 
2.17.2

