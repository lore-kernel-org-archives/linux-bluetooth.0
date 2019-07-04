Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FDCC0651C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 12:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA652082E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 12:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="i1n5EjwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfGDMdq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:33:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42990 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfGDMdp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 08:33:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so5988576lje.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2019 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U3doyi/oIBgrWoo6lZoqBf/FoW6Brbnlh7rxX+qhdko=;
        b=i1n5EjwI7BaD/0KEJc19WE4SYCU3oVzyqpx25zbKDL5kTB4+6fY3S5oTLYRw4rrEmP
         b7CHpfN5o5EURn8Il9W+vt1fgiKS+d4F+kRdT7TtT0UT+TqB04OKgWsnwO8OPO6XFp4k
         gcGrSrAFN8FLRhVeNWwlZRJOZHSAclnY9HPoB3HuXQelHLs6f+1ohmI9vSngAotfc7IH
         QSZrFglHVvqGCmsHXuvXJpw9dwoeu525LkvJ40KhaTDbcFoMQL1vwh5eQGoH3mPQTPoM
         +Ue34NeQBROeIfMTMZUda/vTDm2S6OzWhOtp+G/9KHQmGcMfKzWB/McXc86bK7qafkOH
         mJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U3doyi/oIBgrWoo6lZoqBf/FoW6Brbnlh7rxX+qhdko=;
        b=Wo9wn7M+SCEjTKOP8U3jNAtFcPibRHyF1/lT19lzj8fcL+bP83QJ/j6dNFc6s2UdE6
         MUT0vaqE/urINibRqZOl4yDPc8gaENVknJPDafHl+hBTEf1BZNagZH6yTDcSLUrYhIbe
         aokCNQuto0wwDKfX3QcvdPW6IBWLQpax4ZE0U8zflMnUYVoJsrYy4buiD93ib3SfcBNM
         hEtuWPbHluA3HZmJzTYRvEhN2SRTpxR7nV7ldyk7rh7H38Z7rEi7+uznq05KCtr79JKZ
         bhmUbJCMf12r4nEZQq1SXndph9WUSmgAKqRIEpIVfPmqz/kGLAp7f4uFRJPwuPLBmqzU
         asUQ==
X-Gm-Message-State: APjAAAXG9aa8lv34QelYqdiMLjGZdLlI6WiI5rcCj843qRShvJvM+fy2
        YeQJg7xTohvQ7+JwAx1fZxM9qqVXDFM=
X-Google-Smtp-Source: APXvYqwN9dRGZakh1bNTLJLLmgNnyAMikb2jQzHQhGHJWFIqrPWy0cuAMDvL3RA+enUt6tdfov5phg==
X-Received: by 2002:a2e:9758:: with SMTP id f24mr8508856ljj.58.1562243623210;
        Thu, 04 Jul 2019 05:33:43 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id g68sm1126151ljg.47.2019.07.04.05.33.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 05:33:42 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 0/5]  Add possibility to use remote device keys
Date:   Thu,  4 Jul 2019 14:33:33 +0200
Message-Id: <20190704123338.5988-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+Fix build/checkpatch errors
+Remove unused APP_IDX_NET and APP_IDX_ANY
+Fix handling of incoming packets marked with APP_IDX_DEV_REMOTE
+Fix usage of l_dbus_message_new_method_return
+Fix usage of l_dbus_message_builder APIs


This patchset adds support for sending and receiving messages encrypted
with remote device keys.

This plugs a 'loophole' in the API where it was possible to exchange
such messages using Send()/MessageReceived() API by using 0x7fff app key
index.

In order to allow the application to receive responses from a local
Config Server model, messages originating from a local node and
encrypted using local device key are also forwarded to the application
via D-Bus (assuming they were not handled by one of internal models).

Michał Lowas-Rzechonek (5):
  mesh: Cleanup l_dbus_message_... API usage in models
  mesh: Cleanup D-Bus method returns with empty result
  mesh: Split APP_IDX_DEV into APP_IDX_DEV_LOCAL and APP_IDX_DEV_REMOTE
  mesh: Implement DevKeySend() method on Node interface
  mesh: Handle messages encrypted with a remote device key

 mesh/cfgmod-server.c |  15 +++---
 mesh/model.c         | 124 ++++++++++++++++++++++++++++++-------------
 mesh/net.h           |   8 +--
 mesh/node.c          |  71 +++++++++++++++++++------
 4 files changed, 154 insertions(+), 64 deletions(-)

-- 
2.19.1

