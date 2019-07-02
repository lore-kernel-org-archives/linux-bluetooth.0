Return-Path: <SRS0=p1bJ=U7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF0AC06510
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 09:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FC020836
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 09:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="M1rBaS4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGBJHi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:07:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35851 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGBJHi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jul 2019 05:07:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so10849627lfc.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2019 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mp3ZY1Zbmk6NFA2H80XeWFYbrVsJdT8lY/Wlq0J2yjo=;
        b=M1rBaS4QLPGqStqsLt2DUr4LAd1jg0Y9ps3I4e1tH+XmZDS+XGsvMfnw4CUY3asmOC
         A2rD1MteTRN/gEXSH6DM/RASS9r7SbJuf9H0rUD1B4Zeby9QT2NM5ztmcRls7s2+6eiB
         PadkBjONSEwGvGmX+pEQaE0orKlTsx0oaVQPK4nKinbp7/0ko1lgaRAmGSUCnMWMTgLO
         hw3b7YmVHiyt/6jUQtJRKLhc+qUAqNmTsllPq5ot+TA5LmuI+BwTCsHRIYoJqLSyc1AK
         KEKPbSnrsI+6pTdazyGdatT4YekV4FnSE64W/k7M74VpQsDwp+cTbHALUX+/110h7y+i
         ttAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mp3ZY1Zbmk6NFA2H80XeWFYbrVsJdT8lY/Wlq0J2yjo=;
        b=TWjxBY6oRrxwWRmXvFwwnAIcggnF5jkLjp3E9/BGofRyXY+zHgqIolS3XgfpNWqSnx
         YjZhHDmko+oxXdHWC5s2/v3eQfgBqVTSc9YgUloJav92LiPwSWnXMiiNY0qvieGuHdyz
         ZqzAkrzERA7RZhQkMoFZxygwTW+cvOAe1e5UwAXQk4oYqlX2zTZFXSKv1Io9ESWEPeps
         vGGTJn4GXL9iaf4Imk0mk0HRfqcFYAkcPBx17mrUL6AlfXjYq/AuRpRwXiNj521SsiFS
         Gq8T1uh77kpPH7J3KuGZ4OCWHiLUAbbcmJ+7OebHf97QhouK1NEt1M+6ZG7TD/FZyBRF
         Kg+g==
X-Gm-Message-State: APjAAAVT6Lp0gQ7QBHj1hUG/bVHnjTSbjpILyMT0eRzQthMYpKBn1tLr
        sCn/IK0WfBxrj1kH4T+nWFB7SoizWh4=
X-Google-Smtp-Source: APXvYqwtVgK8e2FPhj/NFMib7PmBvgcVBaRHsEYOVLqljquv655os6n3vAG/iIkmRddxba0ohdySeg==
X-Received: by 2002:ac2:5189:: with SMTP id u9mr14405268lfi.189.1562058455700;
        Tue, 02 Jul 2019 02:07:35 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 2sm3684904lji.94.2019.07.02.02.07.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 02:07:35 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/3] Add possibility to use remote device keys
Date:   Tue,  2 Jul 2019 11:07:28 +0200
Message-Id: <20190702090731.30852-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset adds support for sending and receiving messages encrypted
with remote device keys.

This plugs a 'leak' in the API where it was possible to exchange such
messages using Send()/MessageReceived() API by using 0x7fff app key
index.

In order to allow the application to receive responses from a local
Config Server model, messages originating from a local node and
encrypted using local device key are also forwarded to the application
via D-Bus (assuming they were not handled by one of internal models).

Michał Lowas-Rzechonek (3):
  mesh: Split APP_IDX_DEV into APP_IDX_DEV_LOCAL and APP_IDX_DEV_REMOTE
  mesh: Implement DevKeySend() method on Node interface
  mesh: Handle messages encrypted with a remote device key

 mesh/cfgmod-server.c | 15 +++----
 mesh/model.c         | 93 +++++++++++++++++++++++++++++++++++++-------
 mesh/net.h           | 10 +++--
 mesh/node.c          | 59 +++++++++++++++++++++++++++-
 4 files changed, 150 insertions(+), 27 deletions(-)

-- 
2.19.1

