Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D28C001DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 04:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjGaENE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 00:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGaENA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 00:13:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9087E46
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jul 2023 21:12:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bdcade7fbso519214366b.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jul 2023 21:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690776770; x=1691381570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzUjLzohbNEhHgBw32hCU4RFlK69VEaX+mca/4cUI38=;
        b=cqOhSS/sBij9PDRjfYejlqMCmOttjH1nzfpIpAhF7nyGawe+/zG0wGIpkjL8+saQ+6
         I6ZtPBwAPOUKw4DAvJnLRxG/IucQr5RJ86VCfhbqEffGILbV1SDfwiTSjBRI5QBC1nLr
         qVWYX19QjKDvB6BHfZ9LPhStYMxwefu56DFiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690776770; x=1691381570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzUjLzohbNEhHgBw32hCU4RFlK69VEaX+mca/4cUI38=;
        b=JKOGtjGhzvWPTyl0lbIz6gBAUypmkJtmDpWczHIqcGtAh2R/2UgK0ueQ2Y7a0Hr86X
         Twgckwx8R+NgblYX9dfL0yMg/mcGikrVOVx7MpifwbWkSbIg6f6f/nlx/49Gry8Eqs21
         VRIe9oaWYf3/F9yWnp6lFcy1dsaM9MuTGqBIW6GXzZMj4l8oXuntVLwXIXUyvNYaetfs
         lGEpMrO/wrC9zfaxgnPDN4vtRFDy0WP1TIcm6v8oDpESrjeF6/Q4TP6TvMrFGrjR/apV
         UAbPBRqCG7AxdzxNXSYajwebnUPVOOvNTtinzriBZsZ3VfPI2sY4U15nkPTDUeNZ95hZ
         F6gQ==
X-Gm-Message-State: ABy/qLYiID1RwQU32jIii/MglUDNzQuRKOYo4Taboc3aJVUFxH/47x4e
        8I1LB07pEFOgEJzsCYnh+l0uyB2qdIRTzVQtH68=
X-Google-Smtp-Source: APBJJlGwYy81NXCSbnoLJwTCcIYQQ0ZM8R+Bebiy5cV3An5/WSb3scGM80Yr5oF1YdUvAYsaECSiFQ==
X-Received: by 2002:a17:906:5381:b0:99b:4956:e4e3 with SMTP id g1-20020a170906538100b0099b4956e4e3mr5419744ejo.8.1690776770054;
        Sun, 30 Jul 2023 21:12:50 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:622e:5334:a63b:c328])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906960f00b00988dbbd1f7esm5542361ejx.213.2023.07.30.21.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 21:12:49 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] adapter: Be able to use ConnectDevice for discovered devices
Date:   Mon, 31 Jul 2023 06:12:28 +0200
Message-Id: <20230731041229.1429016-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZKtfk4O=1VLoh0nb_PtR8hzJsPg53P+_q3+kAUAO+cWxg@mail.gmail.com>
References: <CABBYNZKtfk4O=1VLoh0nb_PtR8hzJsPg53P+_q3+kAUAO+cWxg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This can be useful when you want to specify trasport type for already
paired device (e.g. use LE transport for dual mode device).
---
 src/adapter.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2679d4302..17f4a637d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3763,9 +3763,6 @@ static DBusMessage *connect_device(DBusConnection *conn,
 	if (!bacmp(&addr, BDADDR_ANY))
 		return btd_error_invalid_args(msg);
 
-	if (btd_adapter_find_device(adapter, &addr, addr_type))
-		return btd_error_already_exists(msg);
-
 	device_connect(adapter, &addr, addr_type, msg);
 	return NULL;
 }
-- 
2.34.1

