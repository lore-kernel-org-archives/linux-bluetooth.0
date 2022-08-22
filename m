Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01864C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 06:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiHVGKj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiHVGKZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 02:10:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C5926ADD
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 23:10:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e19so8730682pju.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=hq7aogsASe0kz7asPbrFJj1bQvfFEq5K7H4g3uTGBIw=;
        b=A/ciI1b5Kea7GmBCF5q4h3aK361Bwg1Uu3x/+EOe8Bvj4lRSbA+a+1dwyHQjlVQroS
         qwa5XUS9+9YK8WSHFxMXP8WDl7iCrzDuy5l0HMmI6J3M9JxlN1Aw1mev/rZDhxvQcg8+
         vd0mQpACX1uGrddsZdKiSeFij5s8HNMXlBXEkydGaL4XoGKnOr4ZyhM3nHxp8DAemABw
         LU44hiJgaHsb9T0nNqXvEvlDq6MdcDN/qucFr1C99Wj7IOxVtXg2dpRk5pJRPcwCHSG5
         8+Vnvl/zyrxt9KWKRIPZidGiumJkrVsm0SUjKvf65N9bwHKvRNjZ/QAXdm515wWwxLP6
         3zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=hq7aogsASe0kz7asPbrFJj1bQvfFEq5K7H4g3uTGBIw=;
        b=GCd2KM8k43hQijWwmUZ4W7oK8Vtb4nw3JCLz2zyknsqpb3U8siLX4bujrEcX7fKxVh
         S+2L3uZPORD3IGPdNVaNyTS8oduuBApCsssAYocW9Pu3J5bAAvPvRz9HedCKKjFA5lP/
         +UKGJE4NF2SNPFkFPmfBoFuSqsOB5kOORLWkANpk3MSO2aySRb7eFgUAvIjBPMLnwJbU
         YOAS1OvWWe2/rFT7BX+tfOqn84dfKkM0DDCN/SHNbkTKS9KN7ZO0QqyT6tFrxh9n6ghX
         SSsJqqZuEJHZD4g4fNktAGpBoz7VSOZEY4fQof7w3AsugmPL0MgvzbAq7b41ggn0UNml
         MSkw==
X-Gm-Message-State: ACgBeo0uyBttOqbjMlrK4yRNsqgC/AcTMBc8+o9s19Mxf82tEfzSAdn+
        BLX4ubJZBJzWAPhY/9XOAVu4AnSzDJw=
X-Google-Smtp-Source: AA6agR54XhPv/r0GG+ooXDyxk3Dy8khPX8BDf9fh3QPWRcdanJfLvqXqaasnrsDRdnXRGQ+Eep0odw==
X-Received: by 2002:a17:902:f693:b0:16f:1d57:8f46 with SMTP id l19-20020a170902f69300b0016f1d578f46mr18569610plg.2.1661148623475;
        Sun, 21 Aug 2022 23:10:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.124.126])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7990a000000b005364e0ec330sm3799621pff.59.2022.08.21.23.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 23:10:23 -0700 (PDT)
Message-ID: <63031dcf.a70a0220.ae13.630d@mx.google.com>
Date:   Sun, 21 Aug 2022 23:10:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2188107425014102057=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] adapter: Reset pending settings when receiving MGMT error
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
References: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2188107425014102057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=669623

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       PASS      0.57 seconds
Prep - Setup ELL              PASS      26.91 seconds
Build - Prep                  PASS      0.63 seconds
Build - Configure             PASS      8.33 seconds
Build - Make                  PASS      935.72 seconds
Make Check                    PASS      11.03 seconds
Make Check w/Valgrind         PASS      270.28 seconds
Make Distcheck                PASS      226.70 seconds
Build w/ext ELL - Configure   PASS      8.24 seconds
Build w/ext ELL - Make        PASS      79.93 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      532.54 seconds



---
Regards,
Linux Bluetooth


--===============2188107425014102057==--
