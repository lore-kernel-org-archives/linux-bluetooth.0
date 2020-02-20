Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FAFC5ACC4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBB021D56
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQBY2Ifj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgBTA2h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:28:37 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:34018 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgBTA2h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 19:28:37 -0500
Received: by mail-pl1-f180.google.com with SMTP id j7so810904plt.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2020 16:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIpwUuffQHTqZM/RXQAXvfjnVggdrcZ7xnQhEPrhbJY=;
        b=TQBY2IfjmL2eKNKb1y4AOrgMHde/ybP0uuwYbnxh0FF3LUNi5bQtR9+ICCbNEqBy9X
         pZKfHjweg2R2MoFUiD47qLZTGMyfiH0ynQKfEaYdOU3d6XWppTcb5I6xBtqtcmyRNWz7
         xt34QmOJ0vPnN4nJr/AixWNdWY9ROJTw44eu6/DXGxTS/5WsOnKPKAB8MSSS3S00usIq
         UDsxOOwsczm9s3gd8o0qD/BisdDqLKQHhS3+WsIn35UpPsSUxrlNBXEDEh3KliI9Qvwm
         k2MTG47ymeNR+QPFetw7DkkLd979Lj8jCe6/TJasX4+i7vdHcdmaazoBf1qyWeELB1zM
         HRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIpwUuffQHTqZM/RXQAXvfjnVggdrcZ7xnQhEPrhbJY=;
        b=q2TgWZVclAlZDo61EC8cBi+uIWC0QtuX5kgPOs81I4hw5i58r+X1XdZBWj8hCHnjvM
         YHW+SEpRwHVozaJJ7fBzqEWQAG1+gTwDRqiH+JAm/JQhzZRudIDeCSyvgVM9uKgr6UoT
         g90VEAaQGvCwBON8DMGX5GWt53mC/Ict3vMaY+Lw4rOYyIZqnNSjSz68zN5OTLWAuL+8
         E/29IS+bgQLUIpPJrUqJhYEqtPTsu3G53oQFqJcIeLAeQeHIE5LmpEXaynI/0eDK+9Dm
         56+duDlwimeLkJJxz5XHHUcaH5bs+eNXdTpO52Gfv/2Od5UbwVGVoEW6SgGsPLeUg75e
         hglg==
X-Gm-Message-State: APjAAAUqhc3vA35dMLHD5mr0NLw2siVZVP84e/lbGupoplbVh5wuRwaU
        afWagSuChkKHDn/Nfd3bX5vGICehpEQ=
X-Google-Smtp-Source: APXvYqybMSmozGW6xS4KlWX7/fsswUVlstQnWJHEijjIkZJrIqrSg0920/uKPaEyiEB46dKv/6PxLg==
X-Received: by 2002:a17:90a:fd85:: with SMTP id cx5mr407344pjb.80.1582158516311;
        Wed, 19 Feb 2020 16:28:36 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id c68sm769213pfc.156.2020.02.19.16.28.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:28:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] doc/adapter-api: Add pattern filter
Date:   Wed, 19 Feb 2020 16:28:33 -0800
Message-Id: <20200220002835.8929-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a pattern filter which can be used to filter devices by
address or name prefix which is quite convenient on a crowded
environment.
---
 doc/adapter-api.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 2afd61bc3..acae032d9 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -119,6 +119,21 @@ Methods		void StartDiscovery()
 				if the adapter is already discoverable setting
 				this filter won't do anything.
 
+			string Pattern (Default: none)
+
+				Discover devices where the pattern matches
+				either the prefix of the address or
+				device name which is convenient way to limited
+				the number of device objects created during a
+				discovery.
+
+				When set disregards device discoverable flags.
+
+				Note: The pattern matching is ignored if there
+				are other client that don't set any pattern as
+				it work as a logical OR, also setting empty
+				string "" pattern will match any device found.
+
 			When discovery filter is set, Device objects will be
 			created as new devices with matching criteria are
 			discovered regardless of they are connectable or
-- 
2.21.1

