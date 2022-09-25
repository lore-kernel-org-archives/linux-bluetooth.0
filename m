Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2A3C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Sep 2022 19:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiIYT4g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Sep 2022 15:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiIYT4e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Sep 2022 15:56:34 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506C72A941
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 12:56:33 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s18so3037804qtx.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Hj96alV3OVPPInNSvjJL/P54cnOr+8yexdFDrji2B34=;
        b=f8Yw5hDz5nLMBTiKjciO8xq7/lzS5P3sSLqDExHovrKtj0l9dCyuswCD1l/9Fg1R3l
         vSIEDozKUrc9MqXuNcD0LUJ9aKjJHKAsx0G6YMzUmZWv/0IWJ49Xi0doJ9H9F1HidpvY
         oyHxW+P7hBf/y7ChBV3oIQbR7tj0hm6yIgilolN0tRWXJDvwBwg02SO4KPMuVq9qmDoU
         /cC4R6gZ9Tpak3SHZwIzpjGhKyUFf6GaheEOwNF6XDm46NUYVlbDdmSavMRXKgD+XwP8
         q0vr+cXS0ZXKqRV3aQRkQUco42nRsxs+QWXETHp4Io6UQft36M8VtDCvc26kOb1sdLsk
         9Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Hj96alV3OVPPInNSvjJL/P54cnOr+8yexdFDrji2B34=;
        b=Cd2KQvKelA0WpPah8/AgruU8rok8g3HbFzjpDFAG5W3rywtadFrcLqWKs0Jjz6ogxn
         sDveidhHggqQwOqorsQ7erru7mIBNK+G2BAS+md2MQIH0Gvg+e5dmrum4SiuK38czaB5
         aaTfWSWPEF5ucQ8WtHvUKAAljmfADNyAYzBgG0ZSPqLOM/jcYh/S5r6RRLuTdxM9LmLL
         yJga3PoWNli6Ili+xEkd4SoUtXLKQYdX9/b1ZzDd6Q1Lbh/hLMfr7HMiZ0TwaiMk6yrY
         TdYGVGyFtCuFf3ZHfo5Zl+qz1ZNXxjw1k3yxllOg+UHWxuQSGMge1QJbpWLSAazdD+cD
         BxwQ==
X-Gm-Message-State: ACrzQf3tExsWaZ2tZYRwHq7cBKAeQi5MS06xfaeQluny+8actkAeXatX
        wmH+C5yMH0PjB0Y6tEraMF4XMxGOYfs=
X-Google-Smtp-Source: AMsMyM7BCqljSjti57/vUT20OtUGkdHrEzlZVduvLjkPDO1co8SE37MpTD3N2VVF9qZ99xtTS+8mnw==
X-Received: by 2002:ac8:5985:0:b0:35b:ba8c:d522 with SMTP id e5-20020ac85985000000b0035bba8cd522mr15382264qte.213.1664135792252;
        Sun, 25 Sep 2022 12:56:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.173.20])
        by smtp.gmail.com with ESMTPSA id gd10-20020a05622a5c0a00b00343057845f7sm9841530qtb.20.2022.09.25.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 12:56:31 -0700 (PDT)
Message-ID: <6330b26f.050a0220.c8a40.d2f5@mx.google.com>
Date:   Sun, 25 Sep 2022 12:56:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4062398983154946039=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, beppe85@gmail.com
Subject: RE: [BlueZ,v2] obexd: point DBUS service to obex.service directly
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <CAP96LmN8mMd5e=ddoUHt2w3HvcUF=8EahqGr6OhOJcjd3QwD0w@mail.gmail.com>
References: <CAP96LmN8mMd5e=ddoUHt2w3HvcUF=8EahqGr6OhOJcjd3QwD0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4062398983154946039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=680278

---Test result---

Test Summary:
CheckPatch                    PASS      1.35 seconds
GitLint                       PASS      0.95 seconds
Prep - Setup ELL              PASS      26.07 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      8.22 seconds
Build - Make                  PASS      725.54 seconds
Make Check                    PASS      11.76 seconds
Make Check w/Valgrind         PASS      286.43 seconds
Make Distcheck                PASS      235.99 seconds
Build w/ext ELL - Configure   PASS      8.30 seconds
Build w/ext ELL - Make        PASS      83.10 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      463.62 seconds



---
Regards,
Linux Bluetooth


--===============4062398983154946039==--
