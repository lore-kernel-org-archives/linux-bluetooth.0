Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7974C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 15:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjC0PTk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0PTj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 11:19:39 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F910F0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 08:19:37 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-177b78067ffso9605498fac.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679930377;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nWcDhLz7xTdPO5DEIqO7DKr+ztqTl6snpZYhjOQzpLQ=;
        b=bGYXLu6DbLkkFXWhi8BIVtVCTqeWBVtbr/+EmpBGvSm7a9T6wBniEBVbeQaG2/OfF8
         0On8tYxqb35y8BkITbF8KhH6kxtUUh1Re/4jbEZQxpdFAbRLuhQVnZ08/71bqOJVh2P+
         ThqT0vDYHzWwwt9tAMkpdwDAdtN/ZyjbilGb96IXBJA/lBGju/c3vzpQMfMDF80u6Ul4
         aQYmDzly//pIa6FT6Fj27cvgA1bR4MckHKAcAGKCujY2zCG1+l79IQDozsp3qqLIjTR6
         zOGtX59Vhcmj4RT4PKq+bT766htKnD93PvQJbLZzZZFmsnnLys9TFYN955FWP/lJ5mgU
         MYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679930377;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWcDhLz7xTdPO5DEIqO7DKr+ztqTl6snpZYhjOQzpLQ=;
        b=5RrKAMARem8kQ7l41MhYIHJFu73cYg78T5f6eRge6jJ1neNUzvV+6D59y6C30TQ/+8
         p2e5uMN4UbaSJ1fqmDPKe1y/tzKJVsG4l34dNH6UWMkGaHkwXz838rLak7jwDAageM9m
         oyFas+SbSqfKpfbb3WczzzFjizQOmfPrVRsO2aU/L958gsS5Y9toxQ4pvuNRPj+Ipoa9
         Do2vj6gE56ez2R/hBr5Iguq0+DjS4RExT59coAqiaXS5TvSRMvtMCgrU8iYMIiNLAvfd
         kyhyFb13uw8xnQlw4rEcJs/yMmvVETMkuxCKXqHE1c72d1zACdEr8N5IpHivzm1E4IdT
         cwmw==
X-Gm-Message-State: AAQBX9eHmoQDMuehjkK6UH6qit6HA8/pQdL8eGDHvUwsNNtXKXFH8iwX
        +jOO5cFb6qm2x5Pe/1QxlUOUEnM1C+w=
X-Google-Smtp-Source: AKy350ZR+9/oxvuzLgUwVagortqLN2Sn4tRYx+Z5NZD1zUpnFKFo4lSbvFsAPBjSA5vMT/pfRMm4Dg==
X-Received: by 2002:a05:6870:64ac:b0:177:c2bd:3f70 with SMTP id cz44-20020a05687064ac00b00177c2bd3f70mr8597745oab.54.1679930377020;
        Mon, 27 Mar 2023 08:19:37 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.43])
        by smtp.gmail.com with ESMTPSA id a12-20020a056830008c00b006a11de6cd02sm3084465oto.34.2023.03.27.08.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:19:34 -0700 (PDT)
Message-ID: <6421b406.050a0220.50f51.c3c6@mx.google.com>
Date:   Mon, 27 Mar 2023 08:19:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5205261470479043602=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Split bt_iso_qos into dedicated structures
In-Reply-To: <20230327134602.14340-2-iulia.tanasescu@nxp.com>
References: <20230327134602.14340-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5205261470479043602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=734180

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      32.25 seconds
BluezMake                     PASS      986.91 seconds
MakeCheck                     PASS      12.11 seconds
MakeDistcheck                 PASS      178.58 seconds
CheckValgrind                 PASS      289.54 seconds
CheckSmatch                   WARNING   384.64 seconds
bluezmakeextell               PASS      117.29 seconds
IncrementalBuild              PASS      821.51 seconds
ScanBuild                     PASS      1166.00 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:584:28: warning: Variable length array is used.emulator/bthost.c:741:28: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============5205261470479043602==--
