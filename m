Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C66C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 16:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiLAQPJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiLAQPI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 11:15:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2691D8C45F
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 08:15:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b17-20020a25b851000000b006e32b877068so2085036ybm.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 08:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5H35NgrcM0mpJmFPsBENZMkUgzekiOSDz42lfIBqg8=;
        b=tIYXKDqj/WsBHKrnlw8U9QuCvwrnzThRn+jF3tmEeVe7goIj/C7d5+yhCBsTjWIixh
         PfxX4orgbS7uNZ4nMIsc9nHGH3VcdKhGaw/37meyRZNsaWf2xy28faV85L0eHvwCniaL
         1GnwQfSRZr5P13ImC9bCKPoWaTz43JoqEH1J+v92/cdyfKrL+jIlNW+ydYa+ad01cGlf
         3HP4HiFG4xIvb0Qlpqw3pbm6m/BimclQSvI3n7VtsRGLFf5Dujd3WPdQtBN2CXRoIA4z
         UqqLus1TLAz5xPDAUyGrIBPPp3iL2fgrdKGyqwUOwUC2gONf/1mnuZBZkgPBax/ukjZF
         uFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5H35NgrcM0mpJmFPsBENZMkUgzekiOSDz42lfIBqg8=;
        b=XyFxwRVSH00v5obnHyKHXz3vtp7OgNsHmIZy0e3PvOSV3mX9JHh+rDfSy9XUFASFVU
         O8X4YmerXBnBg3IVTTTcrDHZVq5GPK2P2Tlfatu/YYK4/dWk1ueeVx/630+xZDe05wgJ
         7qAsT89A5ngSL3T8qSPIcWSJcqwT5XA5x7OdNUsKlXUtdRgzXcw/E2bi3mz/vWmh9Tob
         NeN/bag7UxNW09Qy/NUmQOfDNMgcT79y7iU9BUmqPtD7Ff6lQSYXw+WVDwOfnpJj4yzP
         bAxIInFoEeiubVw1BUHRMYh6Yhj6C/8SgE71KPypof1keabbLr/g2gBTSolrzCxnRuUP
         NM0w==
X-Gm-Message-State: ANoB5pkfqPYciPxBNPHASPSMWk94+b9C53DSq1S99CNCbYbRygNEerlf
        UcFUgsy4hQhVJKvzH1XbJfpwWh4llIiCRNARHU8gnbjop3B7JeCM7tbUDs3mBvZDBmiHQuWpYxx
        q4KPzcid0AyAnZQ6PcZg7b2vPWarEw3cBEHse0lyzYdxVA4q5rjczZC/2yvOXb747hKqFwkEXnZ
        P2VxjbgQ==
X-Google-Smtp-Source: AA0mqf71j2WVc/7FWA8qE4HJNVoDCwkVhdK0qKmE3FQNGPkY48jHnnRKXZB8oz7lLjzXeB+B2kv0ArbZDYNyO64=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a25:848c:0:b0:6cf:f51a:99ef with SMTP id
 v12-20020a25848c000000b006cff51a99efmr46370135ybk.466.1669911306425; Thu, 01
 Dec 2022 08:15:06 -0800 (PST)
Date:   Thu,  1 Dec 2022 10:15:01 -0600
In-Reply-To: <20221201160941.1065499-2-allenwebb@google.com>
Mime-Version: 1.0
References: <20221201160941.1065499-2-allenwebb@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221201161502.1067068-1-allenwebb@google.com>
Subject: [PATCH BlueZ v2 0/1] Add missing sanitizers.
From:   Allen Webb <allenwebb@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This includes the additional sanitizers not in the original ChromeOS
patch.

Allen Webb (1):
  bluetooth.ver: Export sanitizer symbols.

 src/bluetooth.ver | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.38.1.584.g0f3c55d4c2-goog

