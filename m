Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2220AC43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 03:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiFMDob (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Jun 2022 23:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiFMDo3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Jun 2022 23:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 094991260C
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jun 2022 20:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655091865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=weXT1rak57v1x/fmYaFf0QEuHeZHnRVcN5IqDOdhHmg=;
        b=S1Bye4NXV4essalV/ElxoMGpwSSGmJU3JiMV5NIyaMzSLizemYeTONhi7Yo5Tp1kGd5Zm+
        1NdiQMaTFTQVcVnctQG029HOgq4afFf4ysoI6Flx4qYgF3eQKlOgsoBltSIPASeVIqI7Zj
        MUYyFICn7TXGkhVoi61iyre9UZ8x41U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-oqsiK_H4M32zvuhiLjE6BQ-1; Sun, 12 Jun 2022 23:44:23 -0400
X-MC-Unique: oqsiK_H4M32zvuhiLjE6BQ-1
Received: by mail-qv1-f72.google.com with SMTP id x17-20020a0cfe11000000b004645917e45cso3133814qvr.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jun 2022 20:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=weXT1rak57v1x/fmYaFf0QEuHeZHnRVcN5IqDOdhHmg=;
        b=4ZRhF6Ov+26O/JXA62B7t++5ggOz/pY13zx42J8gLfTK/3XueFTj2IJPyptswm103y
         T8yUy/15LyoDn1+b0hdJejGADldE5gpv7ynVUG55VRM4c5o1L9nbg2/LPAeo/adDe1UW
         JF8FKmhvfjkZOgDhZ6KkHPgXFfG0CrCEfghtyYcTk/GrLeka8D8rirCYKss2xldXr2Cn
         gOyLnYi/+sJwOD/1rxBT5JA4zGZ68r+xAUM+OexfHBt54AIEx9KwZg4ijftKT8Png7Bj
         ZcpEzvPYSaJi7AQkYqCTiG1+V+WlUaF9Pd2jjRGMVSNMNQFnWgnlCgJ8vMdZqxBSNH5K
         fkIA==
X-Gm-Message-State: AOAM5309kz85++htg6N2aQ80gH4V3ZuAh3kySyF5iBHTUkJbNZS6DA9m
        lJ6U1eIOoR9Qwcvl2BlhEDWNYwrUEspK1+jv1Bgjq9u1Pr33Hp2ybz554L5WyDVFg/uocIiUOF1
        zV+TJlf5jIsj+BGwo8JbNlIlu3sJS9d6sFi/JIiGjGs4n
X-Received: by 2002:ad4:596b:0:b0:46b:cc90:5a87 with SMTP id eq11-20020ad4596b000000b0046bcc905a87mr19496163qvb.59.1655091863479;
        Sun, 12 Jun 2022 20:44:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIi5pOuNEZ8Veo/mZ6QmYCxHGYpHW1nGkcu13a17EX7kUGNU/tdFjsSbkbBEdepNyGjhb0WwcHU2NrKQVvcnY=
X-Received: by 2002:ad4:596b:0:b0:46b:cc90:5a87 with SMTP id
 eq11-20020ad4596b000000b0046bcc905a87mr19496155qvb.59.1655091863284; Sun, 12
 Jun 2022 20:44:23 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 12 Jun 2022 23:44:12 -0400
Message-ID: <CAK-6q+g1jy-Q911SWTGVV1nw8GAbEAVYSAKqss54+8ehPw9RDA@mail.gmail.com>
Subject: 6lowpan netlink
To:     linux-wpan - ML <linux-wpan@vger.kernel.org>
Cc:     linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

I want to spread around that I started to work on some overdue
implementation, a netlink 6lowpan configuration interface, because
rtnetlink is not enough... it's for configuring very specific 6lowpan
device settings.

Thanks.

- Alex

