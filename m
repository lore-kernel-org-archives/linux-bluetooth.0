Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5345C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 09:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbiEDJKu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 05:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245458AbiEDJKt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 05:10:49 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1B615724
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 02:07:12 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t11so392772qto.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Rj8VN1b6mLab5Tsqa9mEO+dloUSa51la35sMfPA3S4g=;
        b=SIqkB3ECIAsqkL8JwzPlOOtBsr0DtZXLqXpB7ioG05KtV7ptwMUIsPXL1XOgmzIUJj
         s+XHjauIwGmH26c8SJMdNBR3SlcRumgAD1VDxubB8o5hUSP1P2z93s822PbPNG9nxN4O
         GUH5Dii+PeFK1eZ5UEaGTovZCg9HfPxR9m2UUSNPAJRZc+XB5ukU+NNWFUcg/4Ez53xJ
         b1HlWdwCKbqxHea0heUyPOGj6vMWBmOtCjm64Mo3u1h6AuhRmdKPrBWKUoJZkEU8HVbW
         pU118l9cLMKefAC5abpKvHP+8yJ3kzvq6Mnmt7A9pwKpnctdNqZl6dNoQ9ovsLS85Uyz
         +1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Rj8VN1b6mLab5Tsqa9mEO+dloUSa51la35sMfPA3S4g=;
        b=G34CNq07LLySer5IABjAc/hvqOE4ozKuMGhw9rU3IitopG86PW2rTv/bHq/CzCnx20
         3c0L5iKLyCmcJcrDAYhh9nwMidj02ml3CWcd48ffrAEReXoLlBbBBiTotR52CUw9WgCh
         LForC0YkRkbF+cNkoAI11lFvWmjRowySrALUgbq/yCsBCqquPiNW5416WTIDYcvO/X0X
         vkXYoezmU7fv5tN6E2wX4O6Rcim2uWbb1vq4Tc1DcxYn0Fr/Yp0ewmGMH8W0kRTbg4aL
         SPzXnjCS47d2Fzgm+RryHqRBCt3iNyb8dkO+3mf21lX8rIy983LYOsBa2EzZN2w+0Ns1
         KBUA==
X-Gm-Message-State: AOAM532McCxj8bKHoKaPYa4DFNXx12lzq9yG77+45QxEe3iBWCEX96Nz
        C48M4BO0I45Zq2/Pgk3M3qg0Qs5tZxLIxw==
X-Google-Smtp-Source: ABdhPJwjSGehZ+3KhKNtvWP6FNMzzHMDJu4CPLhFx8/4+tYy6rqnBmVFXDINflGWHeYHKOCW7acQng==
X-Received: by 2002:a05:622a:11c7:b0:2e1:b594:cb1d with SMTP id n7-20020a05622a11c700b002e1b594cb1dmr18411184qtk.59.1651655231714;
        Wed, 04 May 2022 02:07:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.206.63])
        by smtp.gmail.com with ESMTPSA id a4-20020ac87204000000b002f39b99f6a8sm7095381qtp.66.2022.05.04.02.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 02:07:11 -0700 (PDT)
Message-ID: <6272423f.1c69fb81.3f4a7.2fc2@mx.google.com>
Date:   Wed, 04 May 2022 02:07:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5000043937568106665=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, juergh@protonmail.com
Subject: RE: [RESEND] Bluetooth: ath3k: Add MODULE_FIRMWARE for patch and config files
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220504074606.15505-1-juergh@protonmail.com>
References: <20220504074606.15505-1-juergh@protonmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5000043937568106665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=638185

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      31.35 seconds
BuildKernel32                 PASS      28.74 seconds
Incremental Build with patchesPASS      37.82 seconds
TestRunner: Setup             PASS      470.22 seconds
TestRunner: l2cap-tester      PASS      17.44 seconds
TestRunner: bnep-tester       PASS      6.06 seconds
TestRunner: mgmt-tester       PASS      102.29 seconds
TestRunner: rfcomm-tester     PASS      9.83 seconds
TestRunner: sco-tester        PASS      9.55 seconds
TestRunner: smp-tester        PASS      9.51 seconds
TestRunner: userchan-tester   PASS      6.37 seconds



---
Regards,
Linux Bluetooth


--===============5000043937568106665==--
