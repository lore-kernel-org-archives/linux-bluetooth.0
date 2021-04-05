Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DDCC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37A0613CC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 20:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhDEUjs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236543AbhDEUjr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 16:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617655180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=K687xT8/zNajecjgzVpfiR+MAIT+b/S212XjZgRm2YM=;
        b=I1pak3Ty0xMLeCVNw1FahoZW0Bi2vQj4y8SHkEChv6sdHFAii7qhHiWSKK3ERrD+W6vFyl
        MUsEDUoUrb2SrBgbNrcuPFcp+QsGtCP2FNTzJO5lJn9ipovpKUkHqSU15fF4gGZcsCtJUr
        fRnTcmbGsvofRgomgM3aH0I9qaOtR1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-F0Pn0zf2NISpbi3SK-7yVQ-1; Mon, 05 Apr 2021 16:39:36 -0400
X-MC-Unique: F0Pn0zf2NISpbi3SK-7yVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE24D8189D2;
        Mon,  5 Apr 2021 20:39:35 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5FB85F7D0;
        Mon,  5 Apr 2021 20:39:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 resend 0/2] iio: documentation: Document proximity/accel sensor label use
Date:   Mon,  5 Apr 2021 22:39:31 +0200
Message-Id: <20210405203933.17282-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jonathan,

AFAICT the v2 of this series is ready for merging, but I'm not seeing it here:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing

Hence this resend.

Regards,

Hans



Hans de Goede (2):
  iio: documentation: Document proximity sensor label use
  iio: documentation: Document accelerometer label use

 Documentation/ABI/testing/sysfs-bus-iio | 46 +++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

-- 
2.30.2

