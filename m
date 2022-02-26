Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC07C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Feb 2022 08:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiBZIZx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Feb 2022 03:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBZIZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Feb 2022 03:25:52 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3C02AFF6B
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 00:25:18 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id v5so6477464qkj.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 00:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Rg6WVKPH99R+XHoyV5OrVd0M1ZjIoY4Vl8YZ3xfsZBY=;
        b=pHAJTIhysYYEzf3rQaZSzBVt5bTuFdd0RVWIdKmj/KlU9A6AYMDBCrBlGY9k8cn0fL
         RbptH9WXZNzxxhgo+Wr6kDAGAEwoV1U8IHT+vshg4GBvQNkq5cwJ8znFzlDJkhy9888U
         HkifOv7mVkWy3kIiQyWMeoSUqd0zMYdYq/Y+xxaYg0p9K3Guyvt/dTdqVNdJKuDy+1rg
         BkxzWTqEdsjgB1k8+UjuwFuZ5SPxtcwRy/Q8n1LilkuNsPcn1cEhF8sLTcbV0NvIsK9T
         DH/YBzPXXosGZ81rs8gfD2vooKg+wFJiiOWO9UNpkYy4kWW/XujEdueYUsIOdnbXL97c
         b42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Rg6WVKPH99R+XHoyV5OrVd0M1ZjIoY4Vl8YZ3xfsZBY=;
        b=uoDImKI/wHZqoIY4/pF9B0VmSI0kGSxyERdLni20w2Bvd/Ejs0FEmILVXvSw3n9Xzt
         Ehcl2MQFDqYC/iY280zdoXcwKttfJzEuAgA+7bxknvTx+2wqu1EwalrQ7267sKz6a/Z5
         0BZMPzptuxZKx7lvESlNdFLrWTzIaWiC/RlDPcbR9eEijFqcjlZdpcBGzI0O0jCML8PJ
         zh864ZE86vWhhqPm5glC39Bykqa7PJlNijYAAL2WHE0R0hkjx2Mt/QWN6YcIu4g5cuy+
         Gtnn+cutrvA0I4FmNF/eBBYQxn7JHXIhaSeZjfkLwMuqgtZbXMpZZqy1nNRidvU5Im/b
         yiVA==
X-Gm-Message-State: AOAM533Sbn/CFJBEhGzw4dIb5j25pfO9Ec9VJD0iTRnuvEbbheaQX4yt
        yC8/HXy2z0AzVBhsGiyiiQVYga0mMzPIBg==
X-Google-Smtp-Source: ABdhPJxUexq+LmKfPAemxodxlob1aYEqff9UCVpadr26o4RpYYKDhUCrWHsa9LLl7HRZeoKtvs7zmg==
X-Received: by 2002:a37:bc45:0:b0:47e:292:4b8d with SMTP id m66-20020a37bc45000000b0047e02924b8dmr6786070qkf.484.1645863917621;
        Sat, 26 Feb 2022 00:25:17 -0800 (PST)
Received: from [172.17.0.2] ([20.114.226.247])
        by smtp.gmail.com with ESMTPSA id f13-20020ac87f0d000000b002dce143f369sm3054467qtk.53.2022.02.26.00.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 00:25:17 -0800 (PST)
Message-ID: <6219e3ed.1c69fb81.5fe35.3180@mx.google.com>
Date:   Sat, 26 Feb 2022 00:25:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6326840766765100020=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btproxy: Attempt to bind the next index
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220225215505.560382-1-luiz.dentz@gmail.com>
References: <20220225215505.560382-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6326840766765100020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618201

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      1.12 seconds
Prep - Setup ELL              PASS      49.94 seconds
Build - Prep                  PASS      0.81 seconds
Build - Configure             PASS      10.22 seconds
Build - Make                  PASS      1453.81 seconds
Make Check                    PASS      12.85 seconds
Make Check w/Valgrind         PASS      516.33 seconds
Make Distcheck                PASS      271.07 seconds
Build w/ext ELL - Configure   PASS      10.39 seconds
Build w/ext ELL - Make        PASS      1434.14 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============6326840766765100020==--
