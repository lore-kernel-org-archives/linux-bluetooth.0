Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A8C64E8A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 11:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C4521D91
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 11:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbgLCLLS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 06:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728105AbgLCLLS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 06:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606993791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q+MkB5LO45cTaQ2URIJkflnaQPYrC4PPkug+MJJk+u0=;
        b=GpsG5PFDNMnRnxPOLp8R7R2rKdqDFVazwHV9PNT2V4BvTi8ngqxBq3GTkAy+3cb+Qfp79H
        Fvvo/th/otQcU54HZ4mXn5VII/lP9pXfm2NrIbCvsvWKQj1AeMQmSWahjOydoYH+kh9MDY
        M3Z54al6u6Ir0ni5rtGw29jS09TDUG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-3zCaDLUoNuiqYXplpexprw-1; Thu, 03 Dec 2020 06:09:48 -0500
X-MC-Unique: 3zCaDLUoNuiqYXplpexprw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4AEB185E495;
        Thu,  3 Dec 2020 11:09:46 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-225.ams2.redhat.com [10.36.114.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF89410016F6;
        Thu,  3 Dec 2020 11:09:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/1] Bluetooth: btusb: Add workaround for Barrot 8041a02 fake CSR controllers
Date:   Thu,  3 Dec 2020 12:09:43 +0100
Message-Id: <20201203110944.49307-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

Here is a new version of my patch to make fake CSR controllers with a
Barrot 8041a02 chip work under Linux.

Changes since the previous version:

- Post as a separate patch, instead of together with the unrelated fix
  for a regression on some other fake CSR devices
- Add info about which fake CSR chip this happens on to the commit message
  and source code comment
- Only apply the workaround on this specific chip

Regards,

Hans

