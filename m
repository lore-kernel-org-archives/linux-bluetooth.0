Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F79C64EDA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 21:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355476AbjHQV44 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355558AbjHQV4v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 17:56:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891CE35B1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 14:56:41 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a7ca8720a0so171125b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 14:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692309401; x=1692914201;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hejffoEm1P9CnlDW1UUh9C0SDtoryX6G38lQLYLH6LU=;
        b=I1Z8cNy485wUzExqu8vTf90/CUpGNZ+QeRHsHt4MTCOx4ue6shCPUSB+PoVG6Lhcas
         6ux6hxAsF0FhkbVh8jM9mmzalmAB/Cgj/lEWr5ddKqNWGvQvGStrrduQTnWQO3sV5N+h
         WjjV+h2q91g7VZFYCozrTj21KfSh5KtufKl7eKYf/0s6XWJAx1YTswKPx92rxGwpvxMZ
         Qwtrmx7IpHHKaGjFYN3nGTWShJBPrJjmZKveIPCYCSR1bnvRqvkcFyghuVAnFcD1cDN1
         OhT7FedyfhFLx2GCRl0x9U9qP0ZaRU/6JLhZBIaN3idEhKxqM0ekxRI4/+hWx8p2uePR
         v1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692309401; x=1692914201;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hejffoEm1P9CnlDW1UUh9C0SDtoryX6G38lQLYLH6LU=;
        b=gUABLEOJMfOqZJTWuPYmjkZ8/IhvN2e+QHZaiAlPf7aijFX3YXDZQth3lONbvycOgr
         LWt8xv50NVWow9nDFdHFu2R7QE6xpreBxg3m9RhB36T2GB0K/BTU6DCP8NNHAzVmuxfW
         iFMgVn6upeDHccPjSaLKrlqqgEXISvnjPL4MUfqqQ0LyDbrlVW5GYGS1Fa3vtYz6ksQv
         kNqwMZjZikcTGL/YLY7lpWXq/7dgW1bWEbbPQSn0A03qviqlnvWlIzBOzxbhDA3hD1zM
         PVFnaTvGWqaOIUNOzJ9oYdcAiY58mGyihs4QeK8MqhjLYDZUWaeuRcHGdqXpN5mhY6EL
         /sjw==
X-Gm-Message-State: AOJu0YyGV1P4SL271GoHcsjvOfs+yVPJQ7Ai4heRX4reBibsyZu5PLvI
        iDuKSEw5qvjYvxK/Yyn9MQZ4dW8JB3s=
X-Google-Smtp-Source: AGHT+IEsvWYmxd1VBWMcYfTA3dZwC65a8cbuc83v6IgIXRMU9PJBhCV9Gc3bCLAtnOB/9hlivKqJnw==
X-Received: by 2002:a05:6808:288e:b0:3a7:6ddd:5045 with SMTP id eu14-20020a056808288e00b003a76ddd5045mr700580oib.35.1692309400683;
        Thu, 17 Aug 2023 14:56:40 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.79.50])
        by smtp.gmail.com with ESMTPSA id dq25-20020a056808429900b003a77e3c4b75sm279537oib.47.2023.08.17.14.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:56:40 -0700 (PDT)
Message-ID: <64de9798.050a0220.8e635.1f4b@mx.google.com>
Date:   Thu, 17 Aug 2023 14:56:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9096750345964125912=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] profile: Remove probe_on_discover
In-Reply-To: <20230817201401.3001315-1-luiz.dentz@gmail.com>
References: <20230817201401.3001315-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9096750345964125912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777134

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      33.26 seconds
BluezMake                     PASS      1193.14 seconds
MakeCheck                     PASS      13.26 seconds
MakeDistcheck                 PASS      190.50 seconds
CheckValgrind                 PASS      318.08 seconds
CheckSmatch                   PASS      442.40 seconds
bluezmakeextell               PASS      131.80 seconds
IncrementalBuild              PASS      1025.37 seconds
ScanBuild                     PASS      1398.95 seconds



---
Regards,
Linux Bluetooth


--===============9096750345964125912==--
