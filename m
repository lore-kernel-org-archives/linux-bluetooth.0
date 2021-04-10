Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE69C433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Apr 2021 07:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D30F610C8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Apr 2021 07:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhDJHJi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Apr 2021 03:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJHJh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Apr 2021 03:09:37 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F9EC061762
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Apr 2021 00:09:23 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 7so8220552qka.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Apr 2021 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hmAqfgVe8/M8lxyK9D1b3YjYSUi36ugwEo/TDnLgYtE=;
        b=SvqdAbnspagd4w1ZEfaAgkXjY77vnWcueKRzukaywqsaPAF5o1COfDbdAl3ygpA2GM
         qnmUZQrrzfyzZs5fpaldEwGTyAedBk8Iz7YFpm/qF0zfya9R21Tv9Berwq/9L1NrRFKi
         +Lk0StgPnXq+c5JM2WsXPntWdHHxCaPlyLoSQ+6vyOTKcgZ8PpPnMzYHMCcTQdfF1ji7
         g/utQ3NAmsOikUsFcg9ymSB7SDqWGtPZlWPuYHpo+kdDudOaTNWMH9r+OuRhuNcyxcQg
         hPBh6Iu8MP/GDbP89ErhPxXyxOVsaWdrcKTjTs+tgrtLL9WTBYtZOIC2bO+E08kPMq0H
         NUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hmAqfgVe8/M8lxyK9D1b3YjYSUi36ugwEo/TDnLgYtE=;
        b=tn7XOJh1pXl5sKxsF+swZ2Thve55kZ4LgU18ZEUvSehppGqpcOBS3rX1hNU74YYHjR
         ebV2irog8bh1uV6ihxy3tCskX039Hj3BqC1d4EcrYau4tN5ppXJEKhYzVtJSGw3cgj0D
         WSBD/5Oei637Oz6loDc5mgCeOUmE1qCLWHbMRyLBo3dUuAxrh9QzjCwwibLYyWeNF3x6
         A9r9n05OsA+vClHE6biws1wT4ba2yFXARndh2RCwr3r0i3zeAhZGtb29KP+kQzbh+XX4
         7imduohTraGK8wvkkDxfinaFfXK60bGy2CADt6aG6nrcC18TXeGdWQmblbX++uSt+uJj
         amPA==
X-Gm-Message-State: AOAM530+PHB21zgON1RosJZZksknSWZ8s5foXMBKfq6JySIzVcDTDDEG
        UOQ0DOmPU4oR+qK5NnjgDltauJPulQo=
X-Google-Smtp-Source: ABdhPJwb2+Xu7TfRYvJk0TcCh56423+PQFk0nYCBEAlKpwzbbfuDV29g4peyHQ+kaaIq5CiaT3fcng==
X-Received: by 2002:a37:a30f:: with SMTP id m15mr17673786qke.433.1618038562668;
        Sat, 10 Apr 2021 00:09:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.211.234])
        by smtp.gmail.com with ESMTPSA id d24sm3465171qko.54.2021.04.10.00.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 00:09:22 -0700 (PDT)
Message-ID: <60714f22.1c69fb81.34b5a.77af@mx.google.com>
Date:   Sat, 10 Apr 2021 00:09:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7188681047961418359=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/2] tools/mgmt-tester: Add callback routine for validating the parameter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210410064605.287884-1-hj.tedd.an@gmail.com>
References: <20210410064605.287884-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7188681047961418359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=464847

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.23 seconds
Prep - Setup ELL              PASS      48.52 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.49 seconds
Build - Make                  PASS      204.22 seconds
Make Check                    PASS      9.82 seconds
Make Dist                     PASS      13.24 seconds
Make Dist - Configure         PASS      5.31 seconds
Make Dist - Make              PASS      85.07 seconds
Build w/ext ELL - Configure   PASS      8.76 seconds
Build w/ext ELL - Make        PASS      197.17 seconds

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
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============7188681047961418359==--
