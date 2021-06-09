Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBDBC47095
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 04:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A78260240
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 04:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFIEJF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:09:05 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]:38622 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFIEJD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 00:09:03 -0400
Received: by mail-qv1-f42.google.com with SMTP id t6so6260662qvp.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jun 2021 21:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=B+0sgDreYoGM0eroihsHtyFrSeOyYiG804/oyu8XvmY=;
        b=DdeueMLCZrD+lZ4pkhatGWC9fC074JbZiorxwNcHqXL5Zm5jMhaHnBhaRtPWdLtO6X
         ZB9Ydidy2+aRVVUUTHx+CqXxIGuefrNsq7pgj+zNqLsj0+dMrFb88d8QEHet3Wl74stc
         gatPdNOYUW83pT79Z8aumEoNOv4G52dSEbIIpXM/vxbYEwUdHy8H3tnwhWhXup46IPNP
         LUe8wcOT5xEtVdzO9a0QUWR9rAqhPDh7ytxd0Vy57wXMKdUtEBr9vBCeoFo9ZdnuKlRa
         RtRq0CVddqfK0HRi8kiVwuP9bsu9umuNMZxpB6tiHu2uLDqZL60qR96WoA6E4PqmFjgt
         6F5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=B+0sgDreYoGM0eroihsHtyFrSeOyYiG804/oyu8XvmY=;
        b=HFviFUri45qA6JBz+/u7WGH4qQ+vR4oL7ExIZzwDAicIXdhF0FCJKO/pDSYQLywV0h
         WV/8igdVPbVWgGHaAtp+h7QvU0KgTV1e1tffy9ptHTXbMyhnbeyVjf9bHVO2F8Ykc6xi
         v0mZJazGSXgrmK11Kn5WdYDpCEj71ulTHR8Vf+MxvNSEKM+IQTxcXrNSoKcVWj6QL3X8
         lrtIWbwtW9YVHa4ojcpn6lZjGyxaLMqRVsMtWLnQRkqxSz2j9sAQgswv6Pur7zg0txWG
         KVQUMwDXJTYSBligFTdElSvBWUZKgWGNqykm/D4N1l8hRW6HrZY+8bsaoEsTq7eQiNcd
         gakA==
X-Gm-Message-State: AOAM530CtGVbGEEnK4BIDjaMjbA1Kp/+9iVk5zYX+SYeJckKXgvNE9kj
        qJzV6yCJef9LkWjUVXZjCa7Po37HeT2H9A==
X-Google-Smtp-Source: ABdhPJyKNJXIBU0FAyHb4jAO0RdOceK0SfA2uDH95N3o5bQD1E2MAYuBzvDviGiEgZ6rDfWSTTOthw==
X-Received: by 2002:a0c:ba0c:: with SMTP id w12mr3556308qvf.41.1623211539146;
        Tue, 08 Jun 2021 21:05:39 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.113.248])
        by smtp.gmail.com with ESMTPSA id x28sm12481813qtm.71.2021.06.08.21.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:05:38 -0700 (PDT)
Message-ID: <60c03e12.1c69fb81.54894.51f3@mx.google.com>
Date:   Tue, 08 Jun 2021 21:05:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5960186605624350915=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Convert tester tools to use ELL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210606063719.339794-2-inga.stotland@intel.com>
References: <20210606063719.339794-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5960186605624350915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=494845

---Test result---

Test Summary:
CheckPatch                    FAIL      5.15 seconds
GitLint                       PASS      1.19 seconds
Prep - Setup ELL              PASS      43.38 seconds
Build - Prep                  PASS      0.12 seconds
Build - Configure             PASS      7.34 seconds
Build - Make                  PASS      177.48 seconds
Make Check                    PASS      8.32 seconds
Make Distcheck                PASS      207.15 seconds
Build w/ext ELL - Configure   PASS      7.31 seconds
Build w/ext ELL - Make        PASS      165.37 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
shared/bttester: tester framework wrapper to use ELL
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#330: FILE: src/shared/bttester.h:16:
+#define __packed __attribute__((packed))

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
#340: FILE: src/shared/bttester.h:26:
+				__attribute__((format(printf, 1, 2)));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
#342: FILE: src/shared/bttester.h:28:
+				__attribute__((format(printf, 1, 2)));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
#344: FILE: src/shared/bttester.h:30:
+				__attribute__((format(printf, 1, 2)));

- total: 0 errors, 4 warnings, 321 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] shared/bttester: tester framework wrapper to use ELL" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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


--===============5960186605624350915==--
