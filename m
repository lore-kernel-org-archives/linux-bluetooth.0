Return-Path: <SRS0=E4Bp=OR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6CEC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Dec 2018 07:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB7F20868
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Dec 2018 07:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="Qh6Ca4hB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB7F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLHHRj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Dec 2018 02:17:39 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:39453 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeLHHRi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Dec 2018 02:17:38 -0500
Received: by mail-ua1-f54.google.com with SMTP id k10so2198409ual.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Dec 2018 23:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=tjfP4zvCF0qwaLJdcZUbVnE2NSELYUVwl/poj5ItwfQ=;
        b=Qh6Ca4hBys8E3rIEZmCUQqOJtGK6pD5sOLpNXXC7F7yV28WtZ7XR1QxpBqjx/UB2b0
         kzQYTOqGKMRtpnN3vwkOrvblrFT+KprIxFLB5PCnAMt5fsDv/+Aa6fHD3ph65gIhZn48
         WNbHG4hqD7QQajILqb9CskiQDRltlZao2dvFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tjfP4zvCF0qwaLJdcZUbVnE2NSELYUVwl/poj5ItwfQ=;
        b=KxyvlyQwcKTr2mE/oJVj/0RHnSaBNDSyI6WuZyC1RbJK8CRyLoBcAtFAJEzDZigHe/
         BDy19Vm98WkePUQgef9HosLDm5eP589PDN0pR7f9mONi3VIitKf+vKAhtmXziHK36aQo
         hd4wnUZuGVfu9s3slTRvtJZaBfrZxrIkDJi/SfX1EK6x6nk69k9XbMItE5XOxEy8+ZkA
         YC2o188UubFXd+YFT15xottEC+NYoyWvR2IuJV9Ppl6NfIPkt3Be6V/rnAjlDN3eo/8I
         z0vKmCkrXhxfaZKvrl8E4wj2UJwin5ru+5uZYwiuSNLCPH6vTBKEZpnrBRkKkEtuD4qN
         vaag==
X-Gm-Message-State: AA+aEWYnZg9MKHEO7P2WWkmf/i3/pH8xNrUXkd7GjCOzLaCLNWCfPdNw
        RXpZNjHmgfL9y2rO5/mHxWrj3hCjoyIM0mqz6M1Yv03n
X-Google-Smtp-Source: AFSGD/XQHj98sIoS0NlWE6ZtvIv/0D7hk4KYDYwg/lRlIeGHIA7mANLJHusvGsdESzZ/qrx8FQMGLpPUW87/zisD2CY=
X-Received: by 2002:ab0:3259:: with SMTP id r25mr2138330uan.108.1544253457532;
 Fri, 07 Dec 2018 23:17:37 -0800 (PST)
MIME-Version: 1.0
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Sat, 8 Dec 2018 09:17:26 +0200
Message-ID: <CAHotPr9MSwoiFCFL8=8_L8V0t-6VU3LMk3KuPmt8tvX_nz5uEg@mail.gmail.com>
Subject: Some ACL packets are missed
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

we send a relatively large stream of data (~160 kb) from peripherals
via GATT notifications, multiple times per hour. occasionally (about
once an hour per peripheral) we loose sync of our protocol between the
central and peripheral.
this seems to happen only in a system with lower performance (iMX7d).

we traced this to some GATT notifications that don't reach the
application level, these are visible in `btmon`. we're using BlueZ
5.50 (also tried to apply patches since the release due to required
bug fixes). it happens both with with start_notitfy and
acquire_notify.

we have another implementation of this transfer that is less stressful
and streams 256 kb chunks with a pause for sending a command in the
other direction for the next chunk and it has no issues. we also have
an older implementation of the central application that uses HCI
sockets and not bluetoothd/d-bus, which also has no issues.

is it possible that in some occasions bluetoothd will skip
notifications? how do I even start to debug/fix it ?
