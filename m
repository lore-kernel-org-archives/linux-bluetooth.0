Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C0FC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 00:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjC3Al7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 20:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjC3Al6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 20:41:58 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C9C5BB0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 17:41:53 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id j2so2000845ila.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 17:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680136912;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TA1NBnStdHsn71W6KB55S8KkVqjcLyVMswQcE3Sfd1A=;
        b=CUuu9ytFtvgRzE2/DejnKrByMZz3iWviN9ybHDuIl6Iv8o+tR0l1jZ09DGstIHOS9X
         1PyFo0WPPq2fIQpRuAGlEFp1ikohQIIiGjmGxeU3SDRg22rFCC12/rJZUwn0SzUlKLCH
         2xHG7l0X4fMbGYREhkFQZHRUC6OaRIrYlJSYlkgNKcBQr/LQoNEno634kThhOF9jIoP/
         lLwEbV5+yZe8Bb5cHJVZ+86DSizok1+caRXZQyLC0iOOwGuFWqbfEXlRZhygG6MDSx2p
         QWoZQ1ulKDuRO1WdlZSzINIdITd+TgvusSvQ6Rom3d7YKA4u/A9gn1sh+tKm4Ewu31VZ
         0Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680136912;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TA1NBnStdHsn71W6KB55S8KkVqjcLyVMswQcE3Sfd1A=;
        b=sWeA2LIbnnsrIj6A4VM5uhGM8yJJwbX2MrS+n0pGlf7lnv0j7gEvU5RsQT/d7Dq4PV
         Byb9m2DydjjX+53auecgGnDplFRvoaicVvXIVFpIYcwZuJzhrCQ19ZS0ixKJ5y1dVUbO
         CcYzQ8iO5rxo6g2rQbedRckLBXGfMd9VyNVA9XdMAEwkQwSVBtLOcksWl7E3dc84zbsG
         m2rqERoBbsYJHygmI4vqLdmih7ri+FyfP1tq19yhtUv/KV7VLARlbTqabbAHF6CjhZlr
         EeikKnyeo1C2D/xP0pLHvkepQn68m7yv407ow/HcthwBcmAKu2MeNRSHyV3utC0u6IKw
         m75w==
X-Gm-Message-State: AAQBX9cJQ4Mt9NWNKtcup5kvyHS0V1AOjo+m0jRVYy2Z+6K0xAoxxV3w
        w301cT7j+/1efDTRe13e4w1TyfgEwVk=
X-Google-Smtp-Source: AKy350ZgjeH+2rjGnu8ANxiHtZ6uuXVne8Mg7FPbfRNp41wYSPjXtz/pzaXszBbuD2x+sC4NyEkuQw==
X-Received: by 2002:a92:cc46:0:b0:326:2ba5:e9ce with SMTP id t6-20020a92cc46000000b003262ba5e9cemr2965999ilq.26.1680136912526;
        Wed, 29 Mar 2023 17:41:52 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.50.161])
        by smtp.gmail.com with ESMTPSA id r17-20020a92ac11000000b00312f2936087sm9452192ilh.63.2023.03.29.17.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 17:41:52 -0700 (PDT)
Message-ID: <6424dad0.920a0220.42400.f394@mx.google.com>
Date:   Wed, 29 Mar 2023 17:41:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9023370799873447111=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] bap: Mark devices to auto-connect
In-Reply-To: <20230329232537.577958-1-luiz.dentz@gmail.com>
References: <20230329232537.577958-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9023370799873447111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735183

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.54 seconds
BuildEll                      PASS      26.81 seconds
BluezMake                     PASS      762.58 seconds
MakeCheck                     PASS      10.82 seconds
MakeDistcheck                 PASS      148.65 seconds
CheckValgrind                 PASS      241.53 seconds
CheckSmatch                   PASS      322.74 seconds
bluezmakeextell               PASS      97.30 seconds
IncrementalBuild              PASS      1226.54 seconds
ScanBuild                     PASS      970.92 seconds



---
Regards,
Linux Bluetooth


--===============9023370799873447111==--
