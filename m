Return-Path: <SRS0=zqBl=2E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7341C2D0C9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Dec 2019 06:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93411214AF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Dec 2019 06:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEDEqUBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfLNGjX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Dec 2019 01:39:23 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34996 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfLNGjX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Dec 2019 01:39:23 -0500
Received: by mail-io1-f68.google.com with SMTP id v18so899972iol.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2019 22:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2hT7O9OqQolGmx1OqiF85V4YOu08dVqLdnpDYti75x0=;
        b=eEDEqUBz4UrgUp7wpzt4SrMoVBA8lh/79ELKFpuXhOF8KUVDOa1fjCgkrVyHe048L2
         B+XCnHHDTjij18Dke8mYNB9WUzvPCtCrqMGbrbRUjA/MW4YK5sOY3OJFYSzAJYb1ZTh6
         r3hCnAF+YB0TKRLoClwAbC0/H/gIsKaliKoyMhG5Sis8+pBBc73MQG+5TpqxhWDc8sPf
         YlhPLqPTrlnXqh97WnWXEvI1/NLY5EL9cUfXnC/zOtxkepRnuxnlUoYv865bBpqhdZiq
         uHtqVI1f2OFBdYoJDpFZ7PJngSfKdfwQfC9Asnzm7iGDPOS3yYxG0wP7uD40Np5spQ5I
         5ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2hT7O9OqQolGmx1OqiF85V4YOu08dVqLdnpDYti75x0=;
        b=IxSIx0OsHSHGGe+sK8bnYhBWajlkxzYbOvj+LbHP3ooqXTyXBZxZkId/XKrrz1Y8zQ
         d1DK8DSELIgcXYaImzkjYX6kBwDfI/LcuabqTd++YdF3yURHV+zyIH4ngByqReTqVqp/
         TBJD7McjpnYg+sVduUkMSnmDkn1BcdQy+Zc/8DaCDPlc3tRRDlYcdi01sq6LqX/k+ry8
         KPXZh0V2l0DO8bbUu0uxUnpYceiZA86BoPjts6XCqBQRRooluz2f7IwJHTHVAp0G0UVA
         3TZd8UmkN4BPjj21T/KdI0VTfKmObKjswaHe1NcU90sUADUELUzS5PMBLNq7wmtp4a4a
         G3ng==
X-Gm-Message-State: APjAAAWoJjAUN39XKdNh8viGCoQDxNG8Yr+hc8Xh2Ly7xpuu32A86wFG
        TP84Fp/iYKJ5HDKX3l/arn+Am/hqN3zc43EhCQOA2ppj
X-Google-Smtp-Source: APXvYqxMvTzOrClgTN6eJragIcGaG1lRJWEwk2/TC+Jcnr65O+PxOo/RDeqY+vdXlGLeXn/4msox4DSk+sloIBaM9fA=
X-Received: by 2002:a02:cc4e:: with SMTP id i14mr3035375jaq.144.1576305562602;
 Fri, 13 Dec 2019 22:39:22 -0800 (PST)
MIME-Version: 1.0
From:   Peter Belau <pbelau1@gmail.com>
Date:   Sat, 14 Dec 2019 00:39:11 -0600
Message-ID: <CAAERL8Tn+CdneEqLxMsDGqxVtKEbuqRt4neOUg4b2o1U3PbZVA@mail.gmail.com>
Subject: cannot connect to btle device using bluez stack
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

i'm trying to connect to a btle device from linux but cannot do so
reliably with bluez. i can communicate with the device using an
android device but i get all manner of weird failure modes with
bluetoothd/bluetoothctl. what can i do to debug this?
