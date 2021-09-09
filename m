Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5EFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 23:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692F7610C9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 23:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbhIIXg4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhIIXgx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 19:36:53 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A5DC061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 16:35:43 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 4so164698qvp.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 16:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1EfMwXezdfssLRlU8tEOk5HGZkusbrb/SJ29FxilFdc=;
        b=Aw5ftRemdLJkMGoHWbEt4J6rSencHqp3QogJwmOPbBDT/baB9/FGEOAvCuZXOLF9h8
         MyrQjZQTL+UFHJ5E9nyOslcJIIxoZ99SGbUh4EHCXbTYN+pu96IpH6uJrmk09dNyr4Ki
         zj8TjntKgOOa/6Qy58vw/eC8X4ezCjBpRuFEQhwdKkDhupecbsAccEmLw/IlUpYcWeuu
         hHrA0xUWWvHoNBhvqN/3NcWh/bNSfswqff3ALATS1FGwf5DcK5mWIlyCuoMlohFJQT9k
         rlQt3xzYo9riJEuHvjiYucvDStp41YwP6lsLE58a9R8qyemKJx7lypVDr2xruFH7cxHn
         bf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1EfMwXezdfssLRlU8tEOk5HGZkusbrb/SJ29FxilFdc=;
        b=KVxOs1u0NAfnESKHno/dZqABz4h6ss7RFD+A5RAngFu13TwzpPgIxo3j5qA6lAyCsB
         2ymKz431K7NH6uV7WnrydUB179Y0lFL6GQ55tvq/DPwtGb8VYQ9DaHXvzHnjv9IBNvKy
         sUrfpvHvCFdgoALb8lC3rpFp8tytplQ7CLtGNLO8g24P9YQ1FFVQs7QdST0hlsWJwzcN
         oeK4B5QCM1Sfh3RoXsKOgQYeSozY3on+CyByYVVud9QnhMuDpZ6oEoPObBVLUAGNbEeF
         HNZCB6zZxblZrR0sJuqGlJnKiJwrvlwGExUyP6yvLwDwb3UF74Lolh7mwPSpCPi0+6Y2
         smIQ==
X-Gm-Message-State: AOAM531RlgU+dCinHZ648X/0vXQvgYq142fV0yDfB5VhMpoCKZTbAFIi
        HqwxHpivNo/2kLOQcpH8hb5pNfljgfgtnA==
X-Google-Smtp-Source: ABdhPJxy56qEgHsDYyV4FwZeTiBWOR/i9XFFakZmQCpnrFxwF59o/vv+qJIAKCrXp3e3chv2FQU7KQ==
X-Received: by 2002:a05:6214:1268:: with SMTP id r8mr5698781qvv.5.1631230542340;
        Thu, 09 Sep 2021 16:35:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.110.98])
        by smtp.gmail.com with ESMTPSA id d13sm2065372qtm.32.2021.09.09.16.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:35:42 -0700 (PDT)
Message-ID: <613a9a4e.1c69fb81.a6be7.e83b@mx.google.com>
Date:   Thu, 09 Sep 2021 16:35:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4226365241286774189=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,V2] tools/mgmt-tester: Add test cases for load_long_term_keys command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210909230923.165649-1-hj.tedd.an@gmail.com>
References: <20210909230923.165649-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4226365241286774189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=544673

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      44.50 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.75 seconds
Build - Make                  PASS      194.30 seconds
Make Check                    PASS      9.25 seconds
Make Distcheck                PASS      229.46 seconds
Build w/ext ELL - Configure   PASS      7.76 seconds
Build w/ext ELL - Make        PASS      178.84 seconds

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


--===============4226365241286774189==--
