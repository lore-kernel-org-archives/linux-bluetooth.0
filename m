Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2819C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 03:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356734AbiBDDIG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 22:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbiBDDIE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 22:08:04 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47AEC061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 19:08:04 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t17so4531482qto.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 19:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=46Mw1qO5pXfPm053jQRSawXlYGP9gErfNx0Q7aNGP9M=;
        b=Xi9sfVlhVF8bow7GjvO5H37Vpnq8WDlPoO1peDxyzOFTv9upV52Fl/oRrh2ReK+2WW
         Gt6GZSJjxtJo7Rp2nmstQ78kkUdAVwJJzDg3p6sGiG+dXLn2kLrjq2mtuG6NteY8JQsV
         TNp+ybciQ+Xn8yY8DXUYtQ7uwgqrFbimZKAqKNi+xaJk/991zbHiTdOR+XEk71JWm2PA
         1/VdK7srG7gPKtb2E24Y1+cO2R5Q1wFebjVZGMblu9klJlCGKfdus5EJbOMKt/tZ0QJj
         oiUuyrYBMY34qa8dAX1DVf14Swy8I9ulniB6OU47z3ehJouZQS5tkmnaFefpMOozyhMV
         CiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=46Mw1qO5pXfPm053jQRSawXlYGP9gErfNx0Q7aNGP9M=;
        b=nTn0ctEURwZkbx8dUB76xVa6OtHcAxE+gD/2Fs2fkU12/4bZ0ydGa5BJ4wGkIEBjiC
         zVDCH70TksopJe96NyatdJCJ/+bBsoUDa1/oVk4uQLT/C/xtQ6aQRjxkUockmZcgIrYb
         f2mzqjJw5qtDpWNEdQFBwAvAXBq8As65v+GMwH8ds5y+g1hqFs+GwZ1YkFpeNEVVwXX3
         VRZfeqYkn9j+51o0dx3yI+hC22HZyiLQQ3qyOlqVKhWdzEFqajPMvwuvaYOeLuimo5zO
         Pv4213LIdxGmBTBPvAYTo+lL7rqSVJwTxfhz3XdKE4S/YAapS51EnCibW3HP45WtRF4x
         CeLA==
X-Gm-Message-State: AOAM531rmLCVum4ICM2fNi9oOC2IKM+ivBl6oJjZ3clmdL09Y0TBV4+t
        MSuNHOifIbXst26lh9CnGvV1D5STqGu17Q==
X-Google-Smtp-Source: ABdhPJzJYWqK8FEWhfo4NOp4CcSUTy8GMbJkJbRfu8fLMdIeeekgcuc6dcEdCqFt/8tDPnAA+hx4FQ==
X-Received: by 2002:a05:622a:1189:: with SMTP id m9mr754549qtk.589.1643944083741;
        Thu, 03 Feb 2022 19:08:03 -0800 (PST)
Received: from [172.17.0.2] ([20.124.180.70])
        by smtp.gmail.com with ESMTPSA id c127sm398411qkf.36.2022.02.03.19.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 19:08:03 -0800 (PST)
Message-ID: <61fc9893.1c69fb81.d9930.239f@mx.google.com>
Date:   Thu, 03 Feb 2022 19:08:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3165341554862536093=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] gdbus: Emit InterfacesAdded of parents objects first
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220204013620.2465024-1-luiz.dentz@gmail.com>
References: <20220204013620.2465024-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3165341554862536093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=611174

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      1.06 seconds
Prep - Setup ELL              PASS      53.53 seconds
Build - Prep                  PASS      0.81 seconds
Build - Configure             PASS      10.72 seconds
Build - Make                  PASS      1499.10 seconds
Make Check                    PASS      13.01 seconds
Make Check w/Valgrind         PASS      539.50 seconds
Make Distcheck                PASS      285.04 seconds
Build w/ext ELL - Configure   PASS      10.78 seconds
Build w/ext ELL - Make        PASS      1464.28 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3165341554862536093==--
