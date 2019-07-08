Return-Path: <SRS0=sF93=VF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351E5C606BD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 14:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD6A21670
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 14:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="eGwylQhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfGHONW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:13:22 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39551 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfGHONW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jul 2019 10:13:22 -0400
Received: by mail-wr1-f47.google.com with SMTP id x4so17296363wrt.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2019 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEpkOPJ+GJaq9j+01thh6Wu8K5xS3Xfa0eBBDLzDcYg=;
        b=eGwylQhDEeAqj706RZyntXYgeKrHAKvhxLEtp056mZwA3Jcq+qJOT4BEe7z4irSdzM
         Rh+u+mJHROSGDiYzXP0aGYf0GTztc6qTJo3Sbqh0LwWPX7dQ2ThDpPBBzf7k3zr/LkoO
         Sp9JGgaZ7QL/yl+ZHbT788eqpX73YF5wkK8ccJ8XlgmmM+nkpJPdiz/ShzsrGnrWvwg6
         AbI47NRABEkx8masFBY9Qqfg/M5aWWjsW2JP34r6uS7V5PNz3y42mne9+qmaaTIMmqb8
         GPIjd5Fqa8a9FD0crAXJtkCkmeBS/OaxOnC06gxJCtJTcFytntsSmGxpMW/JQejai/WE
         fGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEpkOPJ+GJaq9j+01thh6Wu8K5xS3Xfa0eBBDLzDcYg=;
        b=HCZbqugJpkX+Mu5bamHhuNRdUC2KoTA8yvwZ2zT+h/kvGYY8hygklOItPHBQhNTVDN
         Z5z7Q68CkpCE4GswAEvbJE4NNoYS3gP62N8d7GHwKm9Zv0S+yPkaBeqiZMfBElrp+/lY
         08/par3h99JILvdkPMcHVS7itoOAY6IsLP+eVFLKKdnYruU4uQ69Z5+BqTLxqBOSE6Ci
         B+sK5dtpuVGqmwQqz6XBsKX85awZChdRhkS8e4QoPAQvallJh7Mci+5WeseRtFYLS9Kh
         D4BOItHki+EnW58CGzTY5jPadHUPg8wCdjdAJWC6J2b+UkbyUPV6CUE8qrzvTbH1PWCX
         RPsw==
X-Gm-Message-State: APjAAAUtpMHZ1Au29XDx6pjAPWdnc/YYB96E7OwEKzbRR7+j+OfZd83a
        x/BkNqd71D1Agnd1HabgdN5YEIHwf83h2A==
X-Google-Smtp-Source: APXvYqwEUIeBKQfTsLg2G3W4QLTpQWKQioujpck2mcdv1HTLFWkIyokm3HWYiw49qiqu77djDZM+iQ==
X-Received: by 2002:adf:f706:: with SMTP id r6mr18094253wrp.23.1562595199779;
        Mon, 08 Jul 2019 07:13:19 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id m7sm5392574wrx.65.2019.07.08.07.13.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 07:13:18 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 0/1] Validate element indexation
Date:   Mon,  8 Jul 2019 16:13:13 +0200
Message-Id: <20190708141314.13950-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I've prepared validation of element indexation.

First of all I've used 64-bit unsigned value to collect all given indexes.
As You can deduce from "4.2.1.1 Composition Data Page 0", the maximum value of elements can be 61.
It is limited by max message size which is 376. Furthermore the element indexes should be given
with no gap between them, for example:
  element index: 3, 2, 0, 1 will be ok,
  element index: 3, 2, 0 should return an error because the idx 1 is missing

Secondly I think, that the validation of element index value may be required, cause for now
we support 255 (uint8_t).

Please let me know what do You thing of aboves.

BR,
Jakub Witowski 

Jakub Witowski (1):
  mesh: Validate element indexation

 mesh/node.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.20.1

