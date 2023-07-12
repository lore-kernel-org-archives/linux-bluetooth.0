Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC167C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 06:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjGLGDg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 02:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGLGDc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 02:03:32 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89981173B
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 23:03:22 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b711c3ad1fso5423787a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 23:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689141801; x=1691733801;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AHXG1X0zzIJ9XbGbfsckF06j3RivSsZsJaTfxqIwkOU=;
        b=UXeIzfkesf895yI0b/s4zj6Dx7XD4XQo/MoabPuPK4Ce03eNaUyUYabRwt75Ppd7Bi
         aq3Hi/IyQT7CytBoTBOKoCVQxViwwEetU0dvWsmXO88ntYpJSe0sD622xbM/jmOI4RHL
         k0fnJ2m2kN+lvPu0tDCRJyZn0VeQQSH+ZtZn/nLWSMKJnGaynCjEpllbUpCZi5/kwrGz
         H/G6BxaFpzAVBgKvYkGtGlHxF//A87Wv0SNj59twz2w7XGkKks9+Z3wqEMNyyf7LW5J4
         9b49j7B5lo9TtwxoeYbCWzw9pOH/vjKZGYwXE/K7kbzM5KNo/O9ss/kq7cnzQzZdFGm+
         ZApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689141801; x=1691733801;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHXG1X0zzIJ9XbGbfsckF06j3RivSsZsJaTfxqIwkOU=;
        b=Ap22lPhx9EzMmmsuBRo1rLmTavQ63lT7ZorR1xbUN/DQL47J0ZadQ2VAnVjF0TK/YW
         WlhuUK5zlJzzvC97yL4m+pHsna6Su15Cu8dXJNUHpYqGuJ/WIL+8mOg4Hu7G5GNNujJ4
         ffBAhsVB8yGExMJPQb2QZaB4sCH12R1OKuzJpB3GQHDdeAAu2s2kaSxWLl1cGfq+0lEx
         x6ycufcbgJuQB/WOObF1sV3cGUACH4NO0sljwZM+NmmK6LHTleOTwshjVGeHaEyITE/l
         OITRn8mFSldKStSD8p4ySGR+bUxrOwzXgtmOZ+yziWqjUB0az7QZWpHkLvZ5r4H91nQt
         TKqQ==
X-Gm-Message-State: ABy/qLYeT1seiCe5Kr/JWaXAgrc1pKhwwduBQN2Sb4uIEy92svzoXErX
        0KVCdP4+rZjWCZE0YX/mpnBCc17uEJw=
X-Google-Smtp-Source: APBJJlGYIi3UJBi7R/6r6Uwi01a8st4YeSAgP0ZuwzrDeVIacuHHXPURpVVwcyMuUw3FKgH5ac0LtQ==
X-Received: by 2002:a05:6870:4688:b0:1b0:4ee7:a758 with SMTP id a8-20020a056870468800b001b04ee7a758mr17903134oap.37.1689141801215;
        Tue, 11 Jul 2023 23:03:21 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.171.19])
        by smtp.gmail.com with ESMTPSA id i21-20020a056870d41500b001b437acbd0csm1721814oag.32.2023.07.11.23.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 23:03:21 -0700 (PDT)
Message-ID: <64ae4229.050a0220.50f81.b36a@mx.google.com>
Date:   Tue, 11 Jul 2023 23:03:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1643568928762273336=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v3] Bluetooth: btmtk: Fix null pointer when processing coredump
In-Reply-To: <20230712051857.13812-1-chris.lu@mediatek.com>
References: <20230712051857.13812-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1643568928762273336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764645

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      35.31 seconds
CheckAllWarning               PASS      38.53 seconds
CheckSparse                   PASS      43.91 seconds
CheckSmatch                   PASS      117.28 seconds
BuildKernel32                 PASS      33.93 seconds
TestRunnerSetup               PASS      498.54 seconds
TestRunner_l2cap-tester       PASS      23.75 seconds
TestRunner_iso-tester         PASS      42.87 seconds
TestRunner_bnep-tester        PASS      10.73 seconds
TestRunner_mgmt-tester        PASS      219.56 seconds
TestRunner_rfcomm-tester      PASS      16.09 seconds
TestRunner_sco-tester         PASS      17.10 seconds
TestRunner_ioctl-tester       PASS      18.26 seconds
TestRunner_mesh-tester        PASS      13.55 seconds
TestRunner_smp-tester         PASS      14.53 seconds
TestRunner_userchan-tester    PASS      11.33 seconds
IncrementalBuild              PASS      30.74 seconds



---
Regards,
Linux Bluetooth


--===============1643568928762273336==--
