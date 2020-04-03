Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E646EC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 07:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD607208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 07:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="n49/Y9c/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390255AbgDCHjr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:39:47 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:45879 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390424AbgDCHjr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 03:39:47 -0400
Received: by mail-wr1-f45.google.com with SMTP id t7so7243238wrw.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qD4emAfxEFRv3+NvKXt9RSQVwlFrrtp7MOk7mA4g7f4=;
        b=n49/Y9c/HKAI1Xcyi8dGaoJx6Rb7Bq4ZvaIQM+8ayurHN9J/EuI2VIwlkgaEhTFkAr
         TcY9F1kk2+P/qW94Cl09IP9+u8srv8vTVBbpc31YBJ7ZKSZaECVSERDYd3ki0XtAeyNj
         /0tf5ef3ZwVfcuh7QlgA2dmmR5L0HN22dZfR3dw9+CRoKxpsJCGaTLS3hqVa3MshrlH/
         BwIYwe8jN1cIqQZKyF3UcFlLXvv1yNZurEMeUTF00hceIjRilg96SRilCa0msHdgzhf2
         y9ScwP6J/GbF+b8s8qJ2V2dPy/YeWvAA4gfYUYsb2BbNds3ADVpw5qnkSLHXUGidbckj
         n7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qD4emAfxEFRv3+NvKXt9RSQVwlFrrtp7MOk7mA4g7f4=;
        b=gRICV77Sd3GeF3nuIO3eijgOukyrTQnMbSYzGK0ZWXghFQvkP6sew8VbxZ48U1nBed
         bORp4vwf+ZiLBPqh6dy2VUYIB2NvVowXDdDYhKqUR0dDnTirE+KmpuVvx0k4enYcdiMz
         vaL9uDGGRJI86znHBSmmDKp9I75JH3zAG51YTHP/9tZ+aj5LtkevG6KuKt1o21NcoD+X
         jKpc7hCxKxL+eRRrPqoW1+m8D6iie1J9T1hc+TLEIedgp2RPnqZzOEECNih2aGqxp/Ud
         iy1UOUpvhxiYo9Jf6f3LtqO7Cq/GnZUUjFuJw5kRAV+RzYFvEmj23nakBBt+6DOsSUee
         JknQ==
X-Gm-Message-State: AGi0PuZUcQvDnbFQrACSdQVr+XWDaEIT4hFcOjufyDph51Hl4VvbtNxT
        Xk/zSRuzun5/rTS3RNDhvHaI4tLT
X-Google-Smtp-Source: APiQypJ1gGjCNnb+cO5jz8o9lP7IqfHN2lH2KRYOgWUiBSyvbhOiBM5Nqi4AWuAl9vmy2xdDwcvuxQ==
X-Received: by 2002:adf:a549:: with SMTP id j9mr7191920wrb.183.1585899584120;
        Fri, 03 Apr 2020 00:39:44 -0700 (PDT)
Received: from RBGWVBL000659.fritz.box (p5B26793F.dip0.t-ipconnect.de. [91.38.121.63])
        by smtp.gmail.com with ESMTPSA id h5sm10943051wro.83.2020.04.03.00.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 00:39:43 -0700 (PDT)
From:   "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>
X-Google-Original-From: "Klein, Thorsten (BSH)" <thorsten.klein@bshg.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Klein, Thorsten (BSH)" <thorsten.klein@bshg.com>
Subject: [PATCH BlueZ] Fix error code in case of invalid offset
Date:   Fri,  3 Apr 2020 09:39:27 +0200
Message-Id: <1585899568-14564-1-git-send-email-thorsten.klein@bshg.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix dbus error code in case of invalid offset (org.bluez.Error.InvalidOffset). 

Ryll, Jan (BSH) (1):
  fix dbus error code in case of invalid offset
    (org.bluez.Error.InvalidOffset)

 client/gatt.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.7.4

