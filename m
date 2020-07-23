Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BCFC433E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 05:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E740F207F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 05:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vH9z2S1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGWFG5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgGWFG5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 01:06:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11A8C0619E1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 22:06:56 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id h17so3946534oie.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 22:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AeHRv/0sB5DW1ivWHhxc5xKHLhyP/6NIUxodWKVPFA0=;
        b=vH9z2S1k3nHSoqUGdkmoiY+PFZS6bkSvJMbLrELOT1ouLEphhm7areNuea2yE7hKRJ
         9WIIKdXA6KEygDYWZOGj+XXmnl1XpONsLOnGjLxCzKzqTqtNr17i/MX0h/jf/Qb1A/Gv
         zUFE6wvfjIA3xQsGn+J+t5i+/Fhzm3Iv05lK1GqFhDqr1RMzxawm8Dww4v9zjjh5yaho
         jBsaO94P4wEJvK3riZrzD40WuWPW2dKfaZV2Z23u1UFyP2HZN8lAQOwC17osGxq6Tuif
         ROn7nu6TAsDV7FLrcl9bjjZir8eg0+eDDdNO1lYv7halI1Pbjd2SKlrl4x9cEXkR/aQE
         GUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AeHRv/0sB5DW1ivWHhxc5xKHLhyP/6NIUxodWKVPFA0=;
        b=bauK45ZMV5C780wJRo7hFSydGlqNJAt5Ow2qr6BE2kcsf50EZ9LpE+dB43ZdkYk08w
         e27gHoUNMwEGlG5uMu0f0j/Jgq0C5owteQ/XVO5OcD/qT9FWNmjnR3BaTB/9Ldz3pqml
         nzfbTtEp6/0sypgGeLWDILWC8QqjDGEQAlxk2PiQ2UtYYGjo9VQRk8kWVo7U0g5jeNHS
         PiUO0aaKIAoZn1kb0HqlsyS/KzcuKaoYVw32tlA6eWPFIc/u7UOMRuVv7lwjdmcGqg1j
         v9WO4hWqQx9E5xS1rb+UqdnlIyvzV8BRel7ua11jk1lcMTVIvwwMSOUmYjU+MipF11MT
         PCow==
X-Gm-Message-State: AOAM530YDnkS/bbGIT3QTzzWZVXscrSLtde8NtavE/GvaoPsnUJ3dXjw
        lLFl8qkovEd1ojAfNZvSQEnqc4gPfVypUpcXmAwXPMA=
X-Google-Smtp-Source: ABdhPJwCckgW1CXt1ZynFqtlCQTt0kprxlTI4HEcCSgVvGnb/gIpO4wpJkaSUXhZMkOjVF3OaEZ9oy7GL/gDsN++Sq8=
X-Received: by 2002:aca:3357:: with SMTP id z84mr2453615oiz.100.1595480816110;
 Wed, 22 Jul 2020 22:06:56 -0700 (PDT)
MIME-Version: 1.0
From:   Click2 work <clicktowork2@gmail.com>
Date:   Thu, 23 Jul 2020 10:36:42 +0530
Message-ID: <CAPWCbyVdeYTQ5ERFVcH_EwXf41FhnpYAxCSN1q-cM-Aez-cwCg@mail.gmail.com>
Subject: BlueZ host
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I want to use the BlueZ host stack with one of the controller which
supports the latest Bluetooth 5.2 features. I want to know whether
BlueZ supports latest BT 5.2 or 5.1 or 5.0 features?.Looking forward
to hearing from you. Thanks in advance.

Regards,
Sridhar
