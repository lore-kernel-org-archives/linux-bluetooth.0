Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D3C4743C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 01:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE3E60C41
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 01:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFVB3T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 21:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVB3S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 21:29:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19436C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 18:27:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l11so6803321pji.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 18:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vPLIT1wdQJFbCIihXmdVXaCG+UDLiYxa22WLnaZgvzQ=;
        b=hUNQoTDh5AlEgjuqZpmU8mi/ubkgckgaNOJsIQFGJ2vV4sxJoKgzf9pmdZQVTWurO1
         /8zrEAHj7TYcEPseUNcY5Xx1ZHE8qta0vNwWt780KvbMS7GGeQZa416Kf4Rvvm6GtKDS
         Rl3Hd+Ft4v4PnxP0OoB7wtRW1nlgxY0STCsYdDlYki+OaUS+ysWths9WQJswFx+xf+bf
         yogcGKLkkLy12sZg5cVzPdE2jw6hFUZGFcV1Hi25DnSW6NChi/tT9JOtozpKEDvUoJ1D
         FgRwCxhNS0Cz6EaOHNmSs+pqFtLjlitaNK9fCt72PUN5t7oIz/PEf3JEo8qmS6+pJxPx
         VPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vPLIT1wdQJFbCIihXmdVXaCG+UDLiYxa22WLnaZgvzQ=;
        b=Fiqg6alvhSibATrOhmqZE3z3P+CzeorDCkMEahUpzg++SIK3ZplgI2QlZSCyLqMAKN
         IepSlqGDL/OOY6yYcsS+gz7NLELtSoYf9YQKzdRFmZUJyfUseUoygwGPMEGjICLo6DKf
         qElm0GWzz7HcS1s8rLwwoFJio9b3/AUW7TcRlNbsJhO7P/movbbN4UzSO3gEovVjXBAH
         xsJ92Rkn4XVBMCIOelxnx7LxU0yam9LR3OMW56HcGeK90RL4JsgZ22oCqw/gf8wjndMf
         AXbbABbBkuiHal4Y/ClQhYe4N5IkE5FMS2bAn50gbuEKATOxVUlXji60XdUqrYmVmqp2
         Ahsw==
X-Gm-Message-State: AOAM5324wrrIh3raY0SeXsHwzoUu5VnTGWcEg4h7rAEcwJh3EqYv6X66
        a1ioT11B57EWvAFthv4Z5YiSawQnbzU=
X-Google-Smtp-Source: ABdhPJzW/j2aCW8m3mIQe2ZmWB3R83lqna69VaoRVF2Gn3v3LPO/Dk7g21c9pTfXrGJ4YcpuIB3dQQ==
X-Received: by 2002:a17:902:bd42:b029:123:1986:d0c3 with SMTP id b2-20020a170902bd42b02901231986d0c3mr13061733plx.74.1624325223390;
        Mon, 21 Jun 2021 18:27:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.11.12])
        by smtp.gmail.com with ESMTPSA id u11sm373456pjf.46.2021.06.21.18.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 18:27:02 -0700 (PDT)
Message-ID: <60d13c66.1c69fb81.85375.2184@mx.google.com>
Date:   Mon, 21 Jun 2021 18:27:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4310451934923041217=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/5] tools/mgmt-tester: Enable High-Speed(HS) test cases
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210622010131.427059-1-hj.tedd.an@gmail.com>
References: <20210622010131.427059-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4310451934923041217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=504695

---Test result---

Test Summary:
CheckPatch                    PASS      1.82 seconds
GitLint                       PASS      0.69 seconds
Prep - Setup ELL              PASS      52.95 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      9.29 seconds
Build - Make                  PASS      216.88 seconds
Make Check                    PASS      8.81 seconds
Make Distcheck                PASS      257.00 seconds
Build w/ext ELL - Configure   PASS      8.88 seconds
Build w/ext ELL - Make        PASS      210.90 seconds

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


--===============4310451934923041217==--
