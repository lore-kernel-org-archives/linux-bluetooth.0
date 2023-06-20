Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295A9EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 22:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFTWby (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 18:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjFTWbv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 18:31:51 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FC3DC
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 15:31:50 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-763a3032893so212683085a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687300309; x=1689892309;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FPa0LKjy+58no4IIDxTtXSFGA0y+AY9mpDFMzL5P184=;
        b=JkA0WUntCPFZu7OAUjSHmSI9yE5wJfhv/FEXtjchqQ5ZLKeKiRcvinDnL9sCJ/lRnH
         WwbFgeoUp71tCKH8HjNiUEK68GyOUl7PxBmLt+hRVlDm+6PJReEQuAt3xhOurzXjjusJ
         f+uHnyiwMx/8HzGjv0SdndSJhT9YXoPBd1P2hhIlpm2Oabw5Zwg0yaa2XWkfw8LGImcj
         WXEsLkuq10vprlj4bHghv0ptwgfz9yoEabLnsOIZxm1GXofNwN9Pl7vP6WRuFVgPUbc2
         sIixm/alCJLwmSeGAV9dgZRBzlXHYfbqTsS4f8A+cWiveAWUmRuGbaC/xauarxM0J7DQ
         l9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687300309; x=1689892309;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPa0LKjy+58no4IIDxTtXSFGA0y+AY9mpDFMzL5P184=;
        b=gG1n/xMUk8/UwCYfdHhqXDLGUTxcEKvFQ5SIQVlzOhPpBi8/PhTKjQFr/7Gpv9S2Gz
         u0VJK8Pn2wQyzUz1iULrQKJqVIbF72dC/evhhJDlAEz43/mVwa+PccU/MV2JddXDQKW9
         pfwCYu+YVsYLeTqhZPGI66uz7encuTfZxn+PNfdqEWPQv/nEiloj5SaPIDbpzLXP/Mol
         wibpf9Napi37YPsVhHui25LWwu3HMAg2ilGIPXQrpxV3wSYITn++6zabyaPjQaRJCkx9
         F+/g2ipu4cOqCzKUSisZEQBwmZBc8ubFKFCmh/081dmB5L0MN04Ds4QylTHpXBMiixkd
         0J3A==
X-Gm-Message-State: AC+VfDwpwaKsveS7fDlstlGUDE3Bc9923egwIS9qshMzFlpl9hODAoj8
        ht6gPJe9LRb/VJvrrjeUQHJhSBFMHur6MQ==
X-Google-Smtp-Source: ACHHUZ5HKBMMoltocGnIUNKFWPmXjS0Z0/F7YwPGn+Lk6/ip5bxeKJqepCHsHecqfRABpvTcOWh+tw==
X-Received: by 2002:a05:6214:401d:b0:62d:efa2:f19a with SMTP id kd29-20020a056214401d00b0062defa2f19amr13447469qvb.50.1687300309085;
        Tue, 20 Jun 2023 15:31:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.74.246])
        by smtp.gmail.com with ESMTPSA id r11-20020a0ce28b000000b0062ff22cf1aesm1740334qvl.23.2023.06.20.15.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:31:48 -0700 (PDT)
Message-ID: <649228d4.0c0a0220.1c9f1.5993@mx.google.com>
Date:   Tue, 20 Jun 2023 15:31:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1135495690171518736=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] mgmt-api: Update Device Found Event documentation
In-Reply-To: <20230620204053.643608-1-luiz.dentz@gmail.com>
References: <20230620204053.643608-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1135495690171518736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758865

---Test result---

Test Summary:
CheckPatch                    PASS      1.48 seconds
GitLint                       PASS      1.03 seconds
BuildEll                      PASS      26.57 seconds
BluezMake                     PASS      790.04 seconds
MakeCheck                     PASS      12.17 seconds
MakeDistcheck                 PASS      155.14 seconds
CheckValgrind                 PASS      248.12 seconds
CheckSmatch                   WARNING   335.64 seconds
bluezmakeextell               PASS      101.25 seconds
IncrementalBuild              PASS      1960.96 seconds
ScanBuild                     PASS      1008.06 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1135495690171518736==--
