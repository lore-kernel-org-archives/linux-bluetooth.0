Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263E6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 07:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347945AbhKYHm0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbhKYHkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 02:40:23 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D73C06175E
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:37:12 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id jo22so3789219qvb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=86PJw2i8Qfn/KMyowssJR7rJgkfTe09C3g7S4dVcXEA=;
        b=E1Y1RoG6nVK282XjeYjWKdDeNvH3Vru74l1dNQFZyFnRxrV0OTCWccKJdlIZvECOML
         vIAIPGOng8IV2V1oE/1JBpE7LCJXfpgE8NOk3MJihozdkPQNMLCkWSPjxh9kaiTrmV3W
         1dYOVGTyqxdq5yXFKAO3zKH/pQyb1iLFg0oRQoObssmC0kcSawKlH73or8/rrmLms+MN
         WaQT5dKgwKsxo/Zf/YzCfwwyW5k1/KkGwKrAQ1Bes2SF8/kPqqv841Sj8JryGpzHd0/N
         s52dei1DD6dvjj/paeDE+UjkGlEx9dm/wBTUhBVTqDkCr94K1njO5oGGYklrCFTHZ02U
         AD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=86PJw2i8Qfn/KMyowssJR7rJgkfTe09C3g7S4dVcXEA=;
        b=GTDLcRlF3eChw8wDJyvV3CU/qFC2JPs0ELoOIKQjA5QQbBlUkRaBSrpvicVleDbczT
         mmpGVz9U721rrY46MC4C3SmRQEn31NMWSVRl4OjRSimXuckbmD0mmdMcym4Z3pkDQX4A
         etASIoTclATvAVrRQivqMACtQ1SwR/im0R7J+y8KtldgHrJVOE3CTgc3bBnUNkaYuBlq
         U15wPTqhhyGJ1u7cB7mLqTNBs+PBeKk1/XGpxeZtfOpSFtADUcGBrH7nrxXAj+7bubzm
         tM/pOwkuiCTQRjcxd/xxtSwEBU+bD4OAHm5FhD0yKt1p9olFdela6wfZno5BvPl3/Vj5
         WuPQ==
X-Gm-Message-State: AOAM533y1VtS3W6dnTo9OqySE8j5yDjUsoWeG8cf62I+ArjNMf0dUq5R
        yRJkm6vGXTVWe0F1NGmtmGfi7h4Tbz9OPNCE
X-Google-Smtp-Source: ABdhPJwkJtgdLl+b15EYhwc4sfRfmYc1h+gJBjW41953wRzja5vSW233+FUCcP+q98EHYyWE6oyODQ==
X-Received: by 2002:a05:6214:8f2:: with SMTP id dr18mr15670980qvb.56.1637825831562;
        Wed, 24 Nov 2021 23:37:11 -0800 (PST)
Received: from [172.17.0.2] ([20.124.112.76])
        by smtp.gmail.com with ESMTPSA id s10sm984676qke.132.2021.11.24.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 23:37:11 -0800 (PST)
Message-ID: <619f3d27.1c69fb81.eee49.61de@mx.google.com>
Date:   Wed, 24 Nov 2021 23:37:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5566249897514357477=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v4,1/5] mgmt: Add NAME_REQUEST_FAILED flag for device_found event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
References: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5566249897514357477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=585657

---Test result---

Test Summary:
CheckPatch                    PASS      6.86 seconds
GitLint                       FAIL      4.42 seconds
Prep - Setup ELL              PASS      48.93 seconds
Build - Prep                  PASS      0.49 seconds
Build - Configure             PASS      9.03 seconds
Build - Make                  PASS      215.85 seconds
Make Check                    PASS      10.07 seconds
Make Distcheck                PASS      264.17 seconds
Build w/ext ELL - Configure   PASS      9.51 seconds
Build w/ext ELL - Make        PASS      203.22 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[Bluez,v4,1/5] mgmt: Add NAME_REQUEST_FAILED flag for device_found event
14: B1 Line exceeds max length (121>80): "https://patchwork.kernel.org/project/bluetooth/patch/20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid/"




---
Regards,
Linux Bluetooth


--===============5566249897514357477==--
