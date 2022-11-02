Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3F2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 11:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiKBLSa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 07:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiKBLS3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 07:18:29 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4023313FA6
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Nov 2022 04:18:28 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id b124so6372784oia.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Nov 2022 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V3l0C0Hv4Witx/wJyp/Qo3W+HDIPZdLN5NfZj2QX6KQ=;
        b=QVbpYu58I15bakYMOEoHZlaa2w9UHfrYDUmQmu+QL7UZe/2q2fLLGYQblLPYHVOhAu
         kJcVBNFSrSmHF1hyYpV1M71V1WBjrY0xEaO+LX+2qOos2gs0ZiAXCMGM20fBGyqkf/ax
         0EgyZx3g7rcDyx/qHfvkFZeRAiOgZELdI2vkcb9R8TWbTeqreM6dqIIqD7gjIv2i7EFq
         vAvbUNrnr8/C81wR0wbKlcxfp4iEUyv4KKQIoN0M9kGzgu0iOmlkNNf/xrT5M7uRHmeC
         lMg3bNKXw8D0QgzqpH4nPG8NGbg2MVz0N09uRJDoI0SQvMf9bh4S0aKiDI3TKqXiLl0g
         wF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3l0C0Hv4Witx/wJyp/Qo3W+HDIPZdLN5NfZj2QX6KQ=;
        b=nW2VCJTHdBkpwwlYumSX0F1K3v+ODPZOeOm5gE4yX5tzhLsaVhjOh1rXtPm69/FFmM
         kLqlEhFo6XqphAtSQXlhGOW7B+o0n0nNW71Raga44CBnjewqjtJcOC9wlULk0JBePgQe
         JdR+ZjAeSlJCZawd2PzwBfjk6oRH+wphZhbOxrspe9hIVqyDq7VxKB+VRdSL3gKUkQWX
         kkYI56EDMiNggb3CmwVzcH9Y+PR6uvWZcV7R6KVwR8qTUdFVTxbbrJW8uT7g1PcQUzRt
         /qsmemvgJ9NIQU6AUCxphm33IGH/YVojaumzH66kFTzb626nWZrQydWYps1l0WQu3S+N
         wKAw==
X-Gm-Message-State: ACrzQf2xMjMMYNKkMUulbbH0pb8ppubnkwGkJiiVO7sZVHnPRrbYh2Zc
        eGGFfNb9xY76vPSTpvpmsrTkW1TdJpU=
X-Google-Smtp-Source: AMsMyM5EauFjwZ6RiRdbfEJrHjwu+y5Tw05ZhqVb6qeiP8/BHr7Hqq7ucQ+DXbd+PDVQIWGtUOvVrA==
X-Received: by 2002:aca:ba42:0:b0:354:88fc:81b4 with SMTP id k63-20020acaba42000000b0035488fc81b4mr20968433oif.252.1667387907459;
        Wed, 02 Nov 2022 04:18:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.64.41])
        by smtp.gmail.com with ESMTPSA id g13-20020a056870d20d00b0012c21a64a76sm5824635oac.24.2022.11.02.04.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:18:26 -0700 (PDT)
Message-ID: <63625202.050a0220.a2974.53bf@mx.google.com>
Date:   Wed, 02 Nov 2022 04:18:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5562196278744735820=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221102101224.1463549-1-hadess@hadess.net>
References: <20221102101224.1463549-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5562196278744735820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691153

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.75 seconds
Prep - Setup ELL              PASS      33.82 seconds
Build - Prep                  PASS      0.98 seconds
Build - Configure             PASS      10.66 seconds
Build - Make                  PASS      1141.01 seconds
Make Check                    PASS      12.91 seconds
Make Check w/Valgrind         PASS      365.20 seconds
Make Distcheck                PASS      304.19 seconds
Build w/ext ELL - Configure   PASS      10.59 seconds
Build w/ext ELL - Make        PASS      109.91 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      676.03 seconds



---
Regards,
Linux Bluetooth


--===============5562196278744735820==--
