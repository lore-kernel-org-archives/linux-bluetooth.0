Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82B3C00528
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 07:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjHBHsO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 03:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjHBHrt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 03:47:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D067A3C2B
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 00:44:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so9360032a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Aug 2023 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1690962279; x=1691567079;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmZUwCATYcE4I44HqWj5mINUgIL9T66G/Uq+yOfL8/I=;
        b=PaAbygFf3Injl5w1BWy3k42sWQc8+A+0Eb8dh5C/4YmhYirBvJ2Plsm/wGbODCl0EP
         FKhtvZfFaIyCb80VUGIfIQuFEoAsz8FxlZiFW1YtAyKh995k3eei4lKwkgW5zyvxvYGP
         6GstQcgd08qABfabA42c4snHgb8ofhIZ/XKk3z7VEzJed7adeV23YFOHqXsZJAcg4qnT
         d067591v8ckAaobVRFOcsGb1wmlArdirQ7jPA6eQBKL4TJHnlWRqOv/FzgzqYnS3PHV2
         baPgwBHcvmh3Yh1kamvXpr3mIsF67mRXYpD+rH76hF9Sbb9JKijFh7W+0Sbhy3Rw9RTA
         OUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690962279; x=1691567079;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GmZUwCATYcE4I44HqWj5mINUgIL9T66G/Uq+yOfL8/I=;
        b=arKIAJiIneFUXCo7FlUYa54Gw8WlnrOBWxY/UznuMa5Yje0BZM6LO57sXhzSc/fBhg
         0JIc6SwNv61fRYqqfYW3aMeQWXSoxfC+5k3z1T7rO0D3Teoyp/rrpOytB78WyThxWhXO
         3OT1kmt34syY1oaMNZI34IEGbbVwtpD/8y6+3DHgb80U6budvrdeGAx9lLtO+tatvEVA
         Dg8gHPOLFnVHw2bdIap83Bmgp94SpOBGvpkSdfj9q9YpmR7WS5ecDe+hq1TnnIHrSbB8
         47/l3aLTiLVcOzfVWg1nvUU1xB05kIluNr0MdhJZgUZLtmtUONw+c/vCaaZdF52CyF3R
         Nh3w==
X-Gm-Message-State: ABy/qLYUOPW/FsvaOYSc7jE9HlzWTV4gwr6t3KgvTUMnzO0pRgKi71XB
        NSQoin28uCIfYdNpPxdKCFKUJvtjEKBf8GnXlBf+bQ==
X-Google-Smtp-Source: APBJJlEw23V9wEWT+QOq6+62Q9yYMMQtWHn1NNmAf7yK+OfyRs/DiLUYXGxKVeOXzKWbPHorCGExvg==
X-Received: by 2002:a50:fb84:0:b0:522:5932:57ec with SMTP id e4-20020a50fb84000000b00522593257ecmr3882320edq.41.1690962279065;
        Wed, 02 Aug 2023 00:44:39 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id bc21-20020a056402205500b0052229882fb0sm8008394edb.71.2023.08.02.00.44.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 00:44:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 02 Aug 2023 09:44:38 +0200
Message-Id: <CUHW3MP9M1IZ.60K0KONDMM7J@otso>
Subject: Re: Add WCN3988 Bluetooth support for Fairphone 4
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     <linux-bluetooth@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20230802-fp4-bluetooth-v3-1-7c9e7a6e624b@fairphone.com>
 <64ca0759.170a0220.f8e23.106f@mx.google.com>
In-Reply-To: <64ca0759.170a0220.f8e23.106f@mx.google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed Aug 2, 2023 at 9:35 AM CEST,  wrote:
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D772=
019
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.41 seconds
> GitLint                       PASS      0.49 seconds
> SubjectPrefix                 FAIL      0.45 seconds
> BuildKernel                   PASS      34.12 seconds
> CheckAllWarning               PASS      37.35 seconds
> CheckSparse                   PASS      42.35 seconds
> CheckSmatch                   PASS      114.38 seconds
> BuildKernel32                 PASS      32.91 seconds
> TestRunnerSetup               PASS      502.09 seconds
> TestRunner_l2cap-tester       PASS      23.78 seconds
> TestRunner_iso-tester         PASS      43.12 seconds
> TestRunner_bnep-tester        PASS      10.73 seconds
> TestRunner_mgmt-tester        PASS      218.39 seconds
> TestRunner_rfcomm-tester      PASS      16.22 seconds
> TestRunner_sco-tester         PASS      17.27 seconds
> TestRunner_ioctl-tester       PASS      18.37 seconds
> TestRunner_mesh-tester        PASS      13.81 seconds
> TestRunner_smp-tester         PASS      14.59 seconds
> TestRunner_userchan-tester    PASS      11.37 seconds
> IncrementalBuild              PASS      36.70 seconds
>
> Details
> ##############################
> Test: SubjectPrefix - FAIL
> Desc: Check subject contains "Bluetooth" prefix
> Output:
> "Bluetooth: " prefix is not specified in the subject

$ git log --oneline --no-merges Documentation/devicetree/bindings/net/bluet=
ooth/qualcomm-bluetooth.yaml
a52ced6cf835 dt-bindings: net: qualcomm: Add WCN3988
6a0a6dd8df9b dt-bindings: net: bluetooth: qualcomm: document VDD_CH1
87a1752bdd8a dt-bindings: net: Add QCA2066 Bluetooth
b1d00baaa029 dt-bindings: net: Add WCN6855 Bluetooth
45564c4ef607 dt-bindings: net: Add generic Bluetooth controller

Don't think I'll reword this commit message to start with "Bluetooth: "

>
>
> ---
> Regards,
> Linux Bluetooth

