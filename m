Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BBC4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 06:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FD0611C5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 06:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbhHFGnC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbhHFGnB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 02:43:01 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9672C061798
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 23:42:45 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id l24so5764968qtj.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aC2eKfg1MqYZgwVIlKZg+8UQETUQ5S/WL8PDkSyoXEg=;
        b=XpTNw4Y4WnqBoKGILZpxc9duftPl64Jd+oGD/DSSN1j+3KnCKQMGkk4qL1U5dZ0IYH
         PyZPftGNfrl5W5lCIKuQj0DUq1buYufbWIZRGde1ICXVMknW8w01NROm4aB/wrDZND7Z
         tQK49fc8BVC9aFLFTGx6zfI3TZnKNV56dvXBH+3dMoTcKWxL2XCCLVW2544lQ0IH6pYe
         dWEqphpT5iSBl53JPyhYC8J0Nhgfn3/jH+RVupRTJOyQTWmkBIYF/fDvH8rvR8wxdT43
         r8oKYW3uI4kDpztF7Bcm197/xiiDJVFHbPWkAKAzpfwK89ubWmsIiWDPBvB/GtxuJYA8
         Or7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aC2eKfg1MqYZgwVIlKZg+8UQETUQ5S/WL8PDkSyoXEg=;
        b=EDrj3DyClzUqV38+o1ZaS5U+hMXR/HLQvVj+HXFtlF6WA+nBSyE54ZDOP+gbUllC8h
         bWetEhn5wGnpTdNixb3x23UvijFZG9Y39FB9cMimh2EOOT86DtVe4bfhpwNl2d+lotyW
         pH9VnDXTkfDBvAibdA9yghSLSNFV4RXV19yp8gCcLaHo1MKvXxbYiiXYPv9jzP14XTYd
         LEs3ttbaexwN8HD+J3Euex80yVA+s6edBbA1MaAW4nSCp2l25pHwDMrf+An/horoFayY
         qEbZBNFwlSkWmFWYYx9/+JP907BxIzqirozFZKjsekTuGQ9bsnjtdyqYNuinxD+Rky9C
         wLnw==
X-Gm-Message-State: AOAM530z+TGv6shujCxo3/IGCgRD+Bu9G35LSOKRgGd7mUhBzg5ost0h
        xeq7HdXnsvpn+4Dl0c1cMMF9OjJvuOw=
X-Google-Smtp-Source: ABdhPJwbpi6O/sAMLpgwYmv1zl4erlRevXqiXdwuz+U4YixeUZ9RxlPEeTQT9Xu8VQFElBavZ4JMMQ==
X-Received: by 2002:ac8:44a8:: with SMTP id a8mr7636065qto.238.1628232164716;
        Thu, 05 Aug 2021 23:42:44 -0700 (PDT)
Received: from [172.17.0.2] ([104.46.195.171])
        by smtp.gmail.com with ESMTPSA id s20sm3072990qtw.52.2021.08.05.23.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 23:42:44 -0700 (PDT)
Message-ID: <610cd9e4.1c69fb81.64c2b.4578@mx.google.com>
Date:   Thu, 05 Aug 2021 23:42:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4762798154711210464=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] doc: Add a doc for Intel hardware variants
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210806054941.31387-1-hj.tedd.an@gmail.com>
References: <20210806054941.31387-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4762798154711210464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=527341

---Test result---

Test Summary:
CheckPatch                    PASS      0.25 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      40.26 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.06 seconds
Build - Make                  PASS      175.33 seconds
Make Check                    PASS      8.96 seconds
Make Distcheck                PASS      205.74 seconds
Build w/ext ELL - Configure   PASS      7.08 seconds
Build w/ext ELL - Make        PASS      164.77 seconds

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


--===============4762798154711210464==--
