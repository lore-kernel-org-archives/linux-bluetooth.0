Return-Path: <SRS0=UCBE=UR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09715C31E51
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 11:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08CF2082C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 11:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="cdI63X+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfFRL1D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:27:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37926 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfFRL1D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jun 2019 07:27:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so12735950ljg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2019 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=muoC2HK2f99qtPL9tVX1e4gsT7w19wo+D0NiuxeQmGI=;
        b=cdI63X+imw/OPEyylf4VIpuIWiqAsCzbqZd5TLms6WIxQy0Hfs3Vc6deRgY78uHBGZ
         hI0NhvIkY7AIwJnKYJPssP9X8ELOHo2rbP50FP0LtByMUGNZiUPSAUHtAOd6LG3V+A0C
         AB/1QR7U7AtrsqIGQgvXs4FsmC1QnlSKfwwZG/Gf1N3ag5pGGnu5pvJ6qGd1XpZfyMt0
         MBkdB68RQEDgyyxMbNHwtBSoRF7fzRsHunlIwKXIjUhFrBRClV1wSfpLR+Dda3I0dvnC
         LKqHdkBpYd7wLjlrs52BQh9HEQ0tsZQRWYSfpNYR+yI9MIFJUm6l3w0Uml6nu1yJYt6t
         0jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=muoC2HK2f99qtPL9tVX1e4gsT7w19wo+D0NiuxeQmGI=;
        b=OaCqt3TyLJQHKXUrb469FHr1oV4KpSQcBk8koaNqGB80w0isqndsWe+L+WwnVMf8wH
         k5uMYGf96D8PySQP2leF1I4x8oqfE0hjV7lxAyIoU16NAQ0ZuLOJyV3lvbjEfZPyqXS7
         QSn+dNvgDcXt7RVdoZzaoentIUVsPEijxC+oL1I5h+kfdUGFB5Ci9T4/IniBRHSbNqly
         7ZJuPAdv1rZHnvPYwhHushovwslXEwZWeDxYt289cMBqktNfdBbRAMr2ZbXGRsP8U8Az
         q/kyveaK63f7RVCigr4TQ8KyXaek72iR3Dsne5BaSD0a/zwrymcy+BoRxz9VNFJPjYiW
         Fl+g==
X-Gm-Message-State: APjAAAVfuNRyOlU/NEB6XGfC3NsfqREnNsVAvam9vFfCJAfs8rcbotpF
        KqMwZzE5AboCDypHZX5yrv7mRd7KySs=
X-Google-Smtp-Source: APXvYqxv8qozelV+T57MvLWDuFG4NXmEIdFfHhvi7NsAYPzKtL1pr/3jN8SqoxbtNDFprJuMq5uvzg==
X-Received: by 2002:a2e:9188:: with SMTP id f8mr3005482ljg.33.1560857220983;
        Tue, 18 Jun 2019 04:27:00 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id c19sm2135278lfi.39.2019.06.18.04.26.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 04:27:00 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/1] mesh: Move HCI handling to mesh-io-generic
Date:   Tue, 18 Jun 2019 13:26:54 +0200
Message-Id: <20190618112655.19963-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch enables us to implement more I/O layers, particularly non-HCI
ones.

As of Bluetooth 5.1, standard HCI commands don't allow precise control
over mesh-related advertising, making this I/O layer very inefficient.
Therefore, it is desirable to have an option to use a non-HCI transport
to talk to radio transceiver, at least until Bluetooth extends HCI so
that standard BLE Controllers achieve good performance.

Another use case would be a non-local radio: the mesh stack can run on a
secure device, but due to physical constraints it might need to use
radio transceiver located at a distance, connected e.g. via LAN.

Michał Lowas-Rzechonek (1):
  mesh: Move HCI handling to mesh-io-generic

 mesh/main.c            |   4 +-
 mesh/mesh-io-api.h     |   3 +-
 mesh/mesh-io-generic.c | 203 ++++++++++++++++++++++++++++++++++++-----
 mesh/mesh-io.c         |  17 ++--
 mesh/mesh-io.h         |   2 +-
 mesh/mesh.c            | 189 +++-----------------------------------
 mesh/mesh.h            |   4 +-
 7 files changed, 209 insertions(+), 213 deletions(-)

-- 
2.19.1

