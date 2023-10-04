Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFD9E7B5E1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 09:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbjJDJZZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjJDJZY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 05:25:24 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C98A7
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 02:25:22 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7741c5bac51so126822685a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Oct 2023 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696411521; x=1697016321; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ciMRzpAxa/FuvUG+5wz5t01tXeYPxVZMvz5bzB1ZvDI=;
        b=EAi7IRvTUDRdQ/9G8bIJBHspcc8dEDyXMqEHX8LIa8vvah8fBu7uZVKw1zWgWBQ+XO
         sPfHZfUJHQgHg7VBsvFHDXbJd67ZAKeJ5iep74hVt+GoULhbSfJf4ItWHqvlWDv7/b0J
         Knlrd9sYS45yFWV8wuw3NPKUvewvWHpSfxWD0hNe4QHGpIh0xKf7ZIQ5cAdCMejQrPGu
         pSU0e+rayfFL6eSjKEnWbjF2oZAc+XL8lNL9GF1yXTMqFmjkCQBvF13j2cVbF47MrOxz
         CDYYAcc8OVrS96JygtEuF/YHe8lgCWcjyUrWy7hByx5TXWm7GfIJ9Lnl2piwmFezkxQN
         S2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411521; x=1697016321;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciMRzpAxa/FuvUG+5wz5t01tXeYPxVZMvz5bzB1ZvDI=;
        b=Z/bf7TfbZMBw+SgoCj+V9bwEFA7RBihrtfpXUlZZ1MOmfBRRzCU9LKDK1gz/qjbiMw
         0Ht10fHryJgsZqAzMc/5NMAClMt8Oyehl7Rh/sS9IeBBfWnnBWaOy1lfC7uirSAXKD2L
         LonxbZsmOisXqXDBbuKAt8OPQTkfM6V0FLzB7BDNTERmvxm+xASBg2rgnHnxEDZ3B8Kg
         jVuGYIvSxaFdje9tgFH6uXCxP1zJBPXGM3R1KGpXOQopBzdMa1fnEmtTMyj9MDz18s0o
         e13PQLqQipp/H1VbKEhKjQtRBzW6yeTRXmXGl0usOTqJhKydzYf2IkTtxstb/vSpd5bP
         Qn9Q==
X-Gm-Message-State: AOJu0YwCUNGi34EHg4GeL/ywj+RG4awxB4bwUNRkDF9z8zLDjQbDeby9
        BKZCAZ4c0Kn57WjwzJekLaAabD+OqlI=
X-Google-Smtp-Source: AGHT+IHARBk8MQSeuTQhDSvE9uiBNQDyvHSEq6zgSJ0xrtQEz9D2Sfqs8cPOeUOA5HbgL6lj+dst3w==
X-Received: by 2002:a05:620a:2907:b0:775:c5cc:7ce4 with SMTP id m7-20020a05620a290700b00775c5cc7ce4mr2038808qkp.13.1696411520787;
        Wed, 04 Oct 2023 02:25:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.68.52])
        by smtp.gmail.com with ESMTPSA id d15-20020a05620a136f00b007756d233fbdsm1133742qkl.37.2023.10.04.02.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 02:25:20 -0700 (PDT)
Message-ID: <651d2f80.050a0220.aa9b3.571b@mx.google.com>
Date:   Wed, 04 Oct 2023 02:25:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6008508898307786200=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Update transport acquire/release flow BAP bcast source
In-Reply-To: <20231004075646.4277-2-silviu.barbulescu@nxp.com>
References: <20231004075646.4277-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6008508898307786200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789831

---Test result---

Test Summary:
CheckPatch                    PASS      1.12 seconds
GitLint                       PASS      0.70 seconds
BuildEll                      PASS      27.88 seconds
BluezMake                     PASS      774.89 seconds
MakeCheck                     PASS      12.10 seconds
MakeDistcheck                 PASS      160.36 seconds
CheckValgrind                 PASS      257.00 seconds
CheckSmatch                   PASS      349.02 seconds
bluezmakeextell               PASS      106.28 seconds
IncrementalBuild              PASS      1308.43 seconds
ScanBuild                     PASS      1032.29 seconds



---
Regards,
Linux Bluetooth


--===============6008508898307786200==--
