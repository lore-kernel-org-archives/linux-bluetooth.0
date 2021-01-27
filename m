Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8025C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 05:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F962070A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 05:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhA0FnF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 00:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhA0FJv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 00:09:51 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E46C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 21:09:36 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id e15so607796qte.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 21:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jr+PyXSiQHEK43vmeyrgvw+1JHlTjIbjZpXPx2W3COo=;
        b=K2Ek07o5F0Qe7lcCGM+wh5ATySRtvmScQWIF+K8YQzfAXILN+MQe5srcPWi3rPQ02Q
         d1Ux+BMEZZMEFQyFWX2c7pkrk37zciTowCXuHuFvFxD8JEsgnN2BWfySC2/KNMz1cnDi
         r3HYa9KNhwiObYoNzNiqhwADuDqVd/5KJ7UA1PpGRf9MfX1ZmJvqwlkQ9vxXrEZh5Jq3
         Mw+dIqd62JCN4scffQvNKsNhkfspr9nYqoeZHDv8w8fVHlvESoG+AELtIMwQetlrafYk
         r0MMO6dHjN6/LKmTIUNjgGimi3U6iVRTBxY7yUNL9QxVgzD0NU6nvv/fs9HPHV5Q788V
         JdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jr+PyXSiQHEK43vmeyrgvw+1JHlTjIbjZpXPx2W3COo=;
        b=f3zAb/SwAvW9LQkZsmszjREU6/hIR91PFZf4YfiFxxcMNHbVzGr4RCHxfyxhW1OMRj
         Lqzwzxg3U1GDbyxEJeETlWaPhouows2AqDV8QDIWXe41hiNaLwIb7Z4uWP7xvYYk6oJA
         r2+Qu3/ek7wRWqFeLUTsFYgMzXcH9vA+s8bNN7sC/yeButTuKWVJoDgN2os/KfbcpZxx
         j3hej1V0emLgpAPW9u3NOclhbGoi/USShnWca2EvySA9Wp62Z1r38563OgqBd1y/62cQ
         avfdoH441S/UXH7ez/Y/qM8g76b0ZtgKk7glgJGwG30dZAKaghBKTfdEWDkT8yawNMfH
         EDOg==
X-Gm-Message-State: AOAM5314TAv1q5I9FTSRrW9r79cKzXoD6oO+6bav4wx9VLo6MiX6S3WH
        n0qynBWVEVIHumWolr6OK/5yvWWfJsDTZg==
X-Google-Smtp-Source: ABdhPJxq/LfAnndagAxn5whmWB6j5SplXuM1JFQJ2llz2btUKNZWg0LsFiKp7RlQDf9do48iZuUM6g==
X-Received: by 2002:ac8:6f12:: with SMTP id g18mr8160546qtv.125.1611724175357;
        Tue, 26 Jan 2021 21:09:35 -0800 (PST)
Received: from [172.17.0.2] ([52.177.220.77])
        by smtp.gmail.com with ESMTPSA id h22sm609537qth.55.2021.01.26.21.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 21:09:35 -0800 (PST)
Message-ID: <6010f58f.1c69fb81.e4eae.4049@mx.google.com>
Date:   Tue, 26 Jan 2021 21:09:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6755642787450298403=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [BlueZ] tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <7ce3b84389e123d1d09dc110377ec369cf7825d7.camel@linux.intel.com>
References: <7ce3b84389e123d1d09dc110377ec369cf7825d7.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6755642787450298403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=422527

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


--===============6755642787450298403==--
