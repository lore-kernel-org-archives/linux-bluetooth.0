Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C54C49EA5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 22:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEE561164
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 22:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhFXWin (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFXWim (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jun 2021 18:38:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E6FC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 15:36:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id a2so5935629pgi.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 15:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Yrfs/rwcYEKFQR+gQyrCZCL/M7N/pwH4o4ysiBKUK5o=;
        b=KEdHexWgzD/CXVhQ/W8kvg2XIio0Q1854np0remBGzKlzpKmESCFt96Jn3Sw3PNlcl
         8yuXtBAnY8VmcRCXxT8R0xezsUwBVlQY+La+82q8dHLX8PiPna4GvdHr8QS8wQhmd5UY
         s4t5WbvXTHDZ4Xq8hAWUHbklZdfAGYsDp8ljt/TQ9SoYZtmmqyCm9U8SuVdIwEOcqlfE
         vUlDoKfU3kypAZjgMrQdrnqKT0lPpZdU7DRTuJFXjw8xILcmYE5SVwUO8O7oY51/EoVz
         A3HCddFip6WdbKnGhn9vLxOJ7N7Bj6yt27TMcuZGV72qAU2F3fhLmaQH2rvp2RuVACcL
         EZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Yrfs/rwcYEKFQR+gQyrCZCL/M7N/pwH4o4ysiBKUK5o=;
        b=U2pAIChFMlqvsfZ7DviQ211fDnX2iVSTFHzG1HTsGrvL15nBGdadlXPuvWU92YFQ7S
         m2Fl3tUjkkwzmv10FzGF6tAOdDCjIEvj2/podIZckdf12vBg5XZzYEbN/9VU0GwY+BCG
         /pFvfnNvvVG8sBql1j6CLq7UDiydhYzuKDAfD7+qBMSYS/4RjmjM9tSdbI4yy+tB8gp1
         nBN9P7Z7+pHRCU8IWWCqb6pqTeMn00JRz61HTojt+f1G505YcAqH/WJ3KeNfQh4FxBvj
         B/Xkzj+vt9eBtBWClWP3M5/uyF9j/oxMLGTF7T9KsB1PhVNzoUdM1M0BbxIw5QxKreDO
         B9mw==
X-Gm-Message-State: AOAM531lDO1zBExVsCsfu0+HVGIQejNXH9kHRd3ff936//4o/grGwamp
        z2UCknokyASclv1RTzkXBPQpeoii5U0=
X-Google-Smtp-Source: ABdhPJyefeRkWibzLG5U6ygoUiWXS4EYdmJt1avz6V4f46xK9BlY49fMpnGhn4W2hSyfB90GatQ1/Q==
X-Received: by 2002:aa7:8681:0:b029:304:3432:ba2a with SMTP id d1-20020aa786810000b02903043432ba2amr7352369pfo.40.1624574179869;
        Thu, 24 Jun 2021 15:36:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.207.217])
        by smtp.gmail.com with ESMTPSA id x5sm3703662pff.37.2021.06.24.15.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:36:19 -0700 (PDT)
Message-ID: <60d508e3.1c69fb81.879fc.b632@mx.google.com>
Date:   Thu, 24 Jun 2021 15:36:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8014642022621290984=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] adapter: Fix toggling of experimental features
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210624220844.3920039-1-luiz.dentz@gmail.com>
References: <20210624220844.3920039-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8014642022621290984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=506771

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      43.31 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      7.61 seconds
Build - Make                  PASS      188.57 seconds
Make Check                    PASS      8.56 seconds
Make Distcheck                PASS      222.79 seconds
Build w/ext ELL - Configure   PASS      7.66 seconds
Build w/ext ELL - Make        PASS      177.18 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============8014642022621290984==--
