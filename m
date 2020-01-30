Return-Path: <SRS0=xtvM=3T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADCAC35240
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 14:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF6E20678
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 14:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="XBVcr7Kq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgA3Oef (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:34:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34988 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgA3Oef (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 09:34:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so4350250wro.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2020 06:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3//5TuPju96yBBgzeeBDgNp5HFoeqe2u0YI5B+q2uaA=;
        b=XBVcr7KqmF/ks9hw4d8G1+R7t/glMJu9MdvHw1w1abLvPmHvPivyE26tR7eheTj4w+
         v8ua8K18spW6EIVJtOjcngh+wKAL4MgIRVnw6P4OSBFXMWWvTBGdIJh3FFQrtDpn6gGB
         H5sWoE9wClUL9bHnFqAUE5fiAS65Ybqt2ZpS/SFUgIVQ1DBnPyIAGU7zw18lFyKP0FEv
         9Z1+wUhWAgRrASjSJceTIPQbKqTe/T8yA+/QATJaTiqe5CK1PcrLrnqh/pXlW36NxAsT
         DyCNYT9fUbKvnYF6aRRPjPt0DZO/OaHrN7GrabHZP4YIqC5zJRVw6r7Jkw4kEXZxa+A7
         V3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3//5TuPju96yBBgzeeBDgNp5HFoeqe2u0YI5B+q2uaA=;
        b=oqvExiM1fY4lBWLmlF9lSANo4oN+eciwmkcYJxoSp46fNjvxGpYfg+GERzgBWksE1X
         KpP5/hWepHnzqFUNf2MdkHwMGTcHTVKH4MZytpgDLNc8HLkwdERH5kEv3sTYy0HXBP5m
         cov/yMgLVjJjF61EtQIayeOW6uOF9eOGdzLvCYc6V2BNgSva5o1noubg/93Vhe29+FI7
         Dz3Am/9xTROuouapEaRTLXuku3gNzANcDpGmAyKyXEGHPGKqkMwNBRPaOp3wHkjIK+pJ
         wb6+QGRpB+k9SonAc4wPJwBqw97QUKxUkpelVjhFWHIlMBLHSYWIR8XMWlK9NQRKcQS2
         A+IA==
X-Gm-Message-State: APjAAAUeqvn25GZ+5B2OvmR2kbOW+KRtLMx+B59cF6+iYgK8AZURxSaL
        4KoI0R0fazf5xoEf4DMzLrCwWy5t0MLeCQ==
X-Google-Smtp-Source: APXvYqzb5w+MB0/SXK+2mJpWWMUC4Jj+R/h2WnJf5yoTAqIAzEaZhFH/JSt/8C3nkpc4uCYi4l/2cw==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr5950233wrq.331.1580394871240;
        Thu, 30 Jan 2020 06:34:31 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x10sm7353310wrv.60.2020.01.30.06.34.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 06:34:30 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/4] Allow to reattach with new composition data
Date:   Thu, 30 Jan 2020 15:34:21 +0100
Message-Id: <20200130143425.5844-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch allows the application to modify the CID, PID and VID in the composition data.

Version 2: Do not allow to change CRPL in the composition data.
Additionaly verify the device key when updating comp data and remove
unused function in the 3rd patch.

Version 1: According the Mesh Profile (2.3.4 Elements) the modification of fields
other than "Elements" is not prohibited.

Also in my opinion (as you can see in the 1st patch), there is no need to use pointer to
the node_composition struct. The static is more clear and less problematic.

Jakub Witowski (4):
  mesh: use static node_comp instead of the pointer
  mesh: add cid/pid/vid setter
  mesh: remove unused node_set_device_key()
  mesh: allow to reattach with new composition data

 mesh/mesh-config-json.c |  40 ++++++++++++----
 mesh/mesh-config.h      |   2 +
 mesh/node.c             | 100 +++++++++++++++++++++++++---------------
 mesh/node.h             |   1 -
 4 files changed, 96 insertions(+), 47 deletions(-)

-- 
2.20.1

