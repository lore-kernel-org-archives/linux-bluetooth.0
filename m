Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A55DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343346113B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhKEVP3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhKEVP2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 17:15:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4B1C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 14:12:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso4236185pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FmAlti555ldAvkBkqitSOTT11RXzmUOqFhA3gOPv/ps=;
        b=X8wL54kvrjl9V9KnXZ0ZDPWGNV34EePJm3N5Smo42t5enDxz/TvIrixkxKyxz8faxI
         ESbNPgdbkkX3NMaownFfMPP36ZhlCcef4fDHjlIIhnOOOKwExZAOlkdXG+VHJi/V8lAL
         h6J+WBrCRRfKPeOdZbI6NXGjoyG3aPqC8sdefDUL+Vbt5nTnBImT0ehZdQEsBdMpi1uF
         sctXTtYJCNB3nCOeARTRiljw4TrZSkc6Rwq270wsJJvMNSPtDDwj+al2j/eLBUQ9VQgv
         V2zTBgF7jKjbyZUoz396BY8IT3dZxk6tLn/t1ys8SuRiFYejMXHlQy376HP8LRtmyW8W
         ehGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmAlti555ldAvkBkqitSOTT11RXzmUOqFhA3gOPv/ps=;
        b=nfUD/0Gtju/VtrIWrdIVNmkmthRHRLJ1i11XowLNHm/bWwHlIdbrbfyXYtZuYtltzf
         KDANaaLx8WLkpJaHviVxw6Xfi04+bbgcUy3pQPKcN90Z3YmVZHIvzdFCjh135Tq888Mc
         TtMSthUSdL4w+eSfJJaJaMUwnSphTIxsn83+Tg1ugzVgwDYCdL2AicSEvRY5QO+GuHBT
         3lZaofawUo0opyVSkNyhdWnPQ9aIH1HeybD3nelR+IonxIcUjiBNNyUK+NwIPPeW4ijF
         7RWs5TZMMOeSEDsBRq/qRo2vrnmOhbe1IOPn/V5AG+6Gqa/jTtmZwCBaA4kRsi3Ya2MM
         hkBA==
X-Gm-Message-State: AOAM532Hp7Tk46DQkBjZayNGFsiPHsfHo/0OMr4Rr6AtSBwLNgsLorJt
        ZA35HaYs0+yYF1oOpnTS+jAcGLFq9gc=
X-Google-Smtp-Source: ABdhPJxNA44GWdLZPSbsxoioMCmfGwizKeQ2CHA/1A21+7Ta2BwzkBIlYpHsJAuxB3I5RIKvzFahig==
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr14089886pjb.173.1636146767825;
        Fri, 05 Nov 2021 14:12:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id om8sm2250553pjb.12.2021.11.05.14.12.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:12:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] mgmt-api: Add new Device Flag to use Device Privacy Mode
Date:   Fri,  5 Nov 2021 14:12:41 -0700
Message-Id: <20211105211245.424024-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105211245.424024-1-luiz.dentz@gmail.com>
References: <20211105211245.424024-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a new flag to Get/Set Device Flag commands so it is possible
to set the Device Privacy Mode which allows to connect when the
remote device uses either identity or random address.
---
 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 97d33e30a..b7a152c14 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3421,6 +3421,7 @@ Get Device Flags Command
 	available bits:
 
 		0	Remote Wakeup enabled
+		1	Device Privacy Mode enabled
 
 	This command generates a Command Complete event on success
 	or a Command Status event on failure.
-- 
2.31.1

