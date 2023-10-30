Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785D2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 17:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjJ3R0c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 13:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjJ3R0b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 13:26:31 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD97B7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 10:26:29 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d09b6d007so33623456d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698686788; x=1699291588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DWZW+AHpKf+uAdyfZdkdgMZxabsOkxaoM/JykuwqZLc=;
        b=PAyoBNozjl6sz0z65UEjuma+v0gh93xb2xAxao4MlQr8cDJI2jLzDlUEa/6pL1Azlb
         9sqy4rDDYBIQP8+EQrSmMUfiXVsnorlV4lWQZmpebq3i12G4lAhv5gY+Q3ccxP37H/nG
         GBCzSpbAoWQDIwxAqK3mz5fFaTp2DNkDcVDQeNTg7fza6jXqXQ0F+LiBvi714vO6zSGB
         W/FIlfLKnxGNnw0Kqfnqo2UpyIyTP78MdNILicJOKvy+0vXVNuJY6SRnzSiRhri+vjmE
         FVjiSPZuoDI2mT0ROVls+tsPracOT4F604hlpbiXU1zuKm/ECcloKSp312npwVuDuvnA
         AbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686788; x=1699291588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWZW+AHpKf+uAdyfZdkdgMZxabsOkxaoM/JykuwqZLc=;
        b=cdkWZJ7DvHlpz+q6hgb9yRznrICCo4QIC4//iW5Sbm71rJkERJbF1Rzfzrns5l3E7b
         l9cSj22dLETSOLPrqG++aGQkOPP4DNFGSQnHO0PFVKkTSd/Fs7aKzcLfe1lgu25b6ZHS
         R0gH62NlZqcWyKsc9w/njOuL9Mu90Na5oU8FNUaXXo6KpSyly/7mMeR2IVzR3epEDMED
         U1SJr4EySNiW9QZiOKUQ7XbMueCeyApmYYZwD3+rd8gGuoJf5P38bUJqpDZRWbvv9+u3
         DePB1bLkBYVPWCi9mi6MQpt6xXhHMHcBXdHAU7DN8ahbFAZVVTAbkIeW/X2d99YesqFh
         5p+Q==
X-Gm-Message-State: AOJu0YxFjpHKkMemTzJGR9OVo1UfCyf0EhcU6ZbjXJFmdEh7rNlcxh1X
        Uxh3tT37cQ3J/8shYc5XJu+2JZT7GUY=
X-Google-Smtp-Source: AGHT+IGk0Jip9WL9vt74c8Ltm3UrPBBsmNt8/lauDN+NrviACJ1bvDdKTuUBmqy6a+i6vhWoXHudCg==
X-Received: by 2002:ad4:5767:0:b0:671:188b:7367 with SMTP id r7-20020ad45767000000b00671188b7367mr6856812qvx.65.1698686788426;
        Mon, 30 Oct 2023 10:26:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.209.218])
        by smtp.gmail.com with ESMTPSA id bp16-20020a05621407f000b00670a31f77b4sm2718219qvb.93.2023.10.30.10.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:26:28 -0700 (PDT)
Message-ID: <653fe744.050a0220.57739.7cdd@mx.google.com>
Date:   Mon, 30 Oct 2023 10:26:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4272680431489821762=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for bcast AC 13 reconnect
In-Reply-To: <20231030154913.4442-2-iulia.tanasescu@nxp.com>
References: <20231030154913.4442-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4272680431489821762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=797655

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      32.28 seconds
BluezMake                     PASS      972.17 seconds
MakeCheck                     PASS      12.97 seconds
MakeDistcheck                 PASS      198.74 seconds
CheckValgrind                 PASS      311.27 seconds
CheckSmatch                   PASS      409.65 seconds
bluezmakeextell               PASS      134.66 seconds
IncrementalBuild              PASS      819.26 seconds
ScanBuild                     PASS      1230.74 seconds



---
Regards,
Linux Bluetooth


--===============4272680431489821762==--
