Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E343C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 13:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C8464F04
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 13:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbhCDNKL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 08:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbhCDNKL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 08:10:11 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C0CC061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 05:09:30 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id 2so11202355qtw.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 05:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=h87GCathDQNmtPjMc6wSJepGMItAUTKlBX624UWwxGI=;
        b=EYfIDgNp4/XgEdhw8CiGLZT1FdU3jMz32kGdjWRQCdMXD1oXd7HS6eirqpWNDZtOu8
         4n+pxy90gu5W9V6uYhniSamhgIhP1kjq2zv6G0v2SbQTbTiUD7S1BlW8HIunWhFY33Yi
         1AoeDefk9ylIWQc7ICIZVVR9SkEE7KOusW0bcrtqbNvL3E0dHq/ZPl1F4AvJ4NZer5Mo
         JWPMfTZl7h8sw2u0yPwV3SGli/wpVvm4vOj+a/yEgxPl1E7NYFfez4hgv/0nJ20wBxx0
         T9h3slP9zrNJ7kA1byD1a+hAd5w2Gf6VtKmVVZqXdYPjdZ9hnOBH9gS6Cj39Dqb1Ji+Z
         yQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=h87GCathDQNmtPjMc6wSJepGMItAUTKlBX624UWwxGI=;
        b=JAIfb2QcZ+ZrfKWvvt6BGRRbtzqn0s7BNJUPESiwce0LaiIT8eDBVZVbDK8wQKIHaQ
         fyte4sMGWmPqIAGzV3WsFNmfTio/YVe+mOp79BtMnUYJIwElPQ2z68/QZvEcmxHigpgV
         kzoC4St06IbT79dyA+sdUytpyH/jtOuwK4PgEDPZmxmz7lWoECKvoITIFjCIkd8x9TBi
         9GTTeG9MnfNUXQboc03Xmzy+NT/zzX45Xv6+RPBFlhSfC8D7q5D9aN5F7lsT6MFQzFSx
         /Qnl6fPOLilUZjUojTdPyIIfSq/DYWTMRawZok+wvt8za7zpgUyvUneie9G+GkpyJJXc
         4Rww==
X-Gm-Message-State: AOAM532lFZuNCGCMmD6GVVetcxSdiC4cwzkUBp9zynHN1G3loKJnabc9
        I6N4gnpctJyMD46vYXwTBckWcK7SOtgjMQ==
X-Google-Smtp-Source: ABdhPJwEGm1kTpzAIyvA2AT4EHJMLuNc01USF4xHLk6zt7D5JMZHM07Ia3yEZLOvzV7Eoq3pYNOOSA==
X-Received: by 2002:ac8:5390:: with SMTP id x16mr3897420qtp.194.1614863369374;
        Thu, 04 Mar 2021 05:09:29 -0800 (PST)
Received: from [172.17.0.2] ([52.254.50.13])
        by smtp.gmail.com with ESMTPSA id x14sm17707578qtq.47.2021.03.04.05.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 05:09:28 -0800 (PST)
Message-ID: <6040dc08.1c69fb81.88693.e0fa@mx.google.com>
Date:   Thu, 04 Mar 2021 05:09:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3257602178730776163=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [1/3] build: Add warnings for non-literal strings
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210304124851.219154-1-hadess@hadess.net>
References: <20210304124851.219154-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3257602178730776163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=442025

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
build: Add warnings for non-literal strings
3: B6 Body message is missing

obex: Work-around compilation failure
4: B1 Line exceeds max length (123>80): "obexd/plugins/bluetooth.c:310:7: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]"
7: B1 Line exceeds max length (123>80): "obexd/plugins/bluetooth.c:314:7: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]"

tools/mesh-cfglient: Work-around compilation failure
4: B1 Line exceeds max length (121>80): "tools/mesh-cfgclient.c:543:10: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3257602178730776163==--
