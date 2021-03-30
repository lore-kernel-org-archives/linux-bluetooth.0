Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CA7C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7968A619B9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhC3SEe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3SEV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 14:04:21 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EC2C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:04:20 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z10so16732380qkz.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=W0WDjLLKimm4jJr+8KLjO3k/66diBodVh78LiAeo+P8=;
        b=O7H6lUNUjQquwV7g/1/ZVZ0jx0N55GKqQWeNCgXrbZPkzTFic6tv6GaIvYMVMMipCo
         CwXiYvz7phBGCzXeeMYPynF52y1/pqdgHzjn5V/jL/Pj6wLpT+sl32N91NswRDJ/PSe2
         O3SWrTwJzNHBOwffpwZ+UcHcysH8xY3cFFS3HREMJjvk2LODwA6H00NiKmRwObLMyUk3
         0lua6q1fhu5taiwswqFGzEy+NcFrypq53JG8sFRrybMmbMcxAMCdURFLNKY2ZbXuaAOF
         BueZyS43sWGeEfFApQpAb0rYjZ00oRC2r2iSCxhOfruNVmTWYCwk/4HdgHq5AB8J7uEy
         fpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=W0WDjLLKimm4jJr+8KLjO3k/66diBodVh78LiAeo+P8=;
        b=h9++6BLEucdtgQiQ+cNhtjqbDIM9lz1n2EPLZfc7u9+JnCOYKkmREPzzgrvG7XDK/9
         7rDb08eYarUYiyAZTj37o4+YBZOvlkfeddTefoAp+NtonNFd95sgRIoWH4wYSQV4YHgf
         73BWvciruCrzM8SFZ8OReAD7yDRwLBhMhyyb6YIU+eEIh9nI4EFJI4wkQp8Jm/6sozi0
         qVb4HLm4tZyxK+6l9S1J0pnYuoAwK4wLTkJQ+Tpe+ktMWPuMA7mGsW2KUwWaAdsXiogR
         bqG40Ron0txcwmfIuO4mRvlsYkZItsmwSwZJuWdYeSQeHp/5nbLJzZVIdFJtg5NjA5vw
         6unQ==
X-Gm-Message-State: AOAM533CIGPKqrsyk8JdsW5apLlOt6Iqi31w5hSJkTcnU3hQ7C9d33fu
        bkYRkxdEE07FCVybUkYHWxFqeqwM+Sw=
X-Google-Smtp-Source: ABdhPJybR89YregU1kFnNg7jj8oDdlET1GOEDp38dDjDVv0U3K8cZYnQUSmssWj5Jpfog703fsONuQ==
X-Received: by 2002:a05:620a:20c7:: with SMTP id f7mr31054674qka.156.1617127459830;
        Tue, 30 Mar 2021 11:04:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.147.164.189])
        by smtp.gmail.com with ESMTPSA id 18sm17087087qkr.90.2021.03.30.11.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 11:04:19 -0700 (PDT)
Message-ID: <60636823.1c69fb81.d4110.95c4@mx.google.com>
Date:   Tue, 30 Mar 2021 11:04:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8267480566764197188=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] profiles/battery: Always update initial battery value
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210330170924.16983-1-sonnysasaka@chromium.org>
References: <20210330170924.16983-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8267480566764197188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=458223

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - PASS



---
Regards,
Linux Bluetooth


--===============8267480566764197188==--
