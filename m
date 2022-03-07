Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Mar 2022 07:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiCGHfp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Mar 2022 02:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiCGHfo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Mar 2022 02:35:44 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5435F4F7
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Mar 2022 23:34:50 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id b23so12540171qtt.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Mar 2022 23:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zYbUn1AFs0nPIyX5DrIskC86eSlGkD1xn2YAyBGq5p0=;
        b=eKEKJkIFbNwU8eryOcVHK2EjySm0ZC9sxUZdDjDwy/wEEwF/N28yH9APL9mtdXnDUm
         pA3I4lwLjOAwH0IzUcXMs1nwL06mvWGrmIQw+1ElOpBp0lJbWpQ+Qqax2FyQ/P59UmPZ
         HdJBAKyOLVC3iE92Urm5bblmCcN1SFNgnNjNaZmmoRzUqRc2No0x6p+zYcZspE5xjxrz
         jnXcEDO7iKqE+a/j5knuK0NOf/01/Y9xebNNb9KTs4NV2SZOXcpA523kZ/Y9oa3s74Ai
         5zxpwoRnLaJNmi6/VDZBdIsPjELVDqxMjafZEFjQGzmhm616VJd76zh+d3wFY8fXjaq4
         jzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zYbUn1AFs0nPIyX5DrIskC86eSlGkD1xn2YAyBGq5p0=;
        b=PGAFMyshCLkBkVtRDcy6xW1QtM+3k50AeyBIQOEa57CeGRIQwPM7OOdj8jwUPXJK7m
         cfwVZMyS2QIXUzyaj/0Krss7V6AsIP4Cq6z1Jdjy4/k2Vzi5YRgCQF65BZcWlEWaWwm2
         nN3DYzUG3CfX7k97kc/0+J4zJsdkAE3H6pYzeDKv58bQulPZ2XLpYs65ZGCatb5532OZ
         YhR3Y3gni1prpsHmXEgy7E2h+kXQJU0ChyOuPHFPSQqEZSBUvlvb1nDSWZlIu9E5cEDm
         5bDXlToTJzmUUbU5Rj75CSZBbICCg8OlEER1jx5PjKaKoL/M8666VZVlkOoaNb/5K8Js
         IzXw==
X-Gm-Message-State: AOAM533IDa7UO2PKzB6K7Ug35j0RZ7OHreWX64tFZziHiB2/P8DmRddQ
        XCJjF0wd+ntTFGanM3Qc5H0hL9cXattp8w==
X-Google-Smtp-Source: ABdhPJzEEk4dapXpZDUykQZZvYtRM7V8Kifw1iC8gs56X0IfZsDK/OSSVUUu1UPhgK9HkgacobMSlg==
X-Received: by 2002:ac8:5648:0:b0:2ce:dd03:59fa with SMTP id 8-20020ac85648000000b002cedd0359famr8444909qtt.288.1646638489098;
        Sun, 06 Mar 2022 23:34:49 -0800 (PST)
Received: from [172.17.0.2] ([13.77.102.221])
        by smtp.gmail.com with ESMTPSA id f83-20020a379c56000000b0067b2dd2c860sm1028242qke.54.2022.03.06.23.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 23:34:48 -0800 (PST)
Message-ID: <6225b598.1c69fb81.5217a.45b3@mx.google.com>
Date:   Sun, 06 Mar 2022 23:34:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1462585769586226816=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] audio: fix crash in a2dp_discover
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220307140437.Bluez.v1.1.Ieb7448d3d951876e1f412452fcfd27cdc7bd015b@changeid>
References: <20220307140437.Bluez.v1.1.Ieb7448d3d951876e1f412452fcfd27cdc7bd015b@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1462585769586226816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=620823

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      1.09 seconds
Prep - Setup ELL              PASS      52.28 seconds
Build - Prep                  PASS      0.91 seconds
Build - Configure             PASS      10.71 seconds
Build - Make                  PASS      1460.20 seconds
Make Check                    PASS      13.01 seconds
Make Check w/Valgrind         PASS      538.68 seconds
Make Distcheck                PASS      282.48 seconds
Build w/ext ELL - Configure   PASS      10.73 seconds
Build w/ext ELL - Make        PASS      1428.08 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1462585769586226816==--
