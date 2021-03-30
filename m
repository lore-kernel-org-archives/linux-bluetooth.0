Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8351DC433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A24761957
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhC3SzJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhC3Sy4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 14:54:56 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D441C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:54:55 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g24so12684348qts.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=FR2J1vf3qxkdIxbX+aRJxxRJQb/Ay8b9/vVL4leh7pY=;
        b=lhtqc6pLqs/XcKG/89ocyU//kuMo2AtnH5A3NvbLJVirVoJj86rCmMLUoY8Ku4AhQ1
         DqZQIZa5PR40r6cdwFeHO7gfQnmi+ccQRGBlKEALHlJoAI2Z2Ai8PqqMiS6IAe4zt2QG
         N8I7l35a0sQXdULl6a/uMz8CtMH3A31w0wb+yW2dlj+EZ1Q0jQeMokzLY3OWBNbMLnhv
         T2jT3SW2VWR/IVTVt+/s839oteZC9Mw3uoO/LHPmSCj7g0bHVlMlexWMNU/fyQJMkVln
         9wbUAiAIi6XQ7Ci5mfQmqJ4utNscCoNYaTuB/DFUxIYiUCvdlLrHJ+MONxcVd49WkKSc
         2waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=FR2J1vf3qxkdIxbX+aRJxxRJQb/Ay8b9/vVL4leh7pY=;
        b=pjt0AoUUvm4LlAmRmavKFJPTPWQy8ejfHfGi9tRgpfJvCAAVfIHDb6FT5rqydGK3Y/
         AYdsCAtcYxwKBTwK3tchsXmGkDtLipzufdH2JD5tnsUQsQV7SFx2DUfcc/os7Vf/rlIn
         frjuZDrL3uNljO/RIbAW5isVQEv3Qs6304RdWyeOxEVcUoS22jnDmmjiSFf9+tRfTHZn
         X1Oo4BcJde4W0NPRLungRGnkxGOGKmbkb9WtpQ2eBz3uSnYsGgRYoQz3GGezmuYcCtPL
         7B0hNT+54J88Uvl2K/REjUv2s4+rfj+WIs+e66DTIskZYb0St9DZopSsDm246/FYJGk0
         nn8g==
X-Gm-Message-State: AOAM531IypAiutsY+wlC0AxLEMcrZZwVNa2jTFWXx9JxIDOTSx7OhXVc
        nHlyX4HKJTDA8LcDvz4LFkzR5ARsnjZ6ug==
X-Google-Smtp-Source: ABdhPJwHjpuBHR8wT0m3JZN17Be7AkugQiAyKoaaaGeqJK/jEvU7GqUbfUN+wI3S635gJSii2DMqJg==
X-Received: by 2002:ac8:7f52:: with SMTP id g18mr29514788qtk.250.1617130494662;
        Tue, 30 Mar 2021 11:54:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.219.108])
        by smtp.gmail.com with ESMTPSA id s28sm16387811qkj.73.2021.03.30.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 11:54:54 -0700 (PDT)
Message-ID: <606373fe.1c69fb81.92bf4.50aa@mx.google.com>
Date:   Tue, 30 Mar 2021 11:54:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5688340054544040468=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v2] profiles/battery: Always update initial battery value
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210330182319.17537-1-sonnysasaka@chromium.org>
References: <20210330182319.17537-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5688340054544040468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=458273

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


--===============5688340054544040468==--
