Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235EFC07E99
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Jul 2021 01:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12176128A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Jul 2021 01:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhGJBYR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 21:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGJBYR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 21:24:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC799C0613DD
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jul 2021 18:21:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p36so608632pfw.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jul 2021 18:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=PQjCTSTmi7DGP1fJgEtXbmc5F1oK8We6ZgtbLIwaFSQ=;
        b=M7ARXOJExG90Y2kFXhpMyhvGQ0iUYFhN0gA+jF4NCtFgLjnkptWJdngH34mgmomOpj
         xj/ZVLjyTzerW93rMabM8J083o7CL39uFcmUE7BQj9RwAmhXsfAGCp3NrOZGTqWcG7aZ
         p/kmrbn13fZ0iI4NzsMgZ95claPcudN49sw+fUl3vBXRetAfOYufwzKi33zAc+z55fWE
         vNVmpgCH1QIvzwzwq1MDvQoaEZh26ndfrFF9MM8BUQSb0Z+Eq/jut+EGgfBY0QTugjNx
         97BjSFjeQbJjMMwcGeyn5SQn1lIjACcMyS8Nx7yb0mBMVpXS2XrZtKWgMOQ7mzbnWlTO
         0TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=PQjCTSTmi7DGP1fJgEtXbmc5F1oK8We6ZgtbLIwaFSQ=;
        b=oc4yE1qt+DJezO55GHJl0KFzJiZOlUTdqJnvgGVXs5N2i1TU+scDSCCxbrQKVAxsxU
         4mBUHM4XFj4SJj8zTzD681gKq4d0Z30Hadv17hTD5qL+lsagXWgbk7wIOY7QLjkkVEqD
         DkBOGU121jQoR+L7qVzPdttB/eDo2gywwzeDvofTnqg+S2zLHo7xQcL0u5l/v3atBZtD
         mW5PsY52PXnt7fCvKEpuupEN8P4sSWTiWwWzZ2N0Y9yjEnJkrmxvvklenBl4faKUkSgP
         GkpkYjonTNCmyhO9JNZIvwhgn8XB/ox1/6IhYCC50B2kTAKLeRllwPlSXlDBuWWjQbbe
         NZiA==
X-Gm-Message-State: AOAM533VNePMBYBlq5sTUVmoRsettnM72nh5aQI3Fe9mHMn+CUWh4W7P
        Sfzu1wEc1IDwWytBpSKX85NevLDZ949PxA==
X-Google-Smtp-Source: ABdhPJy/Ro9SW2FvFdUATvcXN7vJXUSpFiCxL/yKygJj/3NEDVRIJqwgXemLNYHcppm2BqiBL4rJKQ==
X-Received: by 2002:a62:bd15:0:b029:31c:a584:5f97 with SMTP id a21-20020a62bd150000b029031ca5845f97mr33956851pff.33.1625880092111;
        Fri, 09 Jul 2021 18:21:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.228.10])
        by smtp.gmail.com with ESMTPSA id g10sm13504193pji.10.2021.07.09.18.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 18:21:31 -0700 (PDT)
Message-ID: <60e8f61b.1c69fb81.30e64.a5e9@mx.google.com>
Date:   Fri, 09 Jul 2021 18:21:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2722998509727800615=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btdev: Add proper checks for own_addr_type for extended advertising
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210709234242.1646501-1-luiz.dentz@gmail.com>
References: <20210709234242.1646501-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2722998509727800615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=513329

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      39.78 seconds
Build - Prep                  PASS      0.12 seconds
Build - Configure             PASS      7.10 seconds
Build - Make                  PASS      173.15 seconds
Make Check                    PASS      8.93 seconds
Make Distcheck                PASS      204.79 seconds
Build w/ext ELL - Configure   PASS      6.93 seconds
Build w/ext ELL - Make        PASS      165.87 seconds

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


--===============2722998509727800615==--
