Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5612C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Nov 2021 21:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhKVV11 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhKVV1X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Nov 2021 16:27:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D562C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 13:24:16 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 132so19650589qkj.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HDcyJE0rnCMH5vqDIEix0zwhmeFXK8Jor7tZW/wU7a4=;
        b=em/L3JTCxk3PWbzG0dLxC/O6vLRnqTXHw69DnBakC66p0BR6RjfG5hKHxJZGkipcWL
         yICN9bRegaPDCy58x6EAxayRT3CanIzm0V1NEwOMkbN10mmSKoUWxaIEfPYD9EDX+Amd
         1+u5zyyhUf9MD4J0GvheETNMWrGeFA5c8QAYwYTN9yMXMeF3AUwdkBHtFu2qdbH+xH+q
         HBZwOPZf06jaSQdj4U2PgYtIwQpD50V7z7eDkXgWWixf/UJpcUdpYSUX/WPIx8t6O8Lz
         7QvdyVNne0FIw7hOZrO69HnrWxl78hgeSWbsqv9gUdcQrEJPLoF+15YHSTOQzUeIjRrH
         Bulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HDcyJE0rnCMH5vqDIEix0zwhmeFXK8Jor7tZW/wU7a4=;
        b=Ak3p8A4f4bougwdrhElsw2IxJpfUzR4Vy1zQpxcB3u1FZfAl1xHGR7kRADP30idk88
         iiutWdu9D0Bsq/CmqIGOi4e4HbgN4zBqOgfZOZVyqhNLSd8ynQqfiojfkfIyzrwpaTC1
         E7+Kh+b+NzAZv4EZ7WYg7yfu2xED91P0eFDHITBH9RncotUy8OXeymlk3RBSPqCBJyB5
         FtJKM2kB+hc/5mNBUqyCtPe5vs8ICZySh+5/gglpWFsdkS74dTxVgB8clDkNj4xyzygt
         XkmWLK8lfsa/nVp71tP30c36pBhG+DOlW6n+BfymWbEGmxsdJR+7MI8EZvJAumasWqY8
         tI+g==
X-Gm-Message-State: AOAM530LSctZjmRtphlV6FKLPJEIA4hE1tF5GhYcg9HWHHu36G4uToQY
        8srN5wvQlkOD8HtZgM/RtjmZCB5Q4mUJQCs1
X-Google-Smtp-Source: ABdhPJxXUufuda1MpH7fwVBjORCtOOF8tW4Mx2NB1l6bwUydoNRGoki+jzyYPRw9gO5L244fOCEciw==
X-Received: by 2002:a05:620a:2229:: with SMTP id n9mr51378189qkh.155.1637616255320;
        Mon, 22 Nov 2021 13:24:15 -0800 (PST)
Received: from [172.17.0.2] ([20.122.178.240])
        by smtp.gmail.com with ESMTPSA id u21sm5115625qtw.29.2021.11.22.13.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:24:15 -0800 (PST)
Message-ID: <619c0a7f.1c69fb81.a45c3.b235@mx.google.com>
Date:   Mon, 22 Nov 2021 13:24:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2472680362580517579=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] uhid: Remove local copy of uhid header
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211122211509.2216902-1-luiz.dentz@gmail.com>
References: <20211122211509.2216902-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2472680362580517579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=584155

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      50.03 seconds
Build - Prep                  PASS      0.55 seconds
Build - Configure             PASS      9.24 seconds
Build - Make                  FAIL      0.17 seconds
Make Check                    FAIL      0.44 seconds
Make Distcheck                FAIL      11.67 seconds
Build w/ext ELL - Configure   PASS      9.64 seconds
Build w/ext ELL - Make        FAIL      0.48 seconds

Details
##############################
Test: Build - Make - FAIL
Desc: Build the BlueZ source tree
Output:
make: *** No rule to make target 'profiles/input/uhid_copy.h', needed by 'src/builtin.h'.  Stop.


##############################
Test: Make Check - FAIL
Desc: Run 'make check'
Output:
make: *** No rule to make target 'profiles/input/uhid_copy.h', needed by 'src/builtin.h'.  Stop.


##############################
Test: Make Distcheck - FAIL
Desc: Run distcheck to check the distribution
Output:
make[1]: *** No rule to make target 'profiles/input/uhid_copy.h', needed by 'src/builtin.h'.  Stop.
make: *** [Makefile:10410: dist] Error 2


##############################
Test: Build w/ext ELL - Make - FAIL
Desc: Build BlueZ source with '--enable-external-ell' configuration
Output:
make: *** No rule to make target 'profiles/input/uhid_copy.h', needed by 'src/builtin.h'.  Stop.




---
Regards,
Linux Bluetooth


--===============2472680362580517579==--
