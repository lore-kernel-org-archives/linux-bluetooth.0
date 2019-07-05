Return-Path: <SRS0=EGv/=VC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FC2C4649B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 13:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D98218CA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 13:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="WaWQ2O+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfGEN4n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:56:43 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:41919 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGEN4n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jul 2019 09:56:43 -0400
Received: by mail-lf1-f46.google.com with SMTP id 62so6398505lfa.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2019 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3cbdK6ww0iufwbNMmaKdSPOsewux+241a9pbdZLfNL4=;
        b=WaWQ2O+kaigVatevZDt6DphFFMHJczZvC+JxYU7xQ+RbI99GNXvQ9AZFFHPEItZxnI
         4X/hPj5s682RcItFROsqK7+PPivz86+sE4Cm+DJxYuJWAribwiECBQ1ODuO4XhFvf0Zt
         ulHguqL1JK9nQlu9qyQCVCFQm0aMRlPOUO/husxgopLm1ZDqN3CIfJgjNL2tOEWuZIxb
         ugxRwR5K+MRNdNf+QjgxMEqMHLFQlPthMcvbuQOD5RRPggH3TPIre63IsgqEFDFyEDrx
         nHpldsOllSBbjA/aD/zgnEBZYUDD4F/tdMHW+yG+uVqp64+ZuFPATMDrCO8E24uZLvr0
         0Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3cbdK6ww0iufwbNMmaKdSPOsewux+241a9pbdZLfNL4=;
        b=aD/HL5rNo7PhO5NBKNtb6yy+RE7ZxoPAGuZQj9q/l/jgTFvhxZlvlsbY6ONjJ/B/es
         KArfOJRhG2EV9MjR7RIQ1Y/EUOmL/dXF/t0Xh/1JQXAq7OLRX6hKlY0bpKFqIEKSBzRs
         yiqLP37qzPbWYfmNb2p5qrEv0srWiLf1UC0HKYNASkWTxflNIAPH4yXip94bbu5iL1kl
         X/jnQ/K4BAwWO/WAR5ivH1awpCrPQIcTFUZcGNRqNOPopre9l5OYdBzvFFdANxMT+dBs
         oGLvH5thJ8VfZZm0L1rcDAvhGTsfaQsmdZaVtSDsezzMR5tc5/9iFXM9F7BK+/zP3dp6
         So7w==
X-Gm-Message-State: APjAAAVmcst8je278OhnMuXvVsfv4Ja64WinWcCyzQiwkOr3S64LL0sw
        G8nVD2T6v5BN0ZebYu7OlUvzon0ylx8=
X-Google-Smtp-Source: APXvYqw8vdTbm+S221KrTNMGjKk90o9kZKcrriebIJoIkBoNqJV9Pw0gAup0RBhRQCnn0jKD3nrTzA==
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr2139756lfm.134.1562335001204;
        Fri, 05 Jul 2019 06:56:41 -0700 (PDT)
Received: from kynes.internet.domowy (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id 133sm1544682lfi.90.2019.07.05.06.56.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 06:56:40 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/1] mesh: Check address range passed to ImportRemoteNode
Date:   Fri,  5 Jul 2019 15:56:32 +0200
Message-Id: <20190705135633.2013-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixed author.

Michał Lowas-Rzechonek (1):
  mesh: Check address range passed to ImportRemoteNode

 doc/mesh-api.txt |  8 ++++++++
 mesh/keyring.c   |  9 +++++++++
 mesh/manager.c   | 13 +++++++++++++
 3 files changed, 30 insertions(+)

-- 
2.22.0

