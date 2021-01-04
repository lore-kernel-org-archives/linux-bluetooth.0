Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4240C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 18:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D7E206A4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 18:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbhADS6F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 13:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbhADS6F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 13:58:05 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D28C061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 10:57:25 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c14so19243405qtn.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MTuixOIMgWK/sUI8uoExsAQ5D9mx2d52xQ+EnEBWHbc=;
        b=mFP0X5P3BlUfFi+3/px2QrkExJAAUnCVKptI9TJwRGP4nodPOgLByGX0Y/8ZoHdmpk
         9VESZmW80609CfBONwklgBG5obHygfdiqeROuMZy4bPKtNs9Jr3cSwn/5IwgRRYOaDua
         JoYOJvWnKn4kA+3NhTZDrwRj8Y9t5ebutCQ1cvmDHjnuxju45a0msBA7AJuSsv3I7HDB
         /ElGbe5hxOJzA6PTSIjV905MH8TemPgY2O2lNorse3yjecLrV+7zehMWLZGeYJF2P7xp
         WupVk7ddLLvqWBtRUBgNDnNAZB8Qqup52x3ug36mXyx7B5P76LKK7WXucDktXGxtbz05
         Uz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MTuixOIMgWK/sUI8uoExsAQ5D9mx2d52xQ+EnEBWHbc=;
        b=cbNgnC6OLXLc6O1SZkk4qN1Vs8n4LJjNlLQr7D3tm+gSdqf3DNa3c2XisqXXofgLit
         4ZpniD6yRLHslvwmbrFF/Ze99TzzgazLvBdyZSKX4ttCoghhgRSz+5kZpK03t9BscNZg
         ZwTwJO3CSm7jrkeT96VnoZ1JCXu+pLQfWrJ3I7cwC2Dd9rON2FJEFkFYX69DPNBzklZj
         m8dBhyTjfQndcRs8aDTJC3opp3yXKmbsCX07Bl+hhrmHqjXwy6NGaUWqyYu6np0HUTVF
         4jBkbMQOKZSAPy3W7cbE5RU8UHluGwaR7Tn2WieawMLG4H0fclFZOZ8x/rywT7wRDbrG
         pLLg==
X-Gm-Message-State: AOAM530jsFs39N5xIDO99NFpm76hZdIDAHJmK7UX+uh5ivSFSvwlHC3Y
        gi0bs+sqnCdnhT/Ut49EPxAUOF8hNwmLvw==
X-Google-Smtp-Source: ABdhPJxOCMMS1SiX/cSRm2ejynCOndZ0EUIqTIno5a1MfO3+RPST/1yFL6mWWml+tchlCLTXys6wdQ==
X-Received: by 2002:ac8:4648:: with SMTP id f8mr72823336qto.5.1609786643556;
        Mon, 04 Jan 2021 10:57:23 -0800 (PST)
Received: from [172.17.0.2] ([52.167.43.162])
        by smtp.gmail.com with ESMTPSA id u65sm37750554qkb.58.2021.01.04.10.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:57:23 -0800 (PST)
Message-ID: <5ff36513.1c69fb81.b21ff.f493@mx.google.com>
Date:   Mon, 04 Jan 2021 10:57:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4406739830181126424=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] gatt: Fix potential buffer out-of-bound
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210104184153.3218489-1-luiz.dentz@gmail.com>
References: <20210104184153.3218489-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4406739830181126424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=408793

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============4406739830181126424==--
