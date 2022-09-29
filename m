Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D38C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 20:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiI2Uet (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiI2Uer (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 16:34:47 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB212AE5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:34:45 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i3so1626819qkl.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=C3OMghK4yYTGkx2WBOJC2PLlUU6xRy1vNiWryrYbxT0=;
        b=pz0FBUl+Lw962ZHIPVzrAJQ2douu89mFzmbce7tQw6XbmT1J0om9Yqu5BWUFreg6gQ
         Gc6G/aAtHqAvJWldSaSqQzTUIfT4PGXoC/tiel5deJrudBpDJOEfaDo/StBqbnHYfU9h
         PU92NmUgWERrVvj0Kpe4RZ8voJwo6jf08EMaHQ87iJqDC4Ng9MV+WAz8WQ8Tb0a6uZ1w
         EaL3t2DTQke+Kp8xp9rqs1OYXWHB4OvyAk8P/GmsWInxf793yAQ+cNZRunkxFKXK4LaW
         r7fD4PKe2HOFQz52OjEP6ANEcVegbU+8WtsABhTBz3ELlrZFOka5GCF+o+aXUihmXWf5
         sxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=C3OMghK4yYTGkx2WBOJC2PLlUU6xRy1vNiWryrYbxT0=;
        b=yXcFncSk8C87tHSvc+d9HGTT59RLUqRJMJr3yeP6GWmVPwN+2GlUSgfr99wIMHQXkY
         hw4cBnwQ5d32ZBg3AORYkZeKnmhNrPGHFzaAxRY4WhhOWLeGtEmkAwAsS0jOZ9aQ1R/8
         PePnzbHENx4H+gi2oQld5MU4m/SgFkMpQwFOcO00tpotJiRLDXlO9VYiHV2Ko1uVww4/
         uVglTwuJIl6qgL/levaXnI4kJl2EHdBxBrzikGXxNN5L9REs3nw2FS5C1KnT2vgzV2vG
         +2hOoWU+xPT7lXOyDC/R4+MCYv4r2BKRIQZSRDd60eHOHcKl8W5i+dnth63LcDlqB6LG
         guHw==
X-Gm-Message-State: ACrzQf1V57VdcEZD1poofksc3M8nJZZPTrJZ3C0ql4ZiFITUCldf1hxH
        Q1DuSP7dMY8pGIdaWQgZJebeM2eBTQ0=
X-Google-Smtp-Source: AMsMyM77byBVdOphADkNMQmXVrybjkY1B5nLsWmu4PxA4TnZoZGgld8yhR+BTnDg/hQcIxk9kRsCrA==
X-Received: by 2002:a05:620a:13cd:b0:6cb:e443:e97a with SMTP id g13-20020a05620a13cd00b006cbe443e97amr3597781qkl.449.1664483684591;
        Thu, 29 Sep 2022 13:34:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.99.219])
        by smtp.gmail.com with ESMTPSA id r10-20020a05622a034a00b0035ce8965045sm167091qtw.42.2022.09.29.13.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:34:44 -0700 (PDT)
Message-ID: <63360164.050a0220.8266d.0867@mx.google.com>
Date:   Thu, 29 Sep 2022 13:34:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6632054288037876358=="
MIME-Version: 1.0
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
In-Reply-To: <20220923145602.25872-2-ceggers@arri.de>
References: <20220923145602.25872-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6632054288037876358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/advertising.c:1055
error: src/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6632054288037876358==--
