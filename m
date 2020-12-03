Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD0C63777
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 10:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5F72067B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 10:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbgLCKiz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 05:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387757AbgLCKiz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 05:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606991849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MyamHgUbKq+2OGnoJyEP1GKo2QdhdprsiImjvaodW7o=;
        b=VVpZHkilNQCLj+wsl3H9mq4x6O5ooDGqYRqZzVGrxgdgbv0faOucT8swX/KqP9kJfmMaXk
        ZiTx+G1UcuVj/2wjXVUe3YYQiMuOuIQ4E/jeaqekrN8wX4+3DVFwdkjcz3H15cCd/z3RoL
        P3JE1Fj5o8GXVjQYMoC7fKw4nI1oY7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-bzPWhcs5MsqShulsk3epcg-1; Thu, 03 Dec 2020 05:37:26 -0500
X-MC-Unique: bzPWhcs5MsqShulsk3epcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3474080732C;
        Thu,  3 Dec 2020 10:37:25 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-225.ams2.redhat.com [10.36.114.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18D2060BFA;
        Thu,  3 Dec 2020 10:37:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 resend 0/1] Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134
Date:   Thu,  3 Dec 2020 11:37:21 +0100
Message-Id: <20201203103722.3745-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Here is a resend of a fix for a regression introduced by 
commit cde1a8a99287 ("Bluetooth: btusb: Fix and detect most of the
Chinese Bluetooth controllers"), which you have not picked up yet.

Since this fixes a regression it would be good if this can get
merged sooner rather then later. Can you please qeueu this up
for merging?

Note at first I send this out as patch 1 of a series of 2 patches
with fixes for fake CSR controllers. The 2nd patch is not a regression
fix and is somewhat more involved. So I've split this pure bug-fix
patch out as a standalone patch now, so that this can get merged ASAP.

Regards,

Hans

