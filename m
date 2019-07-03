Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6F1C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092E721897
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="oTRAOxTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGCHRE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:17:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46807 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCHRD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 03:17:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so1183891ljg.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B8Zkh3mNDdOpw0jIt3tQhu0ugaNbqE0N5/0eIGnZgGQ=;
        b=oTRAOxTittJEKicG8zry7F32LHp/y0/pzVCHxZY1wT+H3pGgKRHPzPNV80yTjlNBmq
         WcOEm9CqIORxssZD8oQLOm53/8GT9GyW1YG7BORiQvkd91mPj53ucOVuSZFdB1YvsIPc
         BzRHFTDvi8JcUENWpMW/lIu55VauMV/epmXs/ypubLDB4fcJ8dIkFOJoQ1RIDICqv6g9
         M03ns3Jx4jQNRoJdy6n+MclQ8nIvebz+tqVCKIKgjV96OXb1c7q5iFezA8a2+4lfDZG/
         qCFurQV0oMlpDDLYhLggSogHC8Ce78DEu5Uvr2MD51juoegSJ2Iqo6ra0qgyQYYKapbE
         NOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B8Zkh3mNDdOpw0jIt3tQhu0ugaNbqE0N5/0eIGnZgGQ=;
        b=fj8pREYxEs+PLSCS0ugtgesI7dZP/X3c70BDbNnQaeE4x2kE9RV9yhOUu/WSQflmgR
         t7jQeJtdEgj5BgTkHDND1Itg8cEkkRCfGxkUTIGwlXnsthUMPFu9zft7U5rYK3YUnTV9
         tXxo9UoRxchdSJB00Ehckd55dsjWb7bGg8l7rJ1oLGCZiWEyyTHrEITvcmhoYFFJDOUX
         MlRo2/Z0DdqPohScXX5G4XeLeQWaYt+keZUBOr5tW66chyR7fHw3+4vlt7wBFUxdUP9u
         jZTZc8fqYqeDS32WzNpJtn/jcl0wQK0AZC6RVZyWWPBA9K2qeITRBkOD2KeINGK7IqNM
         qYrg==
X-Gm-Message-State: APjAAAUgZyXB1CpP/xCKwao77HsF7ZHmjYi8XBDUzcSH2tJffcq6g8kk
        OrgrFIAQVU33U2oaVrBiIyyTCMA+9zY=
X-Google-Smtp-Source: APXvYqxHjmPv+n9PtLRgXfn8EkW8cY46ftO4OLYhkwcc3MX5rbWAvtUUCFlUbkkXOFICsfiqHUSWeg==
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr9802300ljk.70.1562138220491;
        Wed, 03 Jul 2019 00:17:00 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id l11sm281364lfc.18.2019.07.03.00.16.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:16:59 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/3] Add possibility to use remote device keys
Date:   Wed,  3 Jul 2019 09:16:53 +0200
Message-Id: <20190703071656.6342-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+Fixed build/checkpatch errors
+Removed unused APP_IDX_NET and APP_IDX_ANY


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
 mesh/model.c         | 96 +++++++++++++++++++++++++++++++++++++-------
 mesh/net.h           |  8 ++--
 mesh/node.c          | 59 ++++++++++++++++++++++++++-
 4 files changed, 151 insertions(+), 27 deletions(-)

-- 
2.19.1

