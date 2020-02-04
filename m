Return-Path: <SRS0=1xTA=3Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7826BC3524A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Feb 2020 06:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0222087E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Feb 2020 06:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4Os7JLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgBDGqj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:46:39 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:41855 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgBDGqi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Feb 2020 01:46:38 -0500
Received: by mail-il1-f169.google.com with SMTP id f10so14894619ils.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Feb 2020 22:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=A5J0Po/4iMOvaFPuQm1LtP7oR0+SMexZKohpxX4nuGs=;
        b=H4Os7JLmAXbwjx+bTyRxj4YuF3fDUzIOg3OqfuA9zOIstuJevIlLxOsfBydpK3+qg1
         JCAvabdsAz+Ml1XMsgRmf1eFFXjOWJGHR61HBnIBsgBlpprRk/J2esZVSoABCh7qpdVw
         UaOX6rQlKd+3R3hSfIlShyW1MCp/J8SeYCcdew4V5MUcnUwYq1jNmqbFlBsIlpPdW82d
         mxKO+s5JsRvmNiTpMpeTrEmLa2VGDCwptmWbNJwyvv6TM31Omi3byA/SEqTUGecsZUyB
         qhg1ws+GlbhsD03aac59DssG70dXD7PLhg5u/nxfVgPKQvOFmfuX2YLKUi8jr+UGDqnq
         H+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A5J0Po/4iMOvaFPuQm1LtP7oR0+SMexZKohpxX4nuGs=;
        b=Q34ADSwbBKpuv2c6rAd0NqSjBV8PM4sdQiISfeL80sq+M18U5WALa6m+4IN/cFk0ey
         7Tr7j+XJsRtL3lR5FFZG2mer0ipunC0PeOTWAqhExsjTuz0zdxgUzW+K3xKSyUHNxZy6
         qdoSb4PYgu1hQLHszl1CDtY7ishgzA9u/17+Zaj+JzLstrB8rzm2H9MVuJQ7vnVBbDaJ
         oiwOkcDcin1LTop79/auMgRW7L/UxTJzhzG2CozB9+2A42OCpM6fa+hr+Ru6MclDjjA+
         eI8DC6ThRxXBTNYMELPO8VfNDV07Jc2j2qADIOQm289ppBkjwY1vJ362MH9eiB+ApJDC
         SAuQ==
X-Gm-Message-State: APjAAAVlOa7F1T1A7crD3yKcgcM4Cq3L9K30a0aaZJ5cXGLrCpnOBwzu
        wRIRyOnQp3zQDin70wUxSafaPtuddW8PPfkB/KbPxPUNcoA=
X-Google-Smtp-Source: APXvYqzB3dMvC89W5a09KPaAB6J3JPm/aaOeyW607UFCzEvMplODWmjY//O/51AZMZTh8W8vXWvN/ChlhBrIktFKJ3w=
X-Received: by 2002:a92:c14a:: with SMTP id b10mr9178333ilh.185.1580798797953;
 Mon, 03 Feb 2020 22:46:37 -0800 (PST)
MIME-Version: 1.0
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Tue, 4 Feb 2020 12:16:26 +0530
Message-ID: <CAOVXEJKBm8VhAC4meAUe+e0ZMED5eJKQ90xLpqxoEp-kFiOwyQ@mail.gmail.com>
Subject: How populate GATT database with bluez
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

I would like to know is there any tools already available to populate
GATT database using bluez.
Please advise me to the right direction where I can look

Regards
Sathish N
