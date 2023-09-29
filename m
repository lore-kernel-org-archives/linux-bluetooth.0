Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01148E728CC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 17:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjI2Rin (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjI2Ril (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 13:38:41 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F1CF5
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 10:28:58 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-49040dc5cedso5516155e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696008537; x=1696613337; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xYywyKa19YLjfKbNEYbxlOxmDJfb0PD6Yi+sQ7JET3c=;
        b=SAQMbf4+U1Nu2QYjXZwsQf5qUxGXyfbIzU4Zs7rc2Y5mmM2oW3Gtj5NvfF97zjRTEX
         MZncpmuSit9yebMVTfxrrehI7CqtKLpq8udc+ay2HluLXC22dQKV0BZkT4aQf8MPWypu
         5IJg3cC5KTcsQtZyv+fhY12m9trsfwbLE+irAeKQ4kxjhbDgd+gzunjoJtwTl8qC9CFX
         FnngGEUUnffdxU+DFgZFlDBgUfbNS8WIrNses/IdRL/Bt3cHQJSdihGmQbmrjHCkHoBS
         cE1J7NiVGx7kzUfDp6pbEv1iXObpcKE1g5oh20tXLB92Bu7dQq9UPTeCnxtbwsN2nE5B
         SaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008537; x=1696613337;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYywyKa19YLjfKbNEYbxlOxmDJfb0PD6Yi+sQ7JET3c=;
        b=hXSdbxknayUxxrRPSGTnqpw1+ToE9vNa6L4pMSI+gctt6Mjg94flLk2ua+HN6fW3QU
         ORZXkSNTu7+a6szvwVC5DggrYHbM8pQzawnm7l3diKbWqJdG9n/QqMSm5YMIWPJ2G2xP
         EdBD3dpsgaUuz5olI0gdDwdBWKHRKVvIlHdcYCCv2kvFcM7xx/V4uKODtH7lj3Sw5eUP
         4hVIEtnAzbCNnxEKPcEw+nj/uF1XBNFNEiVklsVbFndQr8GPqyizhbW4I9pT5J6txvAx
         55BDcviRd06YXMvOLQoMYeQ7d3rwQWbARwLMSTEpEkR/BFWje+9B/qxP/30Pac8ze1Ky
         YEUw==
X-Gm-Message-State: AOJu0YwLdUqpz5LD8Z5JyPk0oJ+b6+QE9MW/I4mh8k97UY6cq13RG/Jy
        se8eb8YskGs5B8JIHYu5HsJd3vLT0G4=
X-Google-Smtp-Source: AGHT+IG82Fq89NuP2t1RQ0QPT2yshvadKrtY5oeNOBtV+6SjkNI0Y/jKp7f8Ekib4VbqMpFdefi4jw==
X-Received: by 2002:a1f:e3c4:0:b0:49a:b737:4df7 with SMTP id a187-20020a1fe3c4000000b0049ab7374df7mr4487089vkh.5.1696008537383;
        Fri, 29 Sep 2023 10:28:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.41.139])
        by smtp.gmail.com with ESMTPSA id w3-20020ac87e83000000b0040ff0e520besm6970031qtj.35.2023.09.29.10.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:28:56 -0700 (PDT)
Message-ID: <65170958.c80a0220.30ebe.c6af@mx.google.com>
Date:   Fri, 29 Sep 2023 10:28:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3935823532666915494=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for bcast AC 13 BIS unset
In-Reply-To: <20230929154421.3820-2-iulia.tanasescu@nxp.com>
References: <20230929154421.3820-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3935823532666915494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788861

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.41 seconds
BuildEll                      PASS      34.53 seconds
BluezMake                     PASS      1025.19 seconds
MakeCheck                     PASS      14.25 seconds
MakeDistcheck                 PASS      201.02 seconds
CheckValgrind                 PASS      317.96 seconds
CheckSmatch                   PASS      422.61 seconds
bluezmakeextell               PASS      131.40 seconds
IncrementalBuild              PASS      835.38 seconds
ScanBuild                     PASS      1311.41 seconds



---
Regards,
Linux Bluetooth


--===============3935823532666915494==--
