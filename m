Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7638C2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3391206F7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Q4HK244F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgDHUxG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:53:06 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:34797 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgDHUxG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 16:53:06 -0400
Received: by mail-lj1-f175.google.com with SMTP id m8so968386lji.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2020 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvx6Qg4iX/zQhfOGRQuNUtRp4HKi180mKJLF8ZtbhkA=;
        b=Q4HK244FtOVNT3GsMGru5tHsf3zyNDeaHqyIj8hJ6qPecYvva+60lCsivYs1LmQzA8
         bj+H+d7cGgAeZTKjTh9D9TNcP0xxJC7NFzntbBJcCxzi3oNkh3J0dyXoW9dwQVgwVDhB
         vfAzs0i8uULmbYnpF6OlF07FlaAWmPT/4fgxIppuK39abzKsP23CnV9KWpE8F5gyAUID
         dH4dlxFB97Z7Cu9K1UdjhoV9HFVzS4EaX+rYQKVs6DlrThqit3MK3qJgkfL3fkZvQ+9d
         ZMyDKGQBoQusw1Emh8Wxi/BBM+eBglP4/PzbfYULrsqdRHExX/0Ihf05Imkj4b2jqxgy
         AZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvx6Qg4iX/zQhfOGRQuNUtRp4HKi180mKJLF8ZtbhkA=;
        b=YkH4tr3Ean9Nc/15YT8etQDjRI+o9GXBL+WVaNWTqbySa0tvzMmc1rjfV611dESTJQ
         d3l5dBumXyGqOmmZi/gsRtB5LAoh6FwEgSFEpexrNb1EnFwuyH8vDfS+VE3boAIkXoxH
         cTayhiLlZpBTmgbSTK+znZGeiurHYCbKPBZuVJD2Fl/83pYsMezNDirne4yyf8UXYtBn
         O9E99kkdThwSPX2arAPEwlIUejngtLyQ++vZDJ6dxj39o/cHmcof+9vd0IiQvl5XzwVV
         8BjlQl0WWhTqTWbluarsvfDKJeyOY6kSvKx+0UXdfN+8zZQOopHumoCfeZHgqViSxzSG
         BeWw==
X-Gm-Message-State: AGi0PubK+HWS+W5iNXEiJDje2PfRONsfEvnTItvPTXONCiy/Fjtcj3XE
        bY+HVlaNeFEulbyw66GYmiLCJRQ+jjA=
X-Google-Smtp-Source: APiQypKdKSYzXlWKEb1LaFPmz70QJAI2TlcG9pIIHzMVK2tqr4pzVQkjYYHPc4rIQFz2V9IsLidhWw==
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr6137317lji.150.1586379183280;
        Wed, 08 Apr 2020 13:53:03 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id r24sm14168976ljn.25.2020.04.08.13.53.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:53:02 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/4] mesh: Always deliver tokens via JoinComplete
Date:   Wed,  8 Apr 2020 22:52:51 +0200
Message-Id: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset implements API change discussed in 
https://marc.info/?l=linux-bluetooth&m=157660821400352&w=2

Michał Lowas-Rzechonek (1):
  doc/mesh: Change API to deliver tokens via JoinComplete

Przemysław Fierek (3):
  mesh: Fix invalid app_path on 'Join'
  mesh: Change API to deliver tokens via JoinComplete
  tools/mesh-cfgclient: Add waiting for 'JoinComplete'

 doc/mesh-api.txt       | 22 +++++++++----
 mesh/mesh.c            | 67 +++++++++++++++++++++++++++-----------
 tools/mesh-cfgclient.c | 73 ++++++++++++++++++++++++------------------
 3 files changed, 105 insertions(+), 57 deletions(-)

-- 
2.26.0

