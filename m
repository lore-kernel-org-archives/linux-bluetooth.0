Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E278BCCA47B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 18:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiGNSD2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiGNSD1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 14:03:27 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64CB675BA
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 11:03:26 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id w188so2033586vsb.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4nesvT9OY8ioZeMRRsZiDoivU7L9ZuEkXsCLQ9Ec0EI=;
        b=ohxEJ31gXiv9s1K1MxSkogG30qn129KAM1QV1mhQEclAPz/T0XKr1/UpMczMGH3P0J
         UfiorBL7n1Z/0+kUroMdf+ovo/6U38aE+kLgIduMrZowCtNdZYN6cC4yCkXG7jT0DWjl
         ZG2VSTV3QApIdNtZYl0z8iHKCYYrIcTqAurPIa5oPVYqhta0Xg0GYDTnQeBhFWIlZrFe
         yQ2FaDebG6CNsvLXmjm4XhdqDb98C+thZepy2wu2WY8LET65JW4ErxAmmFDHyPmPz27d
         zq3oBpgQvxbThXogSz+f2qgTyYKAmLNEM3ZgjHTbk7y8aMv6/TiybMVnpYg90ISNqFBc
         g7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4nesvT9OY8ioZeMRRsZiDoivU7L9ZuEkXsCLQ9Ec0EI=;
        b=Rs1lxzNo9anrBGZyg3bNVtJf/xyCdxZiZ74WEAQkfR+vZDOKKHSZmJxJGeoIbkM6eT
         yuAZGmPmgZIIBkoedrrfmev64W2tiWmswS5HyBD4y/gkhcS431SclvO9+KH3Tvu+YdSs
         k27jBIxC05LFdj+biXScuK1xnh9iJEOXpOj7nZ8sFXsug2a7RihfJjR5l7VgNidVBOxa
         qPdMqAPQEubwgcb7iyK7BcG+Tq7VLbINdQfbj40akMw+sqUIEeyWsVUlT3VHCijpCxpn
         laGs7chz1YhRhjXDJiDrRzpzjm/bymf29oUvdeZ7m4VhtNaA05UwWQJ4X8FVy5pyP5Lt
         BntQ==
X-Gm-Message-State: AJIora8LwMnNtY6TcAk3Z98juIzlumMR3bZUSVbHOxaZOmxmQFjHp7Ml
        oOrgwHIXX7AiL9pwID1UjamgHVKX6ekwSmBrZOo2oSJRQyY=
X-Google-Smtp-Source: AGRyM1sbqM0sqx3ynqA6REsP8kd20Mq5KrxEiPK9QHva1/2xUhRYfr/+PwRxzroQIg3K+wXx7xL8nD+KvnT44NFF3Ww=
X-Received: by 2002:a67:fe49:0:b0:357:4cfb:9ec with SMTP id
 m9-20020a67fe49000000b003574cfb09ecmr4460019vsr.65.1657821805768; Thu, 14 Jul
 2022 11:03:25 -0700 (PDT)
MIME-Version: 1.0
From:   Zhengping Jiang <jiangzp@google.com>
Date:   Thu, 14 Jul 2022 11:03:11 -0700
Message-ID: <CAB4PzUpVbkuGMnf+G2Ck0A4PhPSK6FDx-LQNdupwso5hAQPwjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_sync: Fix not updating privacy_mode
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Tested-by: Zhengping Jiang <jiangzp@google.com>
