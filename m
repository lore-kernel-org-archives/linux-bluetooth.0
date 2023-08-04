Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257D7C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 15:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjHDPsi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 11:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjHDPsh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 11:48:37 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF98170F
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 08:48:36 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-63d30b90197so13448146d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Aug 2023 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691164115; x=1691768915;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Tn3biHftk+2YQuVQgUGTpV/ZdvFj9cDRoMpt0g6Lo4=;
        b=W2J29cSDrQlqLAjw3npW86nL5tiDI/5PwuKWYYyr5ajdLR+DfOvVYjqhq4U4zOZovh
         D1ahkiL/BeaSdUo6CZhgcHKX4BDS+o/iP2HjGhXjLdSFyAQjsz2mgcU5E7C/9GXNlnsJ
         hfauOKTjx8cok5X4o+NgQslWcI4wsW2VjFNXJvzg+aMiDoZmxhtdXj2NNSdcRDk0K5JN
         rFxPvXIxEWLGs770iDgaOG7YUw8d2yuGsZwe+nlhdU0WCpgKh+LgHNvvS/e7AVVodMoU
         t+Qn1kJukzvBvK40OR5yfJKwrPIeF0YSyHcqdH8imXxWyx6BnEC2XslSsHHjFDKvOd6V
         2YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164115; x=1691768915;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Tn3biHftk+2YQuVQgUGTpV/ZdvFj9cDRoMpt0g6Lo4=;
        b=LOc6dnpsBiESBSSuJkClschyauafW0Bxn4GH8g++hEQke+NFVf0ICwhOzUap/lpEsJ
         uojOsoDdRnzWumitNWT4AC5D/gC9wdxHYVj0J667RjCOH7woBbFiij+GtnPJOcJgksfA
         x08A7+sn9sFMj3idyJWBwsYOEuA8ELTLgjF3dyELFbkQRapQKYhunzOfGgROyBp9Y72T
         R8M29Sv3lKGCEG/uNcp52OoFbUYsO/Lm66nhcLn9kLNR4Z+FAOM9kdqpK+f2NZk0FuK/
         sxIrwHlEwZaDGb+hnopzg4dpLFmGo93ZoVVdHBsUAaXee11VHlpWc7J9C5V7fk0f7ovO
         iTTA==
X-Gm-Message-State: AOJu0Yx3P1Xy0CY/UApuya33j0Ly7UrCKBvlsb/WGMzcL5ylmXyv+22r
        RIDET6dSdtbw6Z8YUxsK7ffZZpcqnxs=
X-Google-Smtp-Source: AGHT+IFpX76WWacLfXsCrfDlxtcKHidu7AKsa2Mi3tf5qL16EsAjEiND0hU3Fb3njceqvwKdMBnb2w==
X-Received: by 2002:a0c:b44f:0:b0:63c:d763:764f with SMTP id e15-20020a0cb44f000000b0063cd763764fmr1634101qvf.6.1691164114858;
        Fri, 04 Aug 2023 08:48:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.14.62])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cf38b000000b0063d67548802sm739794qvk.137.2023.08.04.08.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:48:34 -0700 (PDT)
Message-ID: <64cd1dd2.0c0a0220.62eb3.3c8e@mx.google.com>
Date:   Fri, 04 Aug 2023 08:48:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4362807421734251706=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Configure BASE using separate structure
In-Reply-To: <20230804141059.24352-2-silviu.barbulescu@nxp.com>
References: <20230804141059.24352-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4362807421734251706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773144

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       FAIL      0.94 seconds
BuildEll                      PASS      27.90 seconds
BluezMake                     PASS      872.02 seconds
MakeCheck                     PASS      12.15 seconds
MakeDistcheck                 PASS      157.53 seconds
CheckValgrind                 PASS      256.46 seconds
CheckSmatch                   PASS      343.69 seconds
bluezmakeextell               PASS      105.00 seconds
IncrementalBuild              PASS      1430.00 seconds
ScanBuild                     PASS      1070.22 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] client/player: Configure BASE using separate structure.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[1/2] client/player: Configure BASE using separate structure."


---
Regards,
Linux Bluetooth


--===============4362807421734251706==--
