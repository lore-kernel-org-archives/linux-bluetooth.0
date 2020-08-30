Return-Path: <SRS0=5eoE=CI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4A3C433E6
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 07:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB63520936
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 07:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr+rVnkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgH3HLl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgH3HLf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Aug 2020 03:11:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3237CC061573
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 00:11:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a17so2060132wrn.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 00:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCdC5l7MREtg/ugmoGf85Z2/cwwaQHZeoBGEOMxfvgc=;
        b=Tr+rVnkg4t7qOxr7VdTQIopxqLZyAasAg3WSVd30+jEG5nHBq2wj/KGYaaIzUXgdeA
         JgTs7s3eyax/jGBSXkkcVNsdHPv5OJD6P6vrYU3Y4DkIjxgm6BhTwwNLtOF4ZSjOrEG4
         P1DDs2qB7U+9x63+LW6/ZYQPRhe+SswUvJpYLjrmFOYNouUV1s2D8UT+irTw2iBVwXU1
         FHgkQxcaf/fTJR5gZsZpezet6J142IVZGOLrxBy46+55jZL/K1ZSYLcpoOijHIxGEacR
         paNHEKszsJ9WD7WE3Tmyhl5JwKarWCkE8J12jUSMROoCfamo/QfQKKPyA0RmOi7pMVnJ
         jmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCdC5l7MREtg/ugmoGf85Z2/cwwaQHZeoBGEOMxfvgc=;
        b=oDjAdwbmbTydlT2vbmV4EP9Ho/DNRczwvtL7a5ES/acHS3jp8YN/AHsTcgRQRdARgS
         HdtEReAljMTIKPfwE3ciisgWbg0FHJnYx9YpE4+pgXnHjR41h8laO/2Zt/EZteEOCkTn
         uz/P5lmzop0Kp+3t7uCED62nwHS9VojZoMbWE6iWa11rw8qp6UuS8bmIJ4Tsd2M46crI
         BJ8TdoLwu8tlzuHtrxSAT0j+uAxzRYbCjIMVaV+tL125tW40Meld/zq3beSB1MuBsvRQ
         +9l9MUneMFvEy/geCFI6BdOtDGtZxOn2ITmWYG4cJW8UkcWgLGuL9kqZ0ImvyyGf6gql
         sSqA==
X-Gm-Message-State: AOAM5315N6S2Iwni7D1Ud6y3VhBy5pHkcEchVL/tZaUIbC6uu1n6oOcQ
        x8os0CJtxHJ5sOwwUP08DCyrG77JMiA=
X-Google-Smtp-Source: ABdhPJzkZCrC/TulrKpkoBpTnlokBgyq2VvG0wu643WMfA1aQirRg9AHhBwhumeBZG/SfWbUekgWZQ==
X-Received: by 2002:adf:e504:: with SMTP id j4mr6468060wrm.205.1598771490976;
        Sun, 30 Aug 2020 00:11:30 -0700 (PDT)
Received: from thinkabit1.lan (21.81.7.51.dyn.plus.net. [51.7.81.21])
        by smtp.gmail.com with ESMTPSA id h185sm5197859wme.25.2020.08.30.00.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 00:11:30 -0700 (PDT)
From:   Barry Byford <31baz66@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Barry Byford <31baz66@gmail.com>
Subject: [PATCH BlueZ 1/1] Fix typo in bluetoothctl
Date:   Sun, 30 Aug 2020 08:11:08 +0100
Message-Id: <20200830071108.19777-2-31baz66@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200830071108.19777-1-31baz66@gmail.com>
References: <20200830071108.19777-1-31baz66@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 client/advertising.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 94eb616b2..1aa28e749 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -185,7 +185,7 @@ static void print_ad(void)
 					bt_appear_to_str(ad.local_appearance),
 					ad.local_appearance);
 	else
-		bt_shell_printf("Apperance: %s\n",
+		bt_shell_printf("Appearance: %s\n",
 					ad.appearance ? "on" : "off");
 
 	bt_shell_printf("Discoverable: %s\n", ad.discoverable ? "on": "off");
@@ -886,7 +886,7 @@ void ad_advertise_local_appearance(DBusConnection *conn, long int *value)
 					bt_appear_to_str(ad.local_appearance),
 					ad.local_appearance);
 		else
-			bt_shell_printf("Apperance: %s\n",
+			bt_shell_printf("Appearance: %s\n",
 					ad.appearance ? "on" : "off");
 
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-- 
2.25.1

