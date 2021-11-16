Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0528BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 07:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66B361BD3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 07:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhKPHis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 02:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhKPHir (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 02:38:47 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9873C061570
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 23:35:50 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id f20so17831207qtb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 23:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8t/tXT1KZdv2QuHrJJkEWBXfuJEuhairUk8N7CiLdOk=;
        b=FmAgdr00JkoAfw/1Bj0teak0Mn5ZnKux1m9yjryMXm+kY92W8DZqDtu9AHcJTJPVq+
         zUGp47oyk/D5rFttbeU7HPYgeitFo8NE82dTP0cP+gr7M5CEYH/qv68l7jV8rbF+mHvO
         +hrTKUZDSLhBLV7p+qhn6XRxnjDv7c1InuA3kvDhLKc5qoqoUsFNPqtThqGO2XZPl+sj
         0q30VdCZUrxDX9pplQ+pneMgpT7ILehk2Cv5UyfTP5mRd92Lr2XE4nZuIADAs5B/GUr+
         HXGRu2JjbI6zaKu07yIEKbmajP6mZqbYgDF8a7Jp5Dc99GIALUDzOgtOOuLFDhd48f1x
         iGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8t/tXT1KZdv2QuHrJJkEWBXfuJEuhairUk8N7CiLdOk=;
        b=SkSge/Zvau5TKibYa719TYfVqj4o7/3GqbQTJpSKAYFJJGVFZqqUOnTpCK2W6K3upb
         oB/bT+r8dOVnIZUODGZOM6zqEUfyfMCIJZtpWqseBN/XDzrVB8Qw/GVBqeAWZpQq3FtR
         /S76NAiSU5d1DhJy8SjoMO+hykR/8J7t5h9e3RLsPsEgex626ba/uXbFoN/xIihm77+0
         Uz3mIG/DJIvKhAUTb9kgvRVXmxF/nNT1enE6R7fPPqHTIksYOHpi9m5yWzzdo5OioWEg
         4ItLbvO/pR8mbptQZtsjS4GZ2o9roS0DvZPReHzZdbhlCE0AD8jWmBDhSbY+ckA4UbgO
         2WLg==
X-Gm-Message-State: AOAM530+PNV76v31imVikDhd8Lo/0Nl957G2wjhPX5eRPFuCiAbBJx9N
        HOC9KyvgN3u5lt2+udKLxVqTz8zyS3Kf1A==
X-Google-Smtp-Source: ABdhPJzA7H8mUhHVWjWLQlKHfuC4WKwT7bQRUvZCcLeLFM4P0GvETDYwM+HQapRY5jzcSJN3Zq7EDw==
X-Received: by 2002:ac8:5fc2:: with SMTP id k2mr5497536qta.310.1637048149628;
        Mon, 15 Nov 2021 23:35:49 -0800 (PST)
Received: from [172.17.0.2] ([20.110.99.19])
        by smtp.gmail.com with ESMTPSA id 8sm7986956qtz.28.2021.11.15.23.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 23:35:49 -0800 (PST)
Message-ID: <61935f55.1c69fb81.a211e.d162@mx.google.com>
Date:   Mon, 15 Nov 2021 23:35:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2519164483005867532=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] emulator: fix potential resource leak
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211116064949.463398-1-hj.tedd.an@gmail.com>
References: <20211116064949.463398-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2519164483005867532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=580675

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      46.31 seconds
Build - Prep                  PASS      0.52 seconds
Build - Configure             PASS      8.83 seconds
Build - Make                  PASS      201.01 seconds
Make Check                    PASS      9.37 seconds
Make Distcheck                PASS      240.56 seconds
Build w/ext ELL - Configure   PASS      8.97 seconds
Build w/ext ELL - Make        PASS      190.08 seconds



---
Regards,
Linux Bluetooth


--===============2519164483005867532==--
