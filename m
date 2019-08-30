Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E260C3A5A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 06:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36AC22CE9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 06:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="eVyJLAPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfH3Gnp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:43:45 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:39487 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfH3Gno (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 02:43:44 -0400
Received: by mail-lj1-f180.google.com with SMTP id x4so5412467ljj.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2019 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=V6LSW7wyKMLCu+f95GOPU8RY3zXeA5m+JSTwnpkKSQQ=;
        b=eVyJLAPPYGmn+MLzqLMQgJAHzmCnAoEyP9+apLmu6tmQ0VMFOdvTqr8d+tFTBKAj6t
         faSxm0NeA8o3vXFHAxFzOrKh4vUhnq5hOGv/kMUkRf1xHpdrAhzh2DzqfLuSjqcfQENK
         TkaQnSCQAvmwBqAvWDodZ+305/41JXIANLHNyqVOziFhV9oDoNsUBAs8gzCqnzgpbE8n
         pe9jeZk0jrjk2DCor6ea1EZ/OrUB5IQ0y3aEVr1LSN7P1IclfdwSUNXORv9BoqBdsmeo
         aVUhRHpmNj9ZLPUgdvJoeT6NZKGJwhDeQi0E/iyE5ErHFsgq5gz7JBApgjqxBCJauFoG
         p1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=V6LSW7wyKMLCu+f95GOPU8RY3zXeA5m+JSTwnpkKSQQ=;
        b=DBBXAyMwEe84sqSnXhlNhDU31tcI/XM8hpf1rotYrgGsrJtXnCprWibuMFvsO195o5
         6HUA36uAUfObRkMDYtZzmlYF0r0z4EHExUziCH+YVx0utcvRK3MhHnCR3J77dzm/ETit
         GctIf7oAKMkJfO6nRhMPl/e+iq4b4FZTdmC7UZdi/ubZDn++NrDKfIZq/dE6KOb2/mn6
         q+tEXzaoDT/G6t8GV03xozBuJj42RJnc4SBV1mhv1Z7jPmSUv9QpkUxkV4SJYYYpfSSp
         1NGrrkYrdVmptm6Am+77Jg4jKuJPkwt7/ounOdhUT1NBsAo6ubzPYL0O5I82cOZQY9Ze
         sQuQ==
X-Gm-Message-State: APjAAAVzOOc3Sjfn1jyAT56r/wIp348pM3w7cjGke9rZmzRsP8c2QLT+
        SB0SARy9jwOlHAA3pzpa2EoOnStTdsA=
X-Google-Smtp-Source: APXvYqxuMwazo2HEJ1Ax4tzgdKvBSJvkVlIrOTTY4NbsG7X0wvyThURziLpSbXqbGgCL7n1eaQPmyQ==
X-Received: by 2002:a2e:864c:: with SMTP id i12mr7483613ljj.88.1567147422089;
        Thu, 29 Aug 2019 23:43:42 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id w1sm754436lfe.67.2019.08.29.23.43.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 23:43:41 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Subject: removing BlueZ for Android
Date:   Fri, 30 Aug 2019 08:43:40 +0200
Message-ID: <26592033.GZZQrohHIk@ix>
Organization: CODECOUP
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

This is just to let people know that we plan to remove BlueZ for Android
( android/ folder in BlueZ code). This code hasn't been updated for few years 
and last supported version was Android 5.1 (with some initial pieces for 
Android 6...).

If there are no active users who are willing to contribute (eg update code to 
ELL etc) this will be removed in next few days.

-- 
pozdrawiam
Szymon Janc


