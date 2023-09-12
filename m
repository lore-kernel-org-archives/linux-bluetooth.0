Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A031CA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 02:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbjILCgD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjILCfz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 22:35:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F44E7409B
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 19:00:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fb2e9ebcdso1516905b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 19:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694484033; x=1695088833; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AD2QuMshIUiu5Tx1p5pGZE8kI45L9tlGDEdY+O9ybdM=;
        b=eZ8Y7CX2LYuYQiH2PVvAsXgIFoPN/rYPmds2p7wKrksd28m5HaTuzEuTA5T5ESD6Pj
         ZegcR0ikzfL3HYgwzyLYbwSYH6oOv4kLPWZ5PjTpz5iCsOz8VTZwKdVXPxS/xzE6RAa2
         Gyrp3PLvzL81STz3JWqpRWwKlPeAR2tAUjj5i9ZQ2n5IRfHTpRtmWxhjulzy1x4sFWMH
         Q5I4LS4bNx22UIz4kJTSKGYPhdNMGS6iBgLqEv02hA3BBO0FKxTw6rfmX9esjmXtyscu
         MgHkQH2C30BcnCKrygtiL2M0U0blfGd78zdD90IsmwwMnTVqBeV93AapvDTzH6htge/l
         7ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694484033; x=1695088833;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AD2QuMshIUiu5Tx1p5pGZE8kI45L9tlGDEdY+O9ybdM=;
        b=ktsHAZDeN7FXJNMOSfjys9PtzKgmU1eqn82vwWFju+hZicDs04HhxEXB2A1czMFyj1
         XnGo4SswBM6XN0tnWqvkJJbwz8b7MwrLlTkl0VINXBEgsqn5s35FqJI5oiMzEZXbWNAI
         5SkOspHw0rILu7DI0BH7Qhn8V+alsvFuaOG15cFee75n+45jyJZMRreSfUbBK2Ua/Uog
         rKXiUkJXFol85P/tqavU+jvP3Esu8V3IyvZ7hm/9cRnPOy4n0OWUrdOYQcIQXKuzolIC
         ovPvrXPxkqy5cEwyYrduAW2l7+wyevF/2ZpRedz3K9+m5WKoEyyjrRtBgpmi76wG3Zxv
         E3ig==
X-Gm-Message-State: AOJu0YxDM7uvyyDWy4mbrLdKcoNvxBIUL/MOrfTJY+BoIBPzb46pffn4
        NePV8sH4STzQjiMo3euCV3AN4/xQpd7o+w==
X-Google-Smtp-Source: AGHT+IEN+fMpn1IqBYSCdiiiFRf+GVLiViV9fkpsIRd7Y2uzJ/8zA6WvLCowcDIhtXQEp1tiAGkNDQ==
X-Received: by 2002:a05:6a00:2191:b0:68b:e18f:2eb6 with SMTP id h17-20020a056a00219100b0068be18f2eb6mr9413235pfi.30.1694484033110;
        Mon, 11 Sep 2023 19:00:33 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.34.213])
        by smtp.gmail.com with ESMTPSA id l14-20020a62be0e000000b00686dd062207sm6121740pff.150.2023.09.11.19.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 19:00:32 -0700 (PDT)
Message-ID: <64ffc640.620a0220.b3b4f.0f41@mx.google.com>
Date:   Mon, 11 Sep 2023 19:00:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6548885369577276216=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] main.conf: Fix parsing of uint32_t values
In-Reply-To: <20230911205447.2689657-1-luiz.dentz@gmail.com>
References: <20230911205447.2689657-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6548885369577276216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783189

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      30.30 seconds
BluezMake                     PASS      990.49 seconds
MakeCheck                     PASS      12.41 seconds
MakeDistcheck                 PASS      166.24 seconds
CheckValgrind                 PASS      267.46 seconds
CheckSmatch                   PASS      374.40 seconds
bluezmakeextell               PASS      111.83 seconds
IncrementalBuild              PASS      871.01 seconds
ScanBuild                     PASS      1167.57 seconds



---
Regards,
Linux Bluetooth


--===============6548885369577276216==--
