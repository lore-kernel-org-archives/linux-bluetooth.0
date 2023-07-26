Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361CDC001DE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 23:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjGZXjT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 19:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGZXjR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 19:39:17 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B57E4C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 16:39:16 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a5abb5e2aeso353341b6e.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690414755; x=1691019555;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cg+5bk1zwZAol86N9yVYu6N/gttrAASRwBLBHCz8NNY=;
        b=OJym5RCn/2Z2kTH25CGBtNcXJqc6+1si4jpuanDNheVIv2d8H5bpRaxrsH01Zc/Lcg
         MKE+OEL28igUMfIkK/oPBG04e4rclRqS53V2alq8VBNh4KVxGG0jOhLS35ikVO/WsQ9N
         bzPvcB/waFk4EfDvxoyrys/IqZdRYmaUaf6ouuOYfLqdxvbB/EfXdtna3x/aIIFah2Pe
         896LgR3x0wD4/mkw+EdQzevcSl/f2BUcmU1N3XaLQUS54+fbj5zVknLH3CHAdy0VTj3+
         8u0ES3moAxdt30hfH9J7wwy6oBSfi+R24AKc2crRkkGEzq+oAAkwGhGrt78oULz3fc+e
         4+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690414755; x=1691019555;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cg+5bk1zwZAol86N9yVYu6N/gttrAASRwBLBHCz8NNY=;
        b=daq1FN/uB3qvTzo3N+lSwfeOgso8y9jyevIWsEdV112AMwvKITpyX3FGu8OSRKrtqo
         GBAdkUvy7sJzrmCaTDbC8EjXxscKGonc1Q1KpBSHOfDpIX5LSs7H2JrQ+5Btd6CbX1tJ
         exdL1nLshf9ZSa1NxgF0cBp2iAo+WkjzLNlnTrQIS/iDTS3+6algR1qgTkoY5KgjLMpB
         BbZenmBq9VBerbOnvCRkDvCK7fxC23wYENZprJmfwFILo7/j9YVjFA3pw6lgcCdsdX20
         P1ArtCJ4T6zysQLkXPOscxM9OxbGagKP2rlpPwitmiL9Bon7Ao+7a8/V+m73a00VdXra
         SkGA==
X-Gm-Message-State: ABy/qLb26iwv9sxfhONsbVzk7mp1lSjk7hVPjcQ/oPMJ4WXFgvoMV3XU
        vhW2pBo7Ow8G/TxaXiwkHfYAEXS7x2A=
X-Google-Smtp-Source: APBJJlGuOZ1RZGGt0Uq/Vka5sp8YYItHuVD7BN11lIMKnFNPdho6XTvbLjPYcrwu040jcEi9anHklQ==
X-Received: by 2002:a05:6808:b2f:b0:3a6:e045:40b7 with SMTP id t15-20020a0568080b2f00b003a6e04540b7mr459331oij.38.1690414755060;
        Wed, 26 Jul 2023 16:39:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.12.253])
        by smtp.gmail.com with ESMTPSA id a9-20020a0ce389000000b0063d10086876sm1963172qvl.115.2023.07.26.16.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 16:39:14 -0700 (PDT)
Message-ID: <64c1aea2.0c0a0220.6d263.afb6@mx.google.com>
Date:   Wed, 26 Jul 2023 16:39:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3262125920311625393=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Use gnuplot to plot graph of Latency-Packets
In-Reply-To: <20230726221803.975865-1-luiz.dentz@gmail.com>
References: <20230726221803.975865-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3262125920311625393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769868

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      28.32 seconds
BluezMake                     PASS      914.22 seconds
MakeCheck                     PASS      12.71 seconds
MakeDistcheck                 PASS      162.75 seconds
CheckValgrind                 PASS      265.33 seconds
CheckSmatch                   PASS      357.25 seconds
bluezmakeextell               PASS      107.57 seconds
IncrementalBuild              PASS      745.92 seconds
ScanBuild                     PASS      1126.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] monitor: Use gnuplot to plot graph of Latency-Packets
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#85: 
        Address: XX:XX:XX:XX:XX:XX (Sony Home Entertainment&Sound Products Inc)

/github/workspace/src/src/13328625.patch total: 0 errors, 1 warnings, 122 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13328625.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3262125920311625393==--
