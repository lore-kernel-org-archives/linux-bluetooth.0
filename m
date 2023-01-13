Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3A9C6379F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Jan 2023 22:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAMWjS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Jan 2023 17:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjAMWjP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Jan 2023 17:39:15 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55E97F9C6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 14:39:13 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id j15so14823375qtv.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 14:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxCMtiz+/xmYg+bbRltDh8QFHVr1SHNW3SafV+ZFZlw=;
        b=g6asJFfbzI/UCY6wvDwuD4379spJoM1lbQRFpqw6UtjfPeKkL4/T0TK9vVdTiNlvHN
         hbvn4frnMQKXBffTeKCxUnew+Dx8l40kw4E2yPSu7vlBmIpwRDT1na7FTe/3mbwuY37K
         PMwlpOe3ZnA/DuBf7zuKN6UG59yv1ndAk2S2ZEhGeOgsQId0iuUj5hs9qdqs/mQmy81L
         scSsDgeNfT85yPtwVGBKXNHH1qLsyb4RxueWMKzpLifbXHd9EpQ4bFQHV2cFu4+EWlfg
         /iVXVeoGHrZ4UKPCWHv0eiqlCwZhCs9Bb2Szt7Jq8+jMaO6hH0EyTYIHoyD+9epugmAF
         ObGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxCMtiz+/xmYg+bbRltDh8QFHVr1SHNW3SafV+ZFZlw=;
        b=Xok7NCLBs29RLn56/l0pAHSp24o808MO3KUbcVnzhYApWIPezs6QB/1uwcgOEayYoR
         zvsrFvRruwAzjoiYBQqEWw4CyvWx4wsqFmngZ1tiA8QyI1mhVj++g64hRrWOhlktJmsk
         O+GnSmlsZBCl0xp9i2pD5BINFKQ1ErRbkPoG5+RriHcIPea//uxdCbLw81mWWhWxpTI+
         NUr0y8NwYYYt1kVuBDf+d9kqqEJ5Ui5+UajQj2DdwVy5XH1vRXZph1uuFqyCr26t+8oB
         fTTKMN7um+ZH/W4d9qr5jl537SMx+OsTbYnXci7upYk1URIq1Z2st0uZ4v7jcrehn7Zg
         E08Q==
X-Gm-Message-State: AFqh2krgPixu27iZZHuEvvalHmnrQ0n2q5QxTw7QGGhkDTjMmJWg6g3j
        Iu7oTOY+5X+6rbJWGK4Vtz9kdAVU3dT0YQ==
X-Google-Smtp-Source: AMrXdXuQPiEvIpkVRx8r0oRzTuwRIDjsFnCJ84T86ywjQ7KBaEgaveb+d6gX2Ie3kVpsqW3lXYrvjg==
X-Received: by 2002:ac8:6a0e:0:b0:3a7:ea57:bf20 with SMTP id t14-20020ac86a0e000000b003a7ea57bf20mr108533831qtr.13.1673649552943;
        Fri, 13 Jan 2023 14:39:12 -0800 (PST)
Received: from [172.17.0.2] ([172.177.134.80])
        by smtp.gmail.com with ESMTPSA id bs25-20020ac86f19000000b0039cb59f00fcsm11257347qtb.30.2023.01.13.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 14:39:12 -0800 (PST)
Message-ID: <63c1dd90.c80a0220.74a70.9244@mx.google.com>
Date:   Fri, 13 Jan 2023 14:39:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0755730680081298899=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/bap: Fix scan-build warning
In-Reply-To: <20230113211638.303409-1-luiz.dentz@gmail.com>
References: <20230113211638.303409-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0755730680081298899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=711925

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       FAIL      0.63 seconds
BuildEll                      PASS      27.43 seconds
BluezMake                     PASS      980.77 seconds
MakeCheck                     PASS      11.74 seconds
MakeDistcheck                 PASS      149.00 seconds
CheckValgrind                 PASS      244.73 seconds
CheckSmatch                   PASS      325.49 seconds
bluezmakeextell               PASS      97.76 seconds
IncrementalBuild              PASS      831.42 seconds
ScanBuild                     PASS      1014.14 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] shared/bap: Fix scan-build warning

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	                                ^~~~~~~~~~~~~"


---
Regards,
Linux Bluetooth


--===============0755730680081298899==--
