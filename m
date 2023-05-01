Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27DBC77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 May 2023 20:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjEAUDj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 May 2023 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjEAUDh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 May 2023 16:03:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C24E26B6
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 13:03:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaebed5bd6so13277445ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 May 2023 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682971410; x=1685563410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8jc43J+oF1ouWCuHyNTyI0g5hAkSGiD9T2/GzAsXmw=;
        b=pzIRM9gTtOAoxhcrC0gIG5nAcK6pCygLbOGMrfGNZ8DkZTo7dFJahvgol+1TrBsY6C
         fwvmzoqI/9oOkTvTlsYTwjEDANga5UYDVjuERuh3LXrxRhUnoMqD2HkdOHmVQ6RM0yi0
         jOt87vyVsC7iy6g1h2S0scVdX3SELDT4EkO3h9MBH/KmRNPAoOqVPjK8H0atT9cWzQCD
         TeHcUREYyH+BhKvaHfqMqUbbOUBviTCjf6Y/4JX1qd7gALnnvvQJz9MB30iyLPFllu6l
         9jVQMMsXU4ykGyLdKm481+b/uX6jW0FaKlE7sImpI8UOqtQAEKDxlb+0LGc3j3Rt1owu
         LR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682971410; x=1685563410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8jc43J+oF1ouWCuHyNTyI0g5hAkSGiD9T2/GzAsXmw=;
        b=DoLcAM0eRJzVvEtQqTVIwb+dQnGEES+ZwoDAZw4KE/Jlo7hHiVodTK2XpCHB2yIkjU
         J+UEg/Jmcm19Q5LKfpIBgVeP3I50RYBlcD2QoqLurvmjmLPNT9m2HDMKnUPTJHhPsccO
         ai3LbSrgXMHWi7PqIjt3P4GCTV8KT+3qMixJq+2mQJ5V32LtBp/6EKGdO6Ky7RMfpfp3
         C8ABu55uBEuRlV3NIIAi//fTyyV2HBecsfkaot2/PMuziWxrZQzt6KO3arMVqsSiIA1j
         MXr1DXoDTbpSO9rnbnbEqKmr1UCFLTnXuKYRWhw7LMOs8HCbKh1R3DwNTqzthdhlNwGu
         Q2+w==
X-Gm-Message-State: AC+VfDxQV6myhAv+Jx4tPvQRzLnq8QMHHX5ceIcdNJp1AoKrROlOfd6C
        a1XGBYqSzdd0/ijXckknbNkO0Ew2Ul8=
X-Google-Smtp-Source: ACHHUZ7pkCxD7QeiiNxKBlaHmmqKNggnOB4EN6ImZf+J463tliZ14RmEBtHT1jZqu24RssUON/Zdrg==
X-Received: by 2002:a17:902:dad0:b0:1a1:ee8c:eef7 with SMTP id q16-20020a170902dad000b001a1ee8ceef7mr15718082plx.48.1682971410195;
        Mon, 01 May 2023 13:03:30 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001aaecc15d66sm3037514plb.289.2023.05.01.13.03.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 13:03:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 2/3] client/player: Fix crash when RegisterEndpoint fails
Date:   Mon,  1 May 2023 13:03:25 -0700
Message-Id: <20230501200326.1056736-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230501200326.1056736-1-luiz.dentz@gmail.com>
References: <20230501200326.1056736-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If RegisterEndpoint fails when there are multiple adapters it would
attempt to free the same endpoint multiple times.
---
 client/player.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index cc35721d85b7..7719076c8cfa 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2028,9 +2028,11 @@ static void register_endpoint_reply(DBusMessage *message, void *user_data)
 		bt_shell_printf("Failed to register endpoint: %s\n",
 				error.name);
 		dbus_error_free(&error);
-		local_endpoints = g_list_remove(local_endpoints, ep);
-		g_dbus_unregister_interface(dbus_conn, ep->path,
+		if (g_list_find(local_endpoints, ep)) {
+			local_endpoints = g_list_remove(local_endpoints, ep);
+			g_dbus_unregister_interface(dbus_conn, ep->path,
 						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+		}
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-- 
2.40.0

