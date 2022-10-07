Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928A3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 15:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJGPoP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJGPoK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 11:44:10 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB87D73DB
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 08:44:10 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-132e9bc5ff4so5968214fac.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QIVENqWX79ePfagmvrr2R6k1nwcKVV9Nu4JOnbn3t1c=;
        b=O7kaeDCwBhU3AjIVz3hw/G/kNe6yNMVE3bi55JdKVj7hhAG0vzhP3B8r8U8eYlkGca
         sBfN+XmrDK87HlB4Qm1XbvliZRCf8Z6Bu1HH65h+DQ88LAVRRebTSQyWNjqpvZElfsPp
         E+JC/jDmUgJq+LyjabG7aGqy+BD1jxwM1R4H2CFmjRl3QUXfGiCftmQSznM73Rj1sTeM
         boC3kOhjg1lE+ok85Ts18P3NW+EXK21JycPKbc3mMkODOI9cWvNMDjknToqRza5zp9Hb
         F++yhLa76MB4WBlxYB84jE898paUi/MoZDM23WK6phw1tP5Fizq9i1y4+pSxIkVG1h5V
         Z+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIVENqWX79ePfagmvrr2R6k1nwcKVV9Nu4JOnbn3t1c=;
        b=4BjsnloQntSiVwd0s+r8pF32DVbd/4wIUBVTQ6d6gSyQ52iI4LJjiKo41wTphdPsNQ
         14zSeM16oWTULQJfLccnuw6eDFYSmEUyA6Rp8/1T8QgVCo8QSuWUf8RpFo2ZS/6G+GNu
         qHKP09J32UprfHKN57r9uEVUYlzp7hANyvdxPxauCGC5IFZUZKA18dFGw/bQjP0k8958
         s4bKV34c49AJW8wpnBhVHF0+B1HBxt2E4imtg5QSBF/SMs87n7Fq48Z3eZCnsYu1UR4O
         7Q+ymvS5pxjnDt/+U8pRkLdkcCuX5sAGE73fgAPkJIW3MNAwP22FsRfNZQhCchMPeQQt
         MUAg==
X-Gm-Message-State: ACrzQf2IkiDlkvTc2LldQKpzp4VwFVVnu/rWQgSdgCamzoU8ntv2miJ9
        4FGHcjOlSCugys69q4FgjpeYeoyrIos6Qw==
X-Google-Smtp-Source: AMsMyM6ozYYZqd5aw8hwdrxyuXNAXABXu37aI9rxYu9LfvjWSAl1Ue3ve6MptBk26vnlSjslZEuhsA==
X-Received: by 2002:a05:6870:1496:b0:132:2020:9c8d with SMTP id k22-20020a056870149600b0013220209c8dmr3030896oab.78.1665157449369;
        Fri, 07 Oct 2022 08:44:09 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.130.140])
        by smtp.gmail.com with ESMTPSA id h6-20020a9d6406000000b0065c2c46077dsm1303385otl.67.2022.10.07.08.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 08:44:09 -0700 (PDT)
Message-ID: <63404949.9d0a0220.c2cf9.4e47@mx.google.com>
Date:   Fri, 07 Oct 2022 08:44:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5907419445961180154=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: Bug Fix for Memory overwrite
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221007145920.20966-2-abhay.maheshbhai.maheta@intel.com>
References: <20221007145920.20966-2-abhay.maheshbhai.maheta@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5907419445961180154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683730

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       FAIL      0.80 seconds
Prep - Setup ELL              PASS      31.61 seconds
Build - Prep                  PASS      0.92 seconds
Build - Configure             PASS      10.17 seconds
Build - Make                  PASS      1137.58 seconds
Make Check                    PASS      12.56 seconds
Make Check w/Valgrind         PASS      342.61 seconds
Make Distcheck                PASS      281.81 seconds
Build w/ext ELL - Configure   PASS      10.11 seconds
Build w/ext ELL - Make        PASS      103.11 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      675.30 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,1/1] shared/bap: Fix handling memory overwrite during ASE Enable Operation
1: T1 Title exceeds max length (81>80): "[BlueZ,1/1] shared/bap: Fix handling memory overwrite during ASE Enable Operation"




---
Regards,
Linux Bluetooth


--===============5907419445961180154==--
