Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11011C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 10:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbiC3K1Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbiC3K1P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 06:27:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CC325FD6D
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 03:25:30 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id m21so1978999qtw.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=K8W/osHwcalT5X5AUy+Efm3I/B9s1Uy5sb4xo8Ha0Cg=;
        b=XvZ68pE8CMJrC905DReX1Ff9n+aIurtQMrUpyVZF6ATYhR0r0LFe46iyTWhrLF3Q+X
         nMh9OiA5+pwvcg/DwvMWy+4nXcKSmLjUvmUY2GhMB46C4JtbMQT5rpuuX65uKjW4sy2f
         DxszkMMsFL08r94OLA0qxq4EzNGgmtu69kEUc71v9ITzZWbGlYbtCes9FhdO3gKkkDns
         coeYxjDrQ9pZclL2g1mNjTA1QlCO9DdxnFk6lVbodM7GfUAdYDqzr9v0SqB075Ir84V8
         1dMRQF7OlkEgFlozdCWUt4GDR/Ypm3lsPibGmShigGDlKLPWbu8y11Fj3lA54cQa0vbK
         Eksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=K8W/osHwcalT5X5AUy+Efm3I/B9s1Uy5sb4xo8Ha0Cg=;
        b=bhYCZs+FxdzrNj8A6rwL089gVjS1xGk+73hxLclaq9Z/v7Imj7MGC0/+9xq5Tf/YX6
         IgzDhqzAI+6I0Un8f1s/+GE6wvis09Asn8G1nMWCb1ZDWBa8Y3wuIbDB3wC8ckRNZxGW
         M2qrVGqnA5mPtD30fLwFsHFPtWSbonOtzS/G1mNjKXQ/EzP5F9NnO5vxuviup3Q++tPs
         clvSXmMqJZPd+fFxuyNa8EDfS4JBUBD/dmYmzRfAWfT2zV5Xj3iLdNHtt1OILyTG6V4G
         FEjLe8IPSyUJpCHrP0N3ihEmvXabXbhuNLuKpcMmz62w41onYN/fnCJmdkIzjXg2PHMB
         tRRg==
X-Gm-Message-State: AOAM532lpBwIDAwXI48Z7TVzISdAnT7vTROQh0xpjgN4UgXQNhrI/1nK
        tsabcrKozAjNYwaWCRtLGr2Nyvl51RS8EA==
X-Google-Smtp-Source: ABdhPJyHt1shUY86mR0woWxt9l1leGXGyTv7Jmn2kET1UBXvSiEm4Vxtq6go4N51SGWIQjBhNHS7oA==
X-Received: by 2002:a05:622a:13d0:b0:2e1:cb3e:bb8a with SMTP id p16-20020a05622a13d000b002e1cb3ebb8amr32200578qtk.16.1648635928955;
        Wed, 30 Mar 2022 03:25:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.95.35])
        by smtp.gmail.com with ESMTPSA id q123-20020a378e81000000b0067eb3d6f605sm10626710qkd.0.2022.03.30.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 03:25:28 -0700 (PDT)
Message-ID: <62443018.1c69fb81.22a44.729b@mx.google.com>
Date:   Wed, 30 Mar 2022 03:25:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7417651155012791011=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v5] a2dp: Fix crash when SEP codec has not been initialized
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220330092844.44762-1-frederic.danis@collabora.com>
References: <20220330092844.44762-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7417651155012791011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627436

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      1.03 seconds
Prep - Setup ELL              PASS      39.06 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.11 seconds
Build - Make                  PASS      1200.66 seconds
Make Check                    PASS      11.06 seconds
Make Check w/Valgrind         PASS      396.26 seconds
Make Distcheck                PASS      206.83 seconds
Build w/ext ELL - Configure   PASS      7.82 seconds
Build w/ext ELL - Make        PASS      1180.16 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============7417651155012791011==--
