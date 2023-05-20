Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A6BC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 May 2023 06:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjETGey (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 May 2023 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETGex (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 May 2023 02:34:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535BE1A6
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 23:34:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3319a6f989aso28613345ab.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 23:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684564491; x=1687156491;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yR+pNBdjELl4ujIzJbepdFTXSF4LXKSdSy+OnhmMHeY=;
        b=F39so2dEClp9wm6Vj7Q4zYQuyzbFsCpFCjPKbRSFnJuVqLidhMni60JWuvJQHjrBTo
         Qv5AvLg9EW+eIWObltXdNd1eIStgdxHpo8FNs4xhCMtlxBlWTbZ8HSJCnyi/rEe7yrFj
         BnQIFc6Fyll5g07hc0vHU9mMkFCzEM0m/+vMPh1P8/wYHN1cAJoeQpjtLJcbm9bhBrtc
         o09NYYxfQi6VVVrb0isUqF+E/jU/4ZcRvBI5f4ajjT892IoswlF96gF7OJ+HYlKTc3bq
         a4fdsbB2EUnO8XRHYpIdkR1yZDJNmmfYDM7ybNWMjKA4Vrj/wJG6y3LLLlxfRgdBOhz9
         WXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684564491; x=1687156491;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yR+pNBdjELl4ujIzJbepdFTXSF4LXKSdSy+OnhmMHeY=;
        b=NKqyx/0W6XI6hojH3SURvdiNb7kLoED5Wab9f8QOVN46a3yKGvV5XM5axpLk0P1ZnS
         UOiRSDLNSuSA8SGObOJiAIYsV2lHzAHij0uXBTr73+cvGzKBhyLXI+SyytNX1Kh6krb7
         Ftu2NyqwjHm02cOAVzaN3sasOu+WAqcxVe6jHaXsPpGXuoSh0U2HqE9Mr9cpR4c7d9Jo
         ONIJkhJuQmXdMZz7vdf3+ybgk7gpwoAV2/d8HSn0vxUq6tnoyNnLWTBN454XfmR3NEh4
         nfjOn2s3fNFcU62QGKEzV2etm78sbeSezav9L+FoJwgCz92JsCDveCpIQcSShwoGvRHo
         +/hQ==
X-Gm-Message-State: AC+VfDyZMOFuBx6N6s9hWrTmVIflbvVa6eu2RQ5lobLvzc2frPkEa8yA
        DKtYEglpjDotcM/5BQI3tUmaxg59On0=
X-Google-Smtp-Source: ACHHUZ7kuj77gUQ0D/KlEmObKWLpfHk9X4bp0tBY9HsLapZ/gP6deOXcj3umR5rPLInYmJRCgXWs4A==
X-Received: by 2002:a92:6a04:0:b0:338:1a22:bf40 with SMTP id f4-20020a926a04000000b003381a22bf40mr2578289ilc.3.1684564491479;
        Fri, 19 May 2023 23:34:51 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.243.86])
        by smtp.gmail.com with ESMTPSA id b27-20020a05663801bb00b004063510ba0esm287899jaq.142.2023.05.19.23.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 23:34:51 -0700 (PDT)
Message-ID: <64686a0b.050a0220.1ed92.0410@mx.google.com>
Date:   Fri, 19 May 2023 23:34:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7710245091066796596=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yongxin.liu@windriver.com
Subject: RE: Bluetooth: add missing hci_codec_list_clear() back
In-Reply-To: <20230520055147.3212541-1-yongxin.liu@windriver.com>
References: <20230520055147.3212541-1-yongxin.liu@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7710245091066796596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749440

---Test result---

Test Summary:
CheckPatch                    PASS      1.30 seconds
GitLint                       PASS      1.19 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      31.82 seconds
CheckAllWarning               PASS      34.70 seconds
CheckSparse                   PASS      39.90 seconds
CheckSmatch                   PASS      108.26 seconds
BuildKernel32                 PASS      30.79 seconds
TestRunnerSetup               PASS      441.08 seconds
TestRunner_l2cap-tester       PASS      16.93 seconds
TestRunner_iso-tester         PASS      21.39 seconds
TestRunner_bnep-tester        PASS      5.63 seconds
TestRunner_mgmt-tester        PASS      116.58 seconds
TestRunner_rfcomm-tester      PASS      8.91 seconds
TestRunner_sco-tester         PASS      8.26 seconds
TestRunner_ioctl-tester       PASS      9.76 seconds
TestRunner_mesh-tester        PASS      7.09 seconds
TestRunner_smp-tester         PASS      8.20 seconds
TestRunner_userchan-tester    PASS      5.88 seconds
IncrementalBuild              PASS      29.15 seconds



---
Regards,
Linux Bluetooth


--===============7710245091066796596==--
