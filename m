Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAC2C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Mar 2021 06:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA8461A10
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Mar 2021 06:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYGpt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Mar 2021 02:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYGp2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Mar 2021 02:45:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FCCC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Mar 2021 23:45:28 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q26so800048qkm.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Mar 2021 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1I1Rstsrh2Hc4WyxwAPlOT0i/tydnljZWEtLdCSqXpc=;
        b=adfHUr8YupG0c4ZjMJGGEgepPa7IYHxHYffXAz4DxYNpwjmZkXq3+4Wxx3Zc4Q1RG2
         R6AaJVwz1gKEE5r0FjaOtvYK9L95DziRQC9QrZmbnYXXBqJjDMoAxYqoWc2dJHNmHfwK
         g29R43hl9+VPxoNdQBl4mwFY/gnf3mk3nT3c9vclAvV5tbgJwA2Ipb0nzVqZAK3aviyE
         IBSvKp8t2qfAjxDHvbxuyGm1URLiHBy7RexJT9o6DGxeHUQ88GjPPw8BLRo4V2VChA7w
         Z0nX7OycWpLZGyCkAQIZrt0L8vfp6o45GECQKeV2OAAfshoHkT8cE3/5emEwXvwvrQw1
         /n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1I1Rstsrh2Hc4WyxwAPlOT0i/tydnljZWEtLdCSqXpc=;
        b=gLoM+f6KA1IZANeDP8bSZKqtvmRuJqH4sMEUCWyBOTWadAa6LUeK6LQc8u2oxxshEI
         MDBbiLaCafrV0qg5y/9PMb1BY5+38rsBEWRD8JKiepCH7geq44u+vLOZx+CL4F9V8Hgx
         ATqZ9sVex/ZDnBEDTpN2ifiphH3CX0RYjsPhDYsYO9MRBzmKwhB31uS7uLUVkUUga78l
         m2qAuHpkAlTFSF9teamrUPhWzcfViNaoFDuatrr/9bY+6eHePlUF0Q/uhxZ5qvTywhss
         FsJKwYvma0BxyozWmXuLPYl4NOZ02YVcYuxgdAqkN9jqoumqRqHE9FgQJzQ1GDXtLBRb
         fwug==
X-Gm-Message-State: AOAM532HDAVFDnQGX6cf/gsw9zpAG/Tjx3sz+7GoUWVF+anDzHTJTHeu
        /TPn0ESMtvQKVi2pA7/paXM2tmh2VGDpHg==
X-Google-Smtp-Source: ABdhPJxbRDXZZcmR+8Sfc/FPk58W7GOFsinGQnNa1krqxGiRciHtBfQP+Iq/tfZcqLUqIHrKCPsLbQ==
X-Received: by 2002:a05:620a:1206:: with SMTP id u6mr6426948qkj.173.1616654727225;
        Wed, 24 Mar 2021 23:45:27 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.142.25])
        by smtp.gmail.com with ESMTPSA id o197sm3445490qka.26.2021.03.24.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 23:45:26 -0700 (PDT)
Message-ID: <605c3186.1c69fb81.142f5.5521@mx.google.com>
Date:   Wed, 24 Mar 2021 23:45:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1715257847948074471=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Framework for non-interactive mesh test
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210319203825.459070-2-inga.stotland@intel.com>
References: <20210319203825.459070-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1715257847948074471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=451875

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - FAIL
Output:
/usr/bin/ld: tools/mesh-cfgtest.o: in function `join_complete':
/github/workspace/src2/tools/mesh-cfgtest.c:703: undefined reference to `l_tester_get_stage'
/usr/bin/ld: tools/mesh-cfgtest.o: in function `dev_msg_recv_call':
/github/workspace/src2/tools/mesh-cfgtest.c:967: undefined reference to `l_tester_get_stage'
/usr/bin/ld: tools/mesh-cfgtest.o: in function `attach_node_reply':
/github/workspace/src2/tools/mesh-cfgtest.c:630: undefined reference to `l_tester_get_stage'
/usr/bin/ld: tools/mesh-cfgtest.o: in function `import_subnet_reply':
/github/workspace/src2/tools/mesh-cfgtest.c:579: undefined reference to `l_tester_get_stage'
/usr/bin/ld: tools/mesh-cfgtest.o: in function `create_appkey_reply':
/github/workspace/src2/tools/mesh-cfgtest.c:480: undefined reference to `l_tester_get_stage'
/usr/bin/ld: tools/mesh-cfgtest.o:/github/workspace/src2/tools/mesh-cfgtest.c:356: more undefined references to `l_tester_get_stage' follow
/usr/bin/ld: tools/mesh-cfgtest.o: in function `main':
/github/workspace/src2/tools/mesh-cfgtest.c:1411: undefined reference to `l_tester_add_full'
/usr/bin/ld: /github/workspace/src2/tools/mesh-cfgtest.c:1415: undefined reference to `l_tester_add_full'
/usr/bin/ld: /github/workspace/src2/tools/mesh-cfgtest.c:1419: undefined reference to `l_tester_add_full'
/usr/bin/ld: /github/workspace/src2/tools/mesh-cfgtest.c:1423: undefined reference to `l_tester_add_full'
/usr/bin/ld: /github/workspace/src2/tools/mesh-cfgtest.c:1427: undefined reference to `l_tester_add_full'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:5884: tools/mesh-cfgtest] Error 1
make: *** [Makefile:4058: all] Error 2




---
Regards,
Linux Bluetooth


--===============1715257847948074471==--
