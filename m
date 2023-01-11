Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D239BC46467
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 03:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjAKD5P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 22:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjAKD5M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 22:57:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622A412607
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 19:57:11 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so18681512pjq.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 19:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LcZSLC7JGJlEZEPYg4w/lNpLMsNaGMLBFM+Ri7+NPV4=;
        b=OPKjT1/o7Wlt/z0MzyeU0vM8JXgO+TelzPZsuSvldK0TfbQspSsUxTKnG++ztQmnLJ
         7BhKChC5s2muniBXykLY0sZa5rXBgjXgnorSOuCm22YEq9QHLHdEMP1v6nkMyXr3KChr
         oF1089OTrFuTQBFeU/U7kMd3GlKkO4UbTUoktgPYlext1kSKqI26ctxAnWfW5yOUCJi1
         4C2+vDvmWwXuAr4ray13bu6ZCUSt2bdVfC7koYKjvm9VhYDIvjTqTi/dAvD+ScWwAGp4
         9iBPv7SlN8wVJommNqdPLXGyfg2zDPNgpgzopr0eijKptM5bYitTELNkCheold6n8pQ/
         RB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcZSLC7JGJlEZEPYg4w/lNpLMsNaGMLBFM+Ri7+NPV4=;
        b=YHnXrfLTRl+knJb9X0B6jOySxTpwR/4Bjzz4oMn36vBbybM3fGKkuJpDQUP6jlkMJn
         XjYOsIsv9+0P6bHZRHje/L1xQE8RnZQkaMZKEILWXMuftllRIiTL8Kp8ngvV0+LOMzn/
         DlOOWcLmeCi/8IZ+uPpO4Ni9HBJQwoH3mDhggRq1zXpskCNM8eq43Aqb6VX0+0xerv03
         JW0HgauDyYJUiOIy58QSeI+v2rtuMQyphj7goDC/QmdnF1j+dCsvZXyN4bxKYNlfeYZl
         XUJQ+er5az6sP4azDLi0MtKRaoUYegl6cBKckh6Jt6oreyuhw+JWG198j7fAJ7oVjIfv
         tOBQ==
X-Gm-Message-State: AFqh2kpLm21ofItv7CgAM7eZyODqV+780636oAJQZfKOupijzacPZXJP
        GviGI4HN8voFzt61cEpn+vwwEWIYY2Q=
X-Google-Smtp-Source: AMrXdXulpZ8X/q5eiIOIkbf0voqYGKLmPxCtPTV3LuC+gY8gqrL5wHzbaM49GAM0WflQbZGxClGUqA==
X-Received: by 2002:a17:902:8b88:b0:192:b2d3:4fc8 with SMTP id ay8-20020a1709028b8800b00192b2d34fc8mr1251759plb.1.1673409430698;
        Tue, 10 Jan 2023 19:57:10 -0800 (PST)
Received: from [172.17.0.2] ([4.155.128.241])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709027e4e00b0019254c19697sm8727840pln.289.2023.01.10.19.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 19:57:10 -0800 (PST)
Message-ID: <63be3396.170a0220.797a1.de6d@mx.google.com>
Date:   Tue, 10 Jan 2023 19:57:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0789774935951098465=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v3] Bluetooth: Fix possible deadlock in rfcomm_sk_state_change
In-Reply-To: <20230111031540.v3.1.I1f29bb547a03e9adfe2e6754212f9d14a2e39c4b@changeid>
References: <20230111031540.v3.1.I1f29bb547a03e9adfe2e6754212f9d14a2e39c4b@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0789774935951098465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=710770

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      30.88 seconds
CheckAllWarning               PASS      33.71 seconds
CheckSparse                   PASS      38.46 seconds
CheckSmatch                   PASS      106.19 seconds
BuildKernel32                 PASS      29.67 seconds
TestRunnerSetup               PASS      427.02 seconds
TestRunner_l2cap-tester       PASS      15.97 seconds
TestRunner_iso-tester         PASS      16.16 seconds
TestRunner_bnep-tester        PASS      5.52 seconds
TestRunner_mgmt-tester        PASS      105.33 seconds
TestRunner_rfcomm-tester      PASS      8.60 seconds
TestRunner_sco-tester         PASS      7.89 seconds
TestRunner_ioctl-tester       PASS      9.18 seconds
TestRunner_mesh-tester        PASS      6.85 seconds
TestRunner_smp-tester         PASS      7.81 seconds
TestRunner_userchan-tester    PASS      5.69 seconds
IncrementalBuild              PASS      27.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: Fix possible deadlock in rfcomm_sk_state_change

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B3 Line contains hard tab characters (\t): "	  lock_sock(sk)"


---
Regards,
Linux Bluetooth


--===============0789774935951098465==--
