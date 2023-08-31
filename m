Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691A7EE49B2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Aug 2023 22:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347669AbjHaWWk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Aug 2023 18:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbjHaWWj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Aug 2023 18:22:39 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AAAE6F
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 15:22:36 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bca5d6dcedso1103742a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 15:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693520555; x=1694125355; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n4Ggdk7DrDjKQ4yLiSEYGp/g+DoKThsmOoRuBK9VDVg=;
        b=EH/L2voFwZ4yLRsgnkurfN8xSLDQvsd0XDZHk0XFePsoaFum2JLbdHxdgpm+Np6I6O
         ap7qS5rLa2WCwsmoA1rq/kQxJOf/Powr0Q6y5mjH4bIY8xPtzYyhKpNtGJgXW/6hnTvm
         /DBLw1do3YUVOoQOb2yXVhlkTsnw1OZXxo3BEIgzRDriG8+nwO5kCKIyFA8uPIz1+W97
         K3CiAKsEekdGRUbB94ERqbCvMQy/fbFR1qnlft+qBq7zpOq4um/vkDngRxSayicfBvek
         +Kk0JUT6G6g30j4F1XGrviRbrfTLbp3E8VR3eJGoLd8LdVIF1WzokCKLKXLNlSNCOBwV
         Yptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693520555; x=1694125355;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4Ggdk7DrDjKQ4yLiSEYGp/g+DoKThsmOoRuBK9VDVg=;
        b=ZR5BSi55RjW8G4kKqyj45tffybGdsmOj8khSG5aILy6O4P2JIx0X7IO9WiCm7GJZLv
         jhL+UDJ7NuQAXpNO4g97chbcD9SvYsJ6E3XAaZWQykMyK9Pw1q0ed6MOH+nobiuObOcF
         iTt1Q5D6mpCHALM1U6fPbNl5Rpq9uDk3Df7gGUMwENIEFbnSG7veshrmWikJTUP2RuKM
         hRYQ8eII5CsnW79Koj7Pqdk2y5Qtti55h+g4FWGfzjvFy6FASJWwOn+eSog291WLmGn3
         tCee9U/yD++uy45+dCfbVDBYqXkSlOMPzmHBCLA02aw6NbxQGg6OFwIesObHu0xDVKNa
         zRGw==
X-Gm-Message-State: AOJu0YxRpqQ/YSJyyKycxP0ML5m2Z3bkAJ6ZEkUg0sADOSuvFN/Dykxz
        rE05uRgz2vLRSa4is7I7AnUnJhGC7Ys=
X-Google-Smtp-Source: AGHT+IFCG7GiQ8niyR/xsKqjpc63cH7GuvP/02KccTA/2McHpw3Fw5vUtmminUtPh9s8MXiviQNXrA==
X-Received: by 2002:a05:6870:2183:b0:1be:9a37:cf12 with SMTP id l3-20020a056870218300b001be9a37cf12mr810441oae.42.1693520555424;
        Thu, 31 Aug 2023 15:22:35 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.173.17])
        by smtp.gmail.com with ESMTPSA id cc8-20020a056871e18800b001c4ede43955sm1465872oac.31.2023.08.31.15.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 15:22:35 -0700 (PDT)
Message-ID: <64f112ab.050a0220.cc4df.9316@mx.google.com>
Date:   Thu, 31 Aug 2023 15:22:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8726231752567639420=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Fix runtime error
In-Reply-To: <20230831210554.1141646-1-luiz.dentz@gmail.com>
References: <20230831210554.1141646-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8726231752567639420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780953

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      33.86 seconds
BluezMake                     PASS      1025.75 seconds
MakeCheck                     PASS      13.10 seconds
MakeDistcheck                 PASS      190.23 seconds
CheckValgrind                 PASS      309.83 seconds
CheckSmatch                   WARNING   407.76 seconds
bluezmakeextell               PASS      124.64 seconds
IncrementalBuild              PASS      817.95 seconds
ScanBuild                     PASS      1254.40 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1856:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============8726231752567639420==--
