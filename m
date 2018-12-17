Return-Path: <SRS0=yw44=O2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23554C43387
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Dec 2018 21:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ABE21473
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Dec 2018 21:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ijFniqfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbeLQVKJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:10:09 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:45369 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbeLQVKJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Dec 2018 16:10:09 -0500
Received: by mail-qk1-f181.google.com with SMTP id y78so8221118qka.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Dec 2018 13:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mLOrilvPpO97iNEzV9WpdjADlPIG2V+MvGjfAIc0ztE=;
        b=ijFniqfwLuwN7X4DGSTOXFmWqJEv7qHLu4ATY1fJLdJ3TbVDaz9sPU9C+hkaz4KOjL
         rIDhoSxHAhBxfax/W8qFHrmB8yPZs7h+mjR1h4JFCDnAmAr8FVqDlxCyfJT/suBUqBOq
         D+PAIPIlIDnZvWueYFFs2R9CZ+6QOsqT3V+EnJOFQr1JkaMmdL8eaqCCED9/xqe+XV/q
         5LAp0uY7Mg7259/o+H4zXMBn6AwXRovUPHY4QXyQDfpMDVxYcHMQQX+7UMNOt2LHoN0s
         1CJJn1YQjr1/pwS+oiM7OvFUS5mWXrA5xqm7ynQWpH1KSQC6ZWdCEir4tVOSvwjZ9+cP
         GNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mLOrilvPpO97iNEzV9WpdjADlPIG2V+MvGjfAIc0ztE=;
        b=meVE7NQWO7oad9H3ueFjchHyxBf3gnbvyKxxBbgZw/GGG6etQosiVoWfdvOaRNhF7E
         omI1D3EeEgMjqJdxQM3iLVGlsBJNHln0XcpsFElG9A9Iy/x78GiY8unFENPWHxAwq0qZ
         5Mzy7jEnJVJ+XgNgyt9qWVpFkgMGD6MFUpWw4rDSu8zuUuCZsUrC5ydbOLnTNwAtukQI
         u5pFwN3APtC1FTK/zRKQUK/Kk9OTvvzosAPDZe4mPgm6q09pG/6wDjzjvaxGSN62rINT
         9D0fX6B15gVS5Vp7GCjiDGLNj91nNCiJdHLMj/l4mRKuHIn0DmNvcdjyK+Eml7aQ4BGQ
         +Fvw==
X-Gm-Message-State: AA+aEWZD1KPhZi7abNNWrrvXmDnVVeBvG2ayXQV4gObvW3r2+YMq2j40
        i1rymDdEKB9ZImsAKq2Fg9WVXIeurDr5vAAZSu6MFE6or38=
X-Google-Smtp-Source: AFSGD/UjOoq50ZTWxvFMuQEpesSbAerMiHe0QaXsYpj/rRlfYsgL9CZPx6tsTOiQvvxsvx+gIW2uyII5g1GXBKx5F94=
X-Received: by 2002:a37:12a1:: with SMTP id 33mr13798380qks.151.1545081007224;
 Mon, 17 Dec 2018 13:10:07 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Micha=C5=82_Lowas=2DRzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
Date:   Mon, 17 Dec 2018 22:09:55 +0100
Message-ID: <CACXRGxyMGt1zecvRmgoa5uuSwy4H9UpSECM0tOuC+uXGmQoGNg@mail.gmail.com>
Subject: Plans for meshd
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Given recent patches to mesh, what are your mid to long-term plans to
enable co-existence of bluetoothd and meshd on a single system?

From what I gather (please, correct me if I'm wrong), current
implementation of mesh-io-generic assumes that meshd is the sole owner
of the BLE adapter, because the HCI socket is bound using as
HCI_CHANNEL_USER, so at the moment the daemons are unable to share the
same HCI device. Is my understanding correct?

regards
--=20
Micha=C5=82 Lowas-Rzechonek
Lambda Team Leader

Silvair
Jasnog=C3=B3rska 44
31-358 Krakow
POLAND

http://www.silvair.com
