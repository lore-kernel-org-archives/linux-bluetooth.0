Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B795C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiKREnx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKREnw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:43:52 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFFB5B85A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:43:51 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id d8so2709228qki.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e3wfTuvhK/ZlroHrQEEgucGyeBlOOGizjB5HVEHVKcg=;
        b=cpzpqXi+zGtWpuO6fToDEmTAuvvxU0DAgqKx5lTC7d1oljnFXOB+zEiYcB2WgzldiK
         PysRkSyUqC7rLh7uOnFZptiG99oMUPj+SHEYiLTsibLhG83dL5rUk495N1EhzuGA2LVh
         ZNaCAvqZNLsSmlLxmcIeLK+vvev66mULpv+ZU+7jKScXcl9jATZbFm+ldA4+mhr3V/Zg
         Rist0VRkhoIzO+clJPqifwciy9OLN6C0Vcvz9rFo1+AjPIN1wNg76EDui4Ezgu2tcnt7
         fRrdBVZFYYDdpMbHs+ePEJ15Do51CsiaO4fm8o81y9yJDcKzDYPO3JYCf5zLCYOfoCoV
         RegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3wfTuvhK/ZlroHrQEEgucGyeBlOOGizjB5HVEHVKcg=;
        b=HRfAxtwZISstW1tifEFWv1qb0lQOOqSN1kaPG8UxVTkasIArG9BEK+wSiqZG3qk19L
         a6OOKvSfTO6zasjk/QjUtWGMQDlI1jC4iXAEcDNGNAwjXddij13JRnYa5K9izzzc56bK
         IuSfYW4r1sofvmwFMMN/MWdodC8aNu8L6TeYi4yPIpw1hnOda8ChoXCYzwhbfgSY9pwn
         nflAAm6NcpM7GXwCorY+gjQ0RpCgKqrJKvM9+e7/OEmDaRdtsdiHKrav/9L/1upV1M8Q
         w4FHnjsLWcG6IQdbgvX0eB/aCpvh1MfKqPVy7WKQ44GHP0vt7b3brsyxd7pzVCwPSeZ4
         ucHQ==
X-Gm-Message-State: ANoB5pmFWzOm3iyiTTfe5RWx3SnbizFx5IeSP/XX4Vqe6UcbZi4iVLR/
        qGy3GjFsV1NKVfGiMEZbLqHeWiavgYIalw==
X-Google-Smtp-Source: AA0mqf4s8naR+pRMhUkBejRGUA5FK3WICZkRS4OhwDrE/z0ltmxq4/3nUBchlruwnoCK+V6g1w9ZbQ==
X-Received: by 2002:a37:607:0:b0:6ec:56df:12dd with SMTP id 7-20020a370607000000b006ec56df12ddmr4512115qkg.124.1668746630379;
        Thu, 17 Nov 2022 20:43:50 -0800 (PST)
Received: from [172.17.0.2] ([20.114.228.7])
        by smtp.gmail.com with ESMTPSA id de36-20020a05620a372400b006fbb4b98a25sm1776568qkb.109.2022.11.17.20.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:43:49 -0800 (PST)
Message-ID: <63770d85.050a0220.7dcee.97ce@mx.google.com>
Date:   Thu, 17 Nov 2022 20:43:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7290245750849075065=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
In-Reply-To: <20221102101224.1463549-1-hadess@hadess.net>
References: <20221102101224.1463549-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7290245750849075065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691153

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      26.43 seconds
BluezMake                     PASS      752.95 seconds
MakeCheck                     PASS      11.16 seconds
MakeDistcheck                 PASS      146.54 seconds
CheckValgrind                 PASS      237.86 seconds
bluezmakeextell               PASS      93.74 seconds
IncrementalBuild              PASS      606.42 seconds
ScanBuild                     PASS      959.27 seconds



---
Regards,
Linux Bluetooth


--===============7290245750849075065==--
