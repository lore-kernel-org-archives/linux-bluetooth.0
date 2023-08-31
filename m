Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD46FC83F2F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Aug 2023 22:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbjHaWBo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Aug 2023 18:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHaWBn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Aug 2023 18:01:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174D11B
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 15:01:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-56b2e689828so1042708a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693519300; x=1694124100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpto1fvv5VOSVSH/8MEKtRPaOcMR89IKnZWEThTnaCo=;
        b=saymlD5FQA3AlmqcWIaGj+f3qZEibjnxHu2WqT8zivl5fRe7a+0hGBF7YgQLqgNsRU
         9nGQhDankvQqBZFX7i0kjrJnlQ2lsYcYww/59sqNpRYexQS6XW3TcqL1E0FZOjfTM0t1
         SgKE3A50AiVxU210EOtfYwPudzirK+i45R4OiT/FgtPLhIECQKvXDjx7JEOrOeSC37E8
         K+6KcAFdhksQJ6BcfrvCpFhanF4PIRT1/nlBYm7Ju4Zdx9Yx3wieraZO1lvrgRmAtudp
         YG3Zjq7+PAYgHZ/WrLJuVoIIjeJprKT4gbG4ZjPEqGZFDTz0ai/WGJ91pY6VH20Y07Ye
         MMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693519300; x=1694124100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpto1fvv5VOSVSH/8MEKtRPaOcMR89IKnZWEThTnaCo=;
        b=hCwc3qt9yafqbHGRP/0Z4bcPaJFP1zld7WgSLGBDMdzQJzhGtLAO/ge2S8+zOus3+3
         XB/6p+wvwd6VjfmjITj5weKV3sEPbxIv8cHMji/t3F8PbO+LOw45ArIkrg6olM/JIG8A
         WMBIZ6Q9k8rJgtRyOEJUwkwj9s26s5onMxZ+h4CS4+eFykgpaBJq9GM8GBk4YqAbpYOF
         9XXvn56ttY2YEfeKjG/DLTxs6wgrqcYvXHQDO6qMzcqZ1GlzxlIN5rBWnx7NFJo5sPFc
         U9AwaPUAanRbyF8AN6cejoj2tydFHsuja7AngvA+jExcnPLtCAgW8T0JRmdlHE3V7bi2
         c1mg==
X-Gm-Message-State: AOJu0Yzvlg7N7lhVqk9OrEXMU+Dn4ZxZYnX2Y9MA2dptq+rrsRHdSiyo
        fS4/ctqCan+tO4tF4SyM0ZY+2qUIZRA=
X-Google-Smtp-Source: AGHT+IHGauIzZwKhmVJB5yIHsS0csh7C4uAey7E2qiHH4hkQRnYDwzuu+0+9zsONZrFnch0mi0QVhA==
X-Received: by 2002:a17:90b:153:b0:269:1e3f:a54d with SMTP id em19-20020a17090b015300b002691e3fa54dmr619473pjb.10.1693519299993;
        Thu, 31 Aug 2023 15:01:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id fw13-20020a17090b128d00b0026d4100e0e8sm1760685pjb.10.2023.08.31.15.01.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 15:01:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] bap: Fix not always calling bap_io_close on disconnect
Date:   Thu, 31 Aug 2023 15:01:37 -0700
Message-ID: <20230831220137.1164891-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bap_io_disconnected was getting registered for all links while
connecting which prevented bap_io_close to be called when ISO socket is
disconnected thus the cig_active flag will remain set preventing the IO
to be recreated.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 001a47bdc47b..9634ae4fc6c3 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1936,6 +1936,8 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 	if (!ep->io) {
 		io = g_io_channel_unix_new(fd);
+		ep->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+						bap_io_disconnected, ep);
 		ep->io = io;
 	} else
 		io = ep->io;
-- 
2.41.0

