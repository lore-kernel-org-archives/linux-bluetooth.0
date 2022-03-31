Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8232C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 19:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiCaTNs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiCaTNr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 15:13:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE8A239324
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 12:11:59 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id gh15so325182qvb.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=UrSqkr8ohBqyVjqi2drb/3/IvGmwyI4U5rZQwFjhKLc=;
        b=EYZCxjKkfx9luuC3th0Ey+W33vxH6pWjkc98lKshAamInFRsSugsOAtKDJuiVJha5O
         maYDSVUc4GExb5AkI5CfnFObTS7GT8/jqmpm+ihAVSjQKUNg+Y5sCGHeWT7TsgWFTx2B
         020AMaMbOqpxadcYHe2IQVLT9V50j3RE3hxEnepeO/B9XH50NijrDCOa7D6jjT+yd5be
         bsE72SqbJDdet+VF4YGXUdwqC9JJ5DzFrG3h1NkuVN0h8wYJelUwcrFy4bbJZxr1LdXW
         aT69JJ9XFhBC4Zkx+38S1hTFSpw5WJMwGTp12xBoVtDhTvUZyBR+3GnFgSW3jc4RI5dN
         Hj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=UrSqkr8ohBqyVjqi2drb/3/IvGmwyI4U5rZQwFjhKLc=;
        b=OyeXhOIN98kB75zsYHnPeXWb0sf3CZF2QWzqLCliKMVHOenkq/1E7JPsW71toO3I9e
         k9Z6THhzeADIfUimnFX9TsJ4/jff7XweGni+kB/bXd4i88VDMdYd1tT9+BSJ22mpXURa
         TcELLzwG40ZtUlRUDu+iJS7ddF96tP1DzJcM7+lckfHxrsNGlww0SlpKdNti3CUhbwvY
         +Zh2zrSyRCgDg1ylOOhw6PWWruoxTTIJVzPc87Dw/8sf0Z5KFpPnDeWX9NlrNRY3Wu7F
         RhPWDdqaq4Log/bbGRJfD605RyWKxwcprwqqT9fdTIks/a3+p3aQasydlm4VZ3FNKzcI
         t+TA==
X-Gm-Message-State: AOAM530hboQza/2aIw99eGrdRAYh2EyESpN91BYQ6ux4i3aUlCi7BYpb
        eWGLSdzErArQim8ryuHQdyGAqOaXuYE=
X-Google-Smtp-Source: ABdhPJzwT7l8n+hzlwLQEK04B7A+LWvGr79rlHu+c4qiWk7Lwn2Jj+kWFUOiJccQaCEE366II8pKCQ==
X-Received: by 2002:a05:6214:27e4:b0:441:626e:1f06 with SMTP id jt4-20020a05621427e400b00441626e1f06mr37584846qvb.2.1648753918136;
        Thu, 31 Mar 2022 12:11:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.114.223])
        by smtp.gmail.com with ESMTPSA id j21-20020ac85f95000000b002e1cde99863sm118246qta.83.2022.03.31.12.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:11:57 -0700 (PDT)
Message-ID: <6245fcfd.1c69fb81.79d0.0fbe@mx.google.com>
Date:   Thu, 31 Mar 2022 12:11:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3734405149605373589=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, trix@redhat.com
Subject: RE: Bluetooth: btintel: fix btintel_download_firmware stub signature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220331174959.3421978-1-trix@redhat.com>
References: <20220331174959.3421978-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3734405149605373589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627929

---Test result---

Test Summary:
CheckPatch                    PASS      1.67 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      37.40 seconds
BuildKernel32                 PASS      33.34 seconds
Incremental Build with patchesPASS      44.96 seconds
TestRunner: Setup             PASS      553.75 seconds
TestRunner: l2cap-tester      PASS      17.89 seconds
TestRunner: bnep-tester       PASS      7.27 seconds
TestRunner: mgmt-tester       PASS      116.35 seconds
TestRunner: rfcomm-tester     PASS      9.48 seconds
TestRunner: sco-tester        PASS      9.23 seconds
TestRunner: smp-tester        PASS      8.94 seconds
TestRunner: userchan-tester   PASS      7.59 seconds



---
Regards,
Linux Bluetooth


--===============3734405149605373589==--
