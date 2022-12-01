Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58458C4321E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 17:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLARQS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLARQR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 12:16:17 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2074DAD308
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 09:16:17 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id l22-20020a05660227d600b006dfa191ca8aso2106389ios.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 09:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=plYXF82hxECzJupTtESUSwTyAMHuM1Iuv+MAxcmrm+U=;
        b=f6hWKN+c+INToy96CbQb1hX24nWCrNKfD6Q05wYoNqB93en0yAhbsIyVUodSUFZbOZ
         xreIkQX8H4idh5AWqTIMdf3Qw3QLLftlMToY8gYBcvt4NKT5s7zEbkg7LsspMNDzl0hJ
         uVmeHw9dyeXob/PD3fuxlfyNyMHI4QQwagRq4NhX2jGD6KGYTCBhXLovSkkGBMmAIhrM
         GuseS8nddLv2klTj8OfKeGVJlthpUwFSIubhdW7Ocx+cCHgMgggb5tX2K6gb0Q3jYMPJ
         4DPgEDEDogz8Tv+4lidcwGuf0KqRb6qJEku3NUGdK/7WHKP5hyBYx7BoXnkPQs0w8lAo
         labg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plYXF82hxECzJupTtESUSwTyAMHuM1Iuv+MAxcmrm+U=;
        b=3f9IU9thHMdyX21bYS9VcxKYtFV/rEj375m3z2GPf//GJUtWT2jqgAW9Jf1Z1YNEKw
         Paijp97ppE1h4ifIA7Jwg7VwuaobNXmvgxXeMVXCACjxjpKeH6GJC2X0RVZ8DGhJ6AXZ
         TfoaLEEDHIxcNteeSa8jPrT9l6xd4ABBhVTbbvIymUIcGxoRu+h9W1bhpWAE15Ih960k
         AdUY1baxU6EOMfa4Dz1JtxHXHhYAb+5bmieWRdQGdOfHeNKW3N5LwVtcL3y5ki+DF3Eo
         w7lffi/LlsRxC42hLlse1dsH9Przb5tZUcHE64ytIpV0eInSZ/qdDtzINPiw/Z3iEVkD
         FbvA==
X-Gm-Message-State: ANoB5plDPS4ijPKJMEIAPOpJHUrrMhZEXiVqPMmMlie1Tn5xcNxtcUpg
        gfW/vxKGcolLwydx8rZMzzdiR04xfdESb+h9U/na933i5ZNV0cUAeNmdMYGYZsP4SJfywiJD/CQ
        g2oP59XgcSKARZ71M1O8ruSeiWdjHIKWZuojtCHMO+ICCcki9Ojbi3A7klOAfTY7TEjD/DNuZA5
        ghz3B5QA==
X-Google-Smtp-Source: AA0mqf71IQSM1Hxc2MCyGIX/93aeGGC7ucBIXM3MSVb2sL7pf5iFGdz0JLA0wnP0odURhOSun+xYNcszbmx0jTs=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6e02:349d:b0:302:f487:4837 with SMTP
 id bp29-20020a056e02349d00b00302f4874837mr17050467ilb.76.1669914976528; Thu,
 01 Dec 2022 09:16:16 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:16:12 -0600
In-Reply-To: <6388e0a6.020a0220.7a53b.4ef2@mx.google.com>
Mime-Version: 1.0
References: <6388e0a6.020a0220.7a53b.4ef2@mx.google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201171613.1819631-1-allenwebb@google.com>
Subject: [PATCH BlueZ v3 0/1] Fix git lint error
From:   Allen Webb <allenwebb@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This version of the patch removes the trailing punctuation from the
commit message.

Allen Webb (1):
  bluetooth.ver: Export sanitizer symbols

 src/bluetooth.ver | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

