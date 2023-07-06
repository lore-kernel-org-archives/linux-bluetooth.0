Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D2BEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jul 2023 21:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjGFVoF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 17:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFVoE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 17:44:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE719A0
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 14:44:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b852785a65so8514625ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jul 2023 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688679842; x=1691271842;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IlI1FFPK1bf7WKPv38h5IY5WQH2nsHj6pZSFv+50A2A=;
        b=GS6nA281VC6fYBVgwpMVQh6IefM3ugJAXc5lBA2x/I+ebvzxVnqZFR8rwAKncSpzoz
         U1X+dZGS8yNTHFRKreji7YipKA+R8+uihIWFfmYEgmK+xF3EpO6c5CWzuH0F/wALfgoy
         wR7TVo2PYTwIQaqSewKSbMMkjxmgHFNwsC/54NYBuUTpUrGShAcw9I1k4GaK0m6SrvNN
         KT7yryu8GLGsbzdTT0f0wvSBzLLumDcAQ/JiE7ORPiS3df7uWuFreqat+4rPc7ZrPdJ2
         UT7a//ZLzBitJard/ihsRPsOX0YA7o+xLIiG3jqtWvxkKbXcOEFt9SeMkVSUtxORsCG7
         60SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688679842; x=1691271842;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlI1FFPK1bf7WKPv38h5IY5WQH2nsHj6pZSFv+50A2A=;
        b=AV5HJrmCE6dm6ZewckuecO8Azpej/i5DrEU4tGI9c52pT7jySSpVWc+7q5q85rnKr+
         XbCpHrkoua6DT01KPJx4Sb6qR99pkiNFxTDig9xV/LFPaKZgCgpHRgVBMJeNRsyZ+A+G
         BsbS95lMWYl9dccYqyZbhNxsciXenhDL9D3/OFoAacV5ps0p4lQMSG/ZFqMZDfprh2kt
         9OzLzF4ZAJwAzpGg5N/NUChFUMt4noc7i5sn43gWHmd8tBQDHNxhBhbgJon9+b5XzsPg
         hfkDWsSMZJ1cW3CmWgUiCPN93sg2fPO5hZ1HrBRCvo54f4rN7UfZRByA7rBlBK5xG30O
         ZFbA==
X-Gm-Message-State: ABy/qLZNOCyykiDe7aAASpmuZeg0zXLFzDkITOxqHO07VATalN6Hfy6k
        rhStTATXEsJzJe51EgazDcYwyCJLTN4=
X-Google-Smtp-Source: APBJJlGjhZuQKJnoglgOb0RP9I/qx+6CcMkKybWN+45DMvtGBT1l0clE9eOQ1cAMLrKyK8eYnNwAKg==
X-Received: by 2002:a17:902:d481:b0:1b7:c09d:3f7a with SMTP id c1-20020a170902d48100b001b7c09d3f7amr10217154plg.11.1688679842600;
        Thu, 06 Jul 2023 14:44:02 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.61.226])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902eb4b00b001b8b3f7302csm1839875pli.260.2023.07.06.14.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 14:44:02 -0700 (PDT)
Message-ID: <64a735a2.170a0220.19d87.4273@mx.google.com>
Date:   Thu, 06 Jul 2023 14:44:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8995428095112124539=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] mgmt-tester: Fix tests that consider 31 bytes the max adv lenght
In-Reply-To: <20230706194801.391764-1-luiz.dentz@gmail.com>
References: <20230706194801.391764-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8995428095112124539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=763230

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      37.71 seconds
BluezMake                     PASS      1284.78 seconds
MakeCheck                     PASS      13.41 seconds
MakeDistcheck                 PASS      220.87 seconds
CheckValgrind                 PASS      357.01 seconds
CheckSmatch                   PASS      499.86 seconds
bluezmakeextell               PASS      149.72 seconds
IncrementalBuild              PASS      1119.44 seconds
ScanBuild                     PASS      1563.06 seconds



---
Regards,
Linux Bluetooth


--===============8995428095112124539==--
