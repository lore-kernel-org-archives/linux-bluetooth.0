Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F35C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 21:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DDB6120E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 21:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhIPVfq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhIPVfp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 17:35:45 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3187C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 14:34:24 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b64so11066880qkg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=gF503xYlvPjIimzndi7+J5SJ7ikE0tkZckUEClgTBNI=;
        b=fOZPZxFqxzqmIq2Vki6GiN9UvSzucVwWGrPjelFSzMXN8YJlXHCdwanG3LjWw+EcZV
         L8gIV1fZsG8wUooCs8OmZ59T/kYgKz6vlED5QvyvAYPPYZH3fJyVEeNshNaf4v2ERmWl
         DNLo/lUbhYAtLeOYX/ODravcEkNSANw9AKVffViceRzSDxkOBG0X4JgdBZ0G4TmHha3u
         YSkZ5W/E4he8EJ2B9FesNkhkpgcN1q2kZXXV//pHOBIDMCQTQuA+fZnwLoj5lxzfjavo
         5QOD32vJBpaY7ypY15UXwh21A7HCzBaRefEFuJmgE1j9SaGRxE4gmGs2aUE0zH8bdvzY
         Hh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=gF503xYlvPjIimzndi7+J5SJ7ikE0tkZckUEClgTBNI=;
        b=K6zCWJfSaL4Gj+VgGcJzzuVgRdWKvIdhcU8EcwjWYINkA0GM2DVfybLnuFFDLACYQO
         NDVS/7HX7DYO1l+A3/YCzYKeV388BFisoG83Twmg1MG4+faKAlZhB4K6BtrRFzSklLAQ
         2FalYxNoYk/VYh82ScdLexmsfZTA8COq/QBVxYS4EudfJ2nOezToaAUskZcVAvv6rHmB
         WFM05g3PmpxD/6QmQ/+AzVYaEwCQBISTtOlQj1C/p5sONhZo+XRJfWEVLaeMtfvZ7VEf
         Xe7sRkXyrXSObeDJI7W1Xec8b21zMItTdFSzzClROGOekZ9hPo42Y9vKr8are7ZNHXg9
         uhug==
X-Gm-Message-State: AOAM533PaJCnS26iDAJaFbVN5iZVt2jtaHy+DeuT8heAD2M9Nm5EwQet
        uMLwXq93pFb0LO30/NPHhqZpc6zJCl9Wbg==
X-Google-Smtp-Source: ABdhPJzUufoBveGmedV9dEs98zmkr/PKbA4M0YZCRnJ/4n+ETGWC2TcRnLyS4xgqe3JkrCvrt2jupg==
X-Received: by 2002:ae9:f40b:: with SMTP id y11mr7265052qkl.107.1631828063703;
        Thu, 16 Sep 2021 14:34:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.225.177])
        by smtp.gmail.com with ESMTPSA id h4sm1800641qkm.109.2021.09.16.14.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 14:34:23 -0700 (PDT)
Message-ID: <6143b85f.1c69fb81.8f3d3.f7eb@mx.google.com>
Date:   Thu, 16 Sep 2021 14:34:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3269556320981061603=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] service: Add btd_service_is_initiator
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210916204020.118310-1-luiz.dentz@gmail.com>
References: <20210916204020.118310-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3269556320981061603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=548445

---Test result---

Test Summary:
CheckPatch                    PASS      2.81 seconds
GitLint                       PASS      1.91 seconds
Prep - Setup ELL              PASS      50.54 seconds
Build - Prep                  PASS      0.54 seconds
Build - Configure             PASS      9.26 seconds
Build - Make                  PASS      222.81 seconds
Make Check                    PASS      9.35 seconds
Make Distcheck                PASS      254.55 seconds
Build w/ext ELL - Configure   PASS      8.89 seconds
Build w/ext ELL - Make        PASS      206.22 seconds



---
Regards,
Linux Bluetooth


--===============3269556320981061603==--
