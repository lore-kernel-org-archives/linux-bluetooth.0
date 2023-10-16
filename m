Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43024CDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 17:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjJPRTX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 13:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJPRTW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 13:19:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902CAE6
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:19:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9bca1d96cso30957255ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697476756; x=1698081556; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9JU9oobqCvhHGlf4pijkeZK3KDcluAE9vC704FeRt5U=;
        b=mdlIALE680GuLnoBpN9kVWKagXz1vAwTLMa5BTLfk5WVM8x3a+Vmjxj4K0sNbDVyEJ
         Mo7v3quWwjOpWylWA1W9+/rF9TRNYLMnhREik60jaG/CSr2bX/2YFGDbT9PYru0F3I9M
         WHrfgAQJJZTbUR5IR/EpCbHPKXuvt9/BLgVoy00E9gW63eEg5aorMmZV4fK2a76RhM1K
         xoFgK/rge+h0B0Se5t86/WPRxqXOY0TDc6M36haFtgPXdt+KphFgzeLAfESXk/kSnlbA
         WeQmxVqxYWeSXnGDX0mRTsjuZYSsKkeIMk8jhvDh91bu7OHfF9GSVPKyyIGgv+paEmoc
         UJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697476756; x=1698081556;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JU9oobqCvhHGlf4pijkeZK3KDcluAE9vC704FeRt5U=;
        b=IjhAdQgpqwRCWGRL9CG/hdigk2NSvLSGbm8JVZqiI1EYOfWazDhQtZs1RSYwP8FyWP
         7O+EklJ5z/o3lyCP7siV3WwKbwim5kJ9RrZGu2YtvQGaZv8f+AtnqBtyqmP86mrOW13a
         NDRWtY6i05O76jhP6zO1edh9Iuzc+NCbe5uGxaR/kZBA9Jt2UOlJwaNEQ+R5TfPbQgNi
         8WrfTl/n/qXLmGcGD3FQy4zNNcH6YZLzbKCtRjJh0zvio4Vs7LD3WJixP5di212/D9gG
         dc1CfcUp/zHv9WCAkFZZ+dJ34U7pxJ1BOhtL8QsI91vOKK4Q0OraNJyDR5B5Q4UHQMn3
         TkHQ==
X-Gm-Message-State: AOJu0YwYZ4O77DkqQgTX2j5Is/LtQIkDLEU8gvBRXOHlquQtHE586iYp
        TSE/2Cz/wX1gIQxQJf1bLYDtmO4vYcY=
X-Google-Smtp-Source: AGHT+IETuwGqYmPTPIm6A7rUMXpZyzxRLiVVFtMUlQ4Ycbqj+s6KFGl2VPkKtzCUo7e8bUpT8tybEw==
X-Received: by 2002:a17:902:ce92:b0:1ca:59bf:6cc9 with SMTP id f18-20020a170902ce9200b001ca59bf6cc9mr3361945plg.57.1697476755744;
        Mon, 16 Oct 2023 10:19:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.80.54])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b001c78446d65fsm8934290pla.113.2023.10.16.10.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:19:15 -0700 (PDT)
Message-ID: <652d7093.170a0220.979cf.bf69@mx.google.com>
Date:   Mon, 16 Oct 2023 10:19:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4343467693067956379=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for bcast receiver PA bind
In-Reply-To: <20231016154749.3016-2-iulia.tanasescu@nxp.com>
References: <20231016154749.3016-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4343467693067956379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=793606

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      28.44 seconds
BluezMake                     PASS      843.08 seconds
MakeCheck                     PASS      11.77 seconds
MakeDistcheck                 PASS      177.99 seconds
CheckValgrind                 PASS      271.57 seconds
CheckSmatch                   PASS      366.01 seconds
bluezmakeextell               PASS      117.85 seconds
IncrementalBuild              PASS      725.84 seconds
ScanBuild                     PASS      1100.28 seconds



---
Regards,
Linux Bluetooth


--===============4343467693067956379==--
