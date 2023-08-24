Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED848C27C40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 06:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbjHXGbQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 02:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbjHXGae (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 02:30:34 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73B5101
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 23:30:26 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40fd2f6bd7cso41455781cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692858625; x=1693463425;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AizPiOzTg7VqYLRlXCHWTGbg4QFoGdlkScFOO9+Snpk=;
        b=sZ/TGWgyKlh1eljEjcKRRvDqsABac3rhKcltE5bzLgFT+R4YO7w1S0UHFySPOoEJsm
         mZTj8MhLHRb+RQjjA39/c2AlnIA8BkqmPjXOcx2ZdixHXJp0+ciEutS78cKPjPgvqoHL
         Xb4MuOULBcJErL0uEXrtDE9c1QEMUM7q3YLQghYK9onErf/lGRhWzrn8flrJn/LXmMbI
         KTmFEEysHbRbHaUSbSC2WE8lkTwqnVleMUZUzSd5prCc5sHuXCvQkaAfn0JNqNn9K7rq
         Bnp0La+CLS4RV0aHI4puF0UQIq16Xqtc59ciRQvG8dSUJIu56taHgfqftRmqZvtiF6Fw
         bxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692858625; x=1693463425;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AizPiOzTg7VqYLRlXCHWTGbg4QFoGdlkScFOO9+Snpk=;
        b=ePBRW4iPV8tb7igwXh6EQME/0wZBosjOs3if62TLdE23X50aPZUwE7LPBPp0CJAuLL
         1ike74OVWl6BVoFDsjyiTtDFvI+ktg1koXNFlen2Wyl35eZA2iquGYxtt+kRJm5gQArQ
         MjZqVmfASm59KZfHGXea6/vSlgQ0dtv884/KY644uuojcXatSDRaS8Ms+egEWzWuomjV
         MndKrI/fdEUIs/sHFVw7t82h63VG/dtTSyAtawcHmVYknFLMoflbBaf+GN/zPprwORSE
         188hEra0jy8B1PK1q+W6pJi/PQ1V60xbr5QcYEqELJA3lMx8n6XfRkCB2K+3ng4ND7BI
         RBeA==
X-Gm-Message-State: AOJu0YwmI9MGtXmcTow8ywC2xG7ecs/8Ql22wvuHlbaeBrsXce//G5vs
        Q2P5drKM+M5rlV7qran7sflzhn0IySY=
X-Google-Smtp-Source: AGHT+IFn9k7boMc0XX92EBh+v9CCVobI6nGzRSgUYwaYQF6zv7+cJFmoXjDIe5BgMoNAv6r7xZHf+A==
X-Received: by 2002:ac8:7fcd:0:b0:40f:f435:1b27 with SMTP id b13-20020ac87fcd000000b0040ff4351b27mr17893665qtk.68.1692858625630;
        Wed, 23 Aug 2023 23:30:25 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.155.158])
        by smtp.gmail.com with ESMTPSA id d18-20020ac800d2000000b004108bebd1fcsm3332168qtg.24.2023.08.23.23.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 23:30:25 -0700 (PDT)
Message-ID: <64e6f901.c80a0220.6f47b.d3b4@mx.google.com>
Date:   Wed, 23 Aug 2023 23:30:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5603020488600762357=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] transport: Fix crash with broadcast properties
In-Reply-To: <20230824050045.4019298-1-luiz.dentz@gmail.com>
References: <20230824050045.4019298-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5603020488600762357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778839

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.39 seconds
BuildEll                      PASS      32.43 seconds
BluezMake                     PASS      1199.55 seconds
MakeCheck                     PASS      13.47 seconds
MakeDistcheck                 PASS      201.26 seconds
CheckValgrind                 PASS      315.99 seconds
CheckSmatch                   PASS      423.94 seconds
bluezmakeextell               PASS      126.42 seconds
IncrementalBuild              PASS      1015.92 seconds
ScanBuild                     PASS      1309.00 seconds



---
Regards,
Linux Bluetooth


--===============5603020488600762357==--
