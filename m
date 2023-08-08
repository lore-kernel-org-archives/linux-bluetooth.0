Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DE9C001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 21:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbjHHVUt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbjHHVUd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 17:20:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9FC1E329
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 12:26:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686b879f605so4295087b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Aug 2023 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691522799; x=1692127599;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pH8SQnUfDoRtGeWRnfzkn741WTDialp8ulM9er9PUdk=;
        b=PCwmkK2QjqttFAMGy7wnJZeYaEdb5uIyXNy/8WkZO66MBIXcWGUnRzxVOWUC9KawqR
         ef3OvtzduUzzW8WDnt5lAYTToi5YWuLnMMh8wiEcMwo6NYCmjGj4G3AiY7CXMvj1ohu1
         sfUfZME08jgQpp6uvNMqBeE/T0VZP7UpOlVWqHhgZhykJ/sV64t0tHNP+/YMCqCNgBtu
         wIBxQDLi395tl2lQ0DQOy8aocTjYnd47iJ437XZq7ZyNjn4a8Dc/oSGlhfKs4GysZZSe
         HH+PD5mXX5yGGY+A8CLfPQqYdz7505eTA0WY/Zc3RfbxZg63SMNRq7gCoss0g3aKmCwd
         RfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691522799; x=1692127599;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH8SQnUfDoRtGeWRnfzkn741WTDialp8ulM9er9PUdk=;
        b=CqLmHblCnylUS8m18ClMeV7Nk/gLOpZzsPe6hXZIZ6cMmoTNxQw5WPdyXfSk0tNxQF
         H3gt+jD9mUk0ierR/RfdpkIDwtr2gBky4fgSS/mBvo1YRHcKnRHJV8DxUuMvXHEAWo5i
         +1Z5JYK8bOYjCjO7pnXf4QeDJq1Lm3FGjUbWgT4dN+uhDHVf4U4suk4RlP5ii7RJGlYr
         I5mWbKlthrMndN01PNQsAWZh6pkXyv8nV46mov+KQMqaYZLtEe99SHT5NGBBW4aEeUn5
         IqXpvXSmKAoSIOzBAu+MjsBS34Dl9c+YIkQoqfeibTWCR4v6JzU3Kl3RzGDq3NGgOPLv
         MFcw==
X-Gm-Message-State: AOJu0YyZShPa5LhYMvSWcIEDb/wC7fFa/kq5Bs6ItWMKnhUOwS40lRqf
        9UbhrPyvY3rtL97+OibAcAytGUIlXUQ=
X-Google-Smtp-Source: AGHT+IGFSBhgwE0QBGz0k7NizHIU13JZyd7w83Rj8YIwb6shW1eMcybDpm7c500AUjRfeCph6ONQnw==
X-Received: by 2002:a05:6a00:1a14:b0:66c:6766:7373 with SMTP id g20-20020a056a001a1400b0066c67667373mr461799pfv.23.1691522798640;
        Tue, 08 Aug 2023 12:26:38 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.165.100])
        by smtp.gmail.com with ESMTPSA id e14-20020a63370e000000b0055b4307963dsm6993034pga.23.2023.08.08.12.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:26:38 -0700 (PDT)
Message-ID: <64d296ee.630a0220.303b0.d736@mx.google.com>
Date:   Tue, 08 Aug 2023 12:26:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6640420465186047312=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Add support for BAP broadcast sink
In-Reply-To: <20230808115040.4403-2-claudia.rosu@nxp.com>
References: <20230808115040.4403-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6640420465186047312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774119

---Test result---

Test Summary:
CheckPatch                    PASS      3.15 seconds
GitLint                       PASS      1.55 seconds
BuildEll                      PASS      34.44 seconds
BluezMake                     PASS      1220.65 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      204.75 seconds
CheckValgrind                 PASS      322.59 seconds
CheckSmatch                   PASS      429.83 seconds
bluezmakeextell               PASS      125.12 seconds
IncrementalBuild              PASS      6150.64 seconds
ScanBuild                     PASS      1404.48 seconds



---
Regards,
Linux Bluetooth


--===============6640420465186047312==--
