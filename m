Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AADECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 20:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiH2Ubm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiH2Ubi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 16:31:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C0B86065
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 13:31:36 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A6F656601E7E
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 21:31:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661805094;
        bh=FCLXPsSEbdxOk2zsFrZT2cx3cwjO5dKGVrUSJK1BB7M=;
        h=From:To:Subject:Date:From;
        b=TqRP23bU038+yQjNaNlU5IFGpdW7ZUNtaVTHTX6peWV7EcY2ZvVx9CquYTGMjOZ1y
         6zgowkbxUiYm/uPAgq55dXOPSOKYDxSrLT27srwgCxJ9wFm9+/pEKP590in/43skNa
         sseJKk8+Q3YP1ze3aQEAaTJdzH2DmJ5WmRHKv5PkY4CGomNgg0XRiT5AWZGpR0Uxyg
         GvnrD2M+5msmMCONbN3uApFlMjZO3+5r/HQeiV7jpXI+69QVmPRertLQMgzAQ643xL
         Ymi9+ZfORxawPQentW3M1kurpMFL/GIhFcqc2BrKaGIRf3cyA9eAE606hnmb279Vsd
         ZyAxevdH9AMgw==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/2] profiles: Add remote endpoint path to SelectProperties
Date:   Mon, 29 Aug 2022 22:31:20 +0200
Message-Id: <20220829203122.51343-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The SelectProperties method is only called on the central (initiator) device.
But there's no information related to the remote device for which is call is
done.
These commits allow the audio server to link this call methos to the
appropriate remote endpoint.

Frédéric Danis (2):
  profiles: Add remote endpoint path to SelectProperties
  doc: Add remote endpoint path to SelectProperties

 doc/media-api.txt      | 2 +-
 profiles/audio/bap.c   | 2 +-
 profiles/audio/media.c | 3 +++
 src/shared/bap.c       | 2 ++
 src/shared/bap.h       | 2 ++
 5 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.25.1

