Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67D1C3A59D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 09:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6512087E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 09:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="k8A1TsRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfHSJde (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:33:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37293 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfHSJdd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 05:33:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so7958205wrt.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nokyPsF+TLkADYoEcVDPJm91ks6+AsvkwA/QT4jxdGo=;
        b=k8A1TsRfjUqNnqw34wDXwirNc9+1/hV9F27pe4AMThWINqv+UikTDlIlThFPFqSBRs
         eD+rTRMyDZ4eKDPMU3dPKUPmXMzRT+sNIotK+0rur7gE6ekReZvxems+GWtEJfHMAfiN
         xHF457K0L5GiP8ZIxEFNd0FheCaAIzHwJdQoGBeDmsknj133XC3wDrqlEyEPpD+VaCtF
         OVd8FO7gN6ypXt/yQ63G5S20I8FrRtwcn6Q+2QBsEMbtkKfpkg2nuH7RdXW4jNof+8Ib
         vc+BzioSff0bAIyQI+RY7Rx+GegXN7DytnJK6jPQW1hqxtg0OEr97v8a45XAUb0mHDFs
         FeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nokyPsF+TLkADYoEcVDPJm91ks6+AsvkwA/QT4jxdGo=;
        b=gPoMvFuGLpUk2mt24diEfpI2bJPC8rrvEcmiVlbuFARAVNALUQnX4TvxGzQMPTEHR0
         Teval9ucdhUp5V5z7KBt7N7XJhemGEfX7G/n86NDpplxcCoGDZIMedR+0Ef5q0YDExrm
         tCkuTlQnIqK8+ejSsqfNeuzUkCuWeAfFn24WjdvmmnjLA7Gtmc+0j+oHGAyWb2xCdDXb
         a1uSbcplKsihCzXYJI2VAUnR1eC49y6QfGYbl8RmtvUBhIIKSHDuFFaiScHsPqRH16DJ
         r4vtl+QvoO+LxHyR66RgsihF66TuPE0XwsGz5PcfZ3ik+w2vIJq5oBEd0P2mAYtrApEv
         ibsg==
X-Gm-Message-State: APjAAAU/IbTk1xLLbJ/FjEr2i8T6TSCqz99ggMkNgUB13CJcWxtgjKHb
        BR1fIcKRnUPi09ZKibvJ3aV4v0qjsBo=
X-Google-Smtp-Source: APXvYqzzlVpDgY/sp2aFZTEVlqJ4MLbdw/OowQIT2ZSirAHOGaqba6D7mnZdLO7W2hrccY/UA98ioQ==
X-Received: by 2002:adf:f30e:: with SMTP id i14mr26767128wro.288.1566207211455;
        Mon, 19 Aug 2019 02:33:31 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id o9sm21675360wrm.88.2019.08.19.02.33.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 02:33:30 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/4] mesh: Streamline crypto functions
Date:   Mon, 19 Aug 2019 11:33:20 +0200
Message-Id: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch-set is a cleanup of redundant and/or unused parts of
mesh/crypto, making both the usage and the implementation a bit
more consistent.

Michał Lowas-Rzechonek (4):
  mesh: Remove unused defines
  mesh: Normalize Access Key AID and Index naming in models
  mesh: Align appkey_packet_decrypt with dev and virt variants.
  mesh: Remove redundant code from mesh/crypto

 mesh/appkey.c | 111 +++----------
 mesh/appkey.h |  10 +-
 mesh/crypto.c | 434 ++++++++++++++++----------------------------------
 mesh/crypto.h |  48 +-----
 mesh/model.c  |  84 ++++++++--
 5 files changed, 234 insertions(+), 453 deletions(-)

-- 
2.19.1

