Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8873FEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 07:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjHGHf7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 03:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjHGHf6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 03:35:58 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9410FD
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 00:35:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76cdf055c64so374558685a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691393757; x=1691998557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fGPgqzxxNlEWA1Oj89+poKYMK7N8oaF0g+JmhxFXViA=;
        b=B3eCeXS+oFd1jHdsrlFw5emTRHfowefLV3zVRQCkqNDbX1W918r1FiLUx3mwFT+fmT
         dEFp6OGi4KNz+lLmbAMK03mrx+ty4NwXHi5s9WJjjJPzwZ2gdpvtTb4YK6K7CJ8iwvW3
         QzxwCUksPWqMb6YqbavuPS1jWJ0DN0x1y9MxfcR0UKc8jKJhsao/QqMDkB5bMKZSOJ2h
         YHMv+wmiQDNXBMgax+Z5eEJ+AT2c/mk1VtHBmqN+2fCwiYHTy+l7LB0Vzj+TW7nAsvRs
         Of/jssBhPJmY1voSLRWu/i2rExvEwHtE5G6eMdlC9rFxDxk5VOmAQR81I0G0rjY+3sJe
         bbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691393757; x=1691998557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGPgqzxxNlEWA1Oj89+poKYMK7N8oaF0g+JmhxFXViA=;
        b=lst7egpzF3kqrFymxWCftX6/2x0VPca68vMEYHaHSvYAw3+T442zpdytlki99a70KI
         wxTJnIrol3kXl3R9mecRiLNqtTP/snfY0Yk993Sx6aaNHx11mlEOfjLWit97atKAxrXN
         WJjei9ILsskZ3TPG5ayI9q95hyjz0jdiF8e1osldYnUE2rnDit+3kXLYCs6A/vNps6L+
         xCnp1OYjeK2uabgOJS3UycMEMa9f2QAS8yqDDXwTLcqocd/I+EWYyxSPuNzMIis+Ovs3
         aBHXHldR/lDrkNhxgHO54v7HYNZNgas46+FElzkTm5ALvrJJKTd6kjnb7rvPmgDcE3xj
         rMyA==
X-Gm-Message-State: AOJu0Yzp1PL/s0cxTEL0lDAbczNhdFDal31FKU7HgTWtMRkFp/z0HklP
        kqJIN+PQGArK5PSeyYc1I4VQN/Up+6Rufg==
X-Google-Smtp-Source: AGHT+IHlZVG6gFTyup19c7wxH/8K2W7E+nGwAAoZKXt18gvKpbECKvzr5tAoFHldQo7y2ZC74rkF/w==
X-Received: by 2002:a05:620a:4513:b0:767:e9aa:5d51 with SMTP id t19-20020a05620a451300b00767e9aa5d51mr11882492qkp.3.1691393757058;
        Mon, 07 Aug 2023 00:35:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.69.195])
        by smtp.gmail.com with ESMTPSA id n19-20020a0ce553000000b00636e767d445sm2680282qvm.62.2023.08.07.00.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:35:56 -0700 (PDT)
Message-ID: <64d09edc.0c0a0220.d135c.8e42@mx.google.com>
Date:   Mon, 07 Aug 2023 00:35:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0715385763793986420=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_rjliao@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: add shutdown function for QCA6174
In-Reply-To: <20230807064626.980-1-quic_rjliao@quicinc.com>
References: <20230807064626.980-1-quic_rjliao@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0715385763793986420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773521

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.81 seconds
CheckAllWarning               PASS      37.48 seconds
CheckSparse                   PASS      41.82 seconds
CheckSmatch                   PASS      115.30 seconds
BuildKernel32                 PASS      32.91 seconds
TestRunnerSetup               PASS      491.93 seconds
TestRunner_l2cap-tester       PASS      22.64 seconds
TestRunner_iso-tester         PASS      45.30 seconds
TestRunner_bnep-tester        PASS      10.06 seconds
TestRunner_mgmt-tester        PASS      211.85 seconds
TestRunner_rfcomm-tester      PASS      15.51 seconds
TestRunner_sco-tester         PASS      18.68 seconds
TestRunner_ioctl-tester       PASS      17.34 seconds
TestRunner_mesh-tester        PASS      12.66 seconds
TestRunner_smp-tester         PASS      13.71 seconds
TestRunner_userchan-tester    PASS      10.93 seconds
IncrementalBuild              PASS      31.13 seconds



---
Regards,
Linux Bluetooth


--===============0715385763793986420==--
