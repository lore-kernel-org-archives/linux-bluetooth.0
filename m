Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E93EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 07:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjHGHRD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 03:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjHGHQz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 03:16:55 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13BE1703
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 00:16:51 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-63f80abbbb9so9991976d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 00:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691392611; x=1691997411;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DV/yHzroZxSVTmf0gfJT5JNn0LqXL1RjLQnvV3bgmbg=;
        b=p5kMyvQAgMd1GmFXVLpxsxKZm6N2a7xm2iMM+5Xj0oRINUhFEEefbGWdpQUC7+zNQs
         F9DCV4Z+OMxGPMBeyeNhIEAnj9n++p4IzueSNxAk1Mf858sRRkF52Aavc951WvBvgBBH
         lsBH6cU8tcKJ4cunLMoyv/+PLr9eD7+lM+Qq3iq6vHB+tTwy+AA7vPJu2Hhz7EpC92e8
         gUvc65+/uk10VrXRs8XogW9HCVsY88emxbBs3Xh09MT5IqNNFBsrqZYz70CkjJZhFftm
         iN4pZYFku5YraN2+2DCVfiJYIeDEkK7Rt8IGTc8yOrbd/1B+LZwqbkvtyYzhT10El2q5
         VU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392611; x=1691997411;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DV/yHzroZxSVTmf0gfJT5JNn0LqXL1RjLQnvV3bgmbg=;
        b=BA2ykP2CwIcZPi6vTygrbrxCxp36Ym9tJnC934XxUGqlm5EaaIimvuNGBD79PUXDNe
         MbLE1poH/iW5noCapinxmLkDGvM642pPlxdqTk4AwdkqpHRNIEVPDRatIqbX8R7GEjmJ
         SUIWL4CgsfnDmFc3fnsS+9NxXciokZkIQr41jEMhZmYrcSCQntT/VcBxOu6J0zb6P8am
         0Hco2xICjgdHi3HTrouLp7OIGtQlXybctDE3ieAe8F0oXIJSpiCQ8gRjNV5zWFQLE0NM
         rBkFzJFKCvGrVTLIVQpYAvqsFVtUln0svvugAikKCNXG9jBmZAil2+Rfnmo5IcT8UiP6
         HVMg==
X-Gm-Message-State: AOJu0YzorcyIIZ0WS52Tt0+C2y4aWDcnMhVsAHagOnuxZkuAHVGNGJ/e
        MX6+lk2tYYjcIEGViFS8LyC1dHGx4G0=
X-Google-Smtp-Source: AGHT+IH/mi3nn3ROdj4ruOwYL6Q+/l+PN0VpwSRMGPVTHnNPbdXzmxAu8Y/TYdM2CGccqHyxU+linQ==
X-Received: by 2002:a0c:e3d4:0:b0:636:afa1:345e with SMTP id e20-20020a0ce3d4000000b00636afa1345emr8406808qvl.12.1691392611026;
        Mon, 07 Aug 2023 00:16:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.14.209])
        by smtp.gmail.com with ESMTPSA id z5-20020a0cf245000000b00635ef3a34ebsm2662176qvl.48.2023.08.07.00.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:16:50 -0700 (PDT)
Message-ID: <64d09a62.0c0a0220.89ff6.909e@mx.google.com>
Date:   Mon, 07 Aug 2023 00:16:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2124434574110648831=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, karl.bieber@proton.me
Subject: RE: main: Fix missing comma
In-Reply-To: <20230807054108.234233-2-karl.bieber@proton.me>
References: <20230807054108.234233-2-karl.bieber@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2124434574110648831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773494

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.53 seconds
BluezMake                     PASS      868.93 seconds
MakeCheck                     PASS      12.56 seconds
MakeDistcheck                 PASS      158.28 seconds
CheckValgrind                 PASS      258.62 seconds
CheckSmatch                   PASS      344.39 seconds
bluezmakeextell               PASS      104.23 seconds
IncrementalBuild              PASS      714.51 seconds
ScanBuild                     PASS      1074.26 seconds



---
Regards,
Linux Bluetooth


--===============2124434574110648831==--
